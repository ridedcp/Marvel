//
//  GetComics.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import Foundation

protocol GetComicsUseCaseProtocol {
    func execute(heroId: Int, completionBlock: @escaping ([Comic]) -> Void)
}

struct GetComics: GetComicsUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol

    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }

    func execute(heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        repository.getComics(for: heroId, completionBlock: completionBlock)
    }
}

