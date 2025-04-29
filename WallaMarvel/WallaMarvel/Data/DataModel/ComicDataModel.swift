//
//  ComicDataModel.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import Foundation

struct Comic: Decodable, Equatable {
    let id: Int
    let title: String
    let description: String?
    let pageCount: Int
    let thumbnail: Thumbnail?
    let dates: [ComicDate]
}

struct ComicDate: Decodable, Equatable {
    let type: String
    let date: String
}
