import Foundation

protocol APIClientProtocol {
    func getHeroes(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void)
}

final class APIClient: APIClientProtocol {
    enum Constant {
        static let privateKey = MarvelKeys.privateKey
        static let publicKey = MarvelKeys.publicKey

    }
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getHeroes(offset: Int = 0, query: String? = nil, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        var params = authParams()
        params["offset"] = String(offset)
        if let query = query, !query.isEmpty {
            params["nameStartsWith"] = query
        }
        
        guard let url = buildURL(endpoint: "https://gateway.marvel.com/v1/public/characters", params: params) else {
            completionBlock(CharacterDataContainer(count: 0, limit: 0, total: 0, offset: 0, characters: []))
            return
        }
        
        performRequest(url: url, type: CharacterDataContainer.self) { result in
            switch result {
            case .success(let container):
                completionBlock(container)
            case .failure:
                completionBlock(CharacterDataContainer(count: 0, limit: 0, total: 0, offset: 0, characters: []))
            }
        }
    }
    
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        let endpoint = "https://gateway.marvel.com/v1/public/characters/\(heroId)/comics"
        let params = authParams()
        
        guard let url = buildURL(endpoint: endpoint, params: params) else {
            completionBlock([])
            return
        }
        
        performRequest(url: url, type: ComicDataWrapper.self) { result in
            switch result {
            case .success(let wrapper):
                completionBlock(wrapper.data.results)
            case .failure:
                completionBlock([])
            }
        }
    }
    
    // MARK: - Private Helpers
    
    private func authParams() -> [String: String] {
        let ts = String(Int(Date().timeIntervalSince1970))
        let hash = "\(ts)\(Constant.privateKey)\(Constant.publicKey)".md5
        
        return ["apikey": Constant.publicKey,
                "ts": ts,
                "hash": hash]
    }
    
    private func buildURL(endpoint: String, params: [String: String]) -> URL? {
        var components = URLComponents(string: endpoint)
        components?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
    
    private func performRequest<T: Decodable>(url: URL, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        self.session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(error ?? NSError(domain: "EmptyData", code: -1)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
