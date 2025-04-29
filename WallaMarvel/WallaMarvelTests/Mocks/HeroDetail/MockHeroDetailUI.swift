//
//  MockHeroDetailUI.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
@testable import WallaMarvel

final class MockHeroDetailUI: HeroDetailUI {
    var receivedHeroName: String?
    var receivedHeroURL: URL?
    var receivedComics: [Comic]?

    func showHero(name: String, imageURL: URL?) {
        receivedHeroName = name
        receivedHeroURL = imageURL
    }

    func showComics(_ comics: [Comic]) {
        receivedComics = comics
    }
}
