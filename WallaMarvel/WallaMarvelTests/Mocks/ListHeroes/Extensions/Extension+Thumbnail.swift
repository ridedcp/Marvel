//
//  Extension+Thumbnail.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
@testable import WallaMarvel

extension Thumbnail {
    static func mock(path: String = "http://example.com/image", ext: String = "jpg") -> Thumbnail {
        return Thumbnail(path: path, extension: ext)
    }
}

