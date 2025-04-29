import Foundation

struct CharacterDataModel: Decodable, Equatable  {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
}
