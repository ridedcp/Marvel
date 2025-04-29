//
//  MockAPIClient.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
@testable import WallaMarvel

final class MockAPIClient: APIClientProtocol {
    var receivedOffset: Int?
    var receivedQuery: String?
    var heroesToReturn: CharacterDataContainer?

    var receivedHeroId: Int?
    var comicsToReturn: [Comic] = []

    func getHeroes(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        receivedOffset = offset
        receivedQuery = query
        if let result = heroesToReturn {
            completionBlock(result)
        }
    }

    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        receivedHeroId = heroId
        completionBlock(comicsToReturn)
    }
}
