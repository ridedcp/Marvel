//
//  MockListHeroesUI.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
@testable import WallaMarvel

final class MockListHeroesUI: ListHeroesUI {
    var updatedHeroes: [CharacterDataModel]?
    var allUpdates: [[CharacterDataModel]] = []
    var loadingStates: [Bool] = []
    var onUpdate: (() -> Void)?

    func update(heroes: [CharacterDataModel]) {
        updatedHeroes = heroes
        allUpdates.append(heroes)
        onUpdate?()
    }

    func showLoading(_ loading: Bool) {
        loadingStates.append(loading)
    }
}
