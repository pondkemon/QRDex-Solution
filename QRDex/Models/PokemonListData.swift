//
//  PokemonListData.swift
//  HelloiOS
//
//  Created by N648006 N648006 on 22/4/2567 BE.
//

import Foundation

struct PokemonListData: Decodable {
    let count: Int
    let next: String
    let previous: String
    let results: [PokemonData]
    
    enum CodingKeys: CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.next = try container.decodeIfPresent(String.self, forKey: .next) ?? ""
        self.previous = try container.decodeIfPresent(String.self, forKey: .previous) ?? ""
        self.results = try container.decodeIfPresent([PokemonData].self, forKey: .results) ?? []
    }
}
