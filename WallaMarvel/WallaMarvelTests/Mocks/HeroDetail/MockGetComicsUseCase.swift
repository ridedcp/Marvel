//
//  MockGetComicsUseCase.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
@testable import WallaMarvel

final class MockGetComicsUseCase: GetComicsUseCaseProtocol {
    var executedHeroId: Int?
    var comicsToReturn: [Comic] = []

    func execute(heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        executedHeroId = heroId
        completionBlock(comicsToReturn)
    }
}
