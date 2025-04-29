//
//  MockGetHeroesUseCase.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
@testable import WallaMarvel

final class MockGetHeroesUseCase: GetHeroesUseCaseProtocol {
    var executeCalled = false
    var executeCallCount = 0
    var lastOffset: Int?
    var lastQuery: String?
    var result: CharacterDataContainer?

    func execute(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        executeCalled = true
        executeCallCount += 1
        lastOffset = offset
        lastQuery = query
        
        if let result = result {
            completionBlock(result)
        }
    }
}
