//
//  Person.swift
//  StarWarsMVVM
//
//  Created by Paul McGrath on 1/22/26.
//

import Foundation

struct Person: Codable, Identifiable, Hashable {
    var id: String { name }
    let name: String
    let height: String?
    let mass: String?
    let hairColor: String?
    let skinColor: String?
    let eyeColor: String?
    let birthYear: String?
    let gender: String?
    let homeworld: URL?
    let films: [URL]?
    let species: [URL]?
    let vehicles: [URL]?
    let starships: [URL]?
    let created: Date?
    let edited: Date?
    let url: URL?
}
