//
//  ComicResponseDataModel.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import Foundation

struct ComicDataWrapper: Decodable {
    let data: ComicDataContainer
}

struct ComicDataContainer: Decodable {
    let results: [Comic]
}

