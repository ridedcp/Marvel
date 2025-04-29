import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void)
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        apiClient.getHeroes(offset: offset, query: query, completionBlock: completionBlock)
    }
    
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        return apiClient.getComics(for: heroId, completionBlock: completionBlock)
    }
}
