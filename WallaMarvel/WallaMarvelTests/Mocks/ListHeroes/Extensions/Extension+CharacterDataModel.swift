//
//  Extension+CharacterDataModel.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
@testable import WallaMarvel

extension CharacterDataModel {
    static func mock(id: Int = 1, name: String = "Mock Hero", thumbnail: Thumbnail = .mock()) -> CharacterDataModel {
        return CharacterDataModel(id: id, name: name, thumbnail: thumbnail)
    }
}
