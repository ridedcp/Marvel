//
//  ListHeroesBuilder.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 8/4/25.
//

import UIKit

final class ListHeroesBuilder {
    static func build() -> UIViewController {
        let presenter = ListHeroesPresenter()
        let viewController = ListHeroesViewController()
        viewController.presenter = presenter
        return viewController
    }
}
