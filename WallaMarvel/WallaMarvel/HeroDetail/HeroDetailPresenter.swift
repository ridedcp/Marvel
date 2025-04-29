//
//  HeroDetailPresenter.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import Foundation

protocol HeroDetailPresenterProtocol {
    var ui: HeroDetailUI? { get set }
    func onViewLoaded()
    func screenTitle() -> String
}

protocol HeroDetailUI: AnyObject {
    func showHero(name: String, imageURL: URL?)
    func showComics(_ comics: [Comic])
}

final class HeroDetailPresenter: HeroDetailPresenterProtocol {
    weak var ui: HeroDetailUI?
    private let hero: CharacterDataModel
    private let getComicsUseCase: GetComicsUseCaseProtocol
    
    init(hero: CharacterDataModel, getComicsUseCase: GetComicsUseCaseProtocol = GetComics()) {
        self.hero = hero
        self.getComicsUseCase = getComicsUseCase
    }
        
    func onViewLoaded() {
        let urlString = "\(hero.thumbnail.path)/portrait_uncanny.\(hero.thumbnail.extension)"
        ui?.showHero(name: hero.name, imageURL: URL(string: urlString))
        
        getComicsUseCase.execute(heroId: hero.id) { [weak self] comics in
            self?.ui?.showComics(comics)
        }
    }
    
    func screenTitle() -> String {
        return hero.name
    }
}
