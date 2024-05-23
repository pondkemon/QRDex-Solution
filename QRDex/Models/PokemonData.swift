//
//  PokemonData.swift
//  HelloiOS
//
//  Created by N648006 N648006 on 22/4/2567 BE.
//

import Foundation

struct PokemonData: Decodable {
    let name: String
    let detailURL: String
    let id: Int
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case detailURL = "url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.detailURL = try container.decode(String.self, forKey: .detailURL)
        let lastStr = detailURL.split(separator: "/").last(where: { Int($0) != nil }) ?? ""
        self.id = Int(lastStr) ?? 0
        self.imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self.id).png"
    }
}
