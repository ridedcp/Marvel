//
//  HeroDetailBuilder.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import UIKit

final class HeroDetailBuilder {
    static func build(hero: CharacterDataModel) -> UIViewController {
        let presenter = HeroDetailPresenter(hero: hero)
        let viewController = HeroDetailViewController(presenter: presenter)
        return viewController
    }
}
