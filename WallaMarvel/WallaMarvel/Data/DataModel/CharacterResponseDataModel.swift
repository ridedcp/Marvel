import Foundation

struct CharacterDataContainer: Decodable {
    var count: Int
    var limit: Int
    var total: Int
    var offset: Int
    var characters: [CharacterDataModel]
    
    enum CodingKeys: String, CodingKey {
        case data
        case count, limit, total, offset, characters = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.count = try data.decode(Int.self, forKey: .count)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.total = try data.decode(Int.self, forKey: .total)
        self.offset = try data.decode(Int.self, forKey: .offset)
        
        self.characters = try data.decode([CharacterDataModel].self, forKey: .characters)
    }
    
    init(count: Int = 0, limit: Int = 20, total: Int = 0, offset: Int = 0, characters: [CharacterDataModel]) {
        self.count = count
        self.limit = limit
        self.total = total
        self.offset = offset
        self.characters = characters
    }
}
