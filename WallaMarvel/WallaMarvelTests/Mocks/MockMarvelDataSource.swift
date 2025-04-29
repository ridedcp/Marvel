//
//  MockMarvelDataSource.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
@testable import WallaMarvel

final class MockMarvelDataSource: MarvelDataSourceProtocol {
    var receivedOffset: Int?
    var receivedQuery: String?
    var heroesResult: CharacterDataContainer?

    var receivedHeroId: Int?
    var comicsResult: [Comic] = []

    func getHeroes(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        receivedOffset = offset
        receivedQuery = query
        if let result = heroesResult {
            completionBlock(result)
        }
    }

    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        receivedHeroId = heroId
        completionBlock(comicsResult)
    }
}
