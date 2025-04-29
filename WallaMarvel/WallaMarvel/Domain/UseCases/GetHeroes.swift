import Foundation

protocol GetHeroesUseCaseProtocol {
    func execute(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
}

struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }
    
    func execute(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        repository.getHeroes(offset: offset, query: query, completionBlock: completionBlock)
    }
}
