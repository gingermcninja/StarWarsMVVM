//
//  StarWarsMVVMTests.swift
//  StarWarsMVVMTests
//
//  Created by Paul McGrath on 1/22/26.
//

import Testing
@testable import StarWarsMVVM
import Foundation

struct StarWarsMVVMTests {

    @Test("Decodes Person JSON")
    func decodesPerson() throws {
            let json = "[{\"name\": \"Luke Skywalker\",\"height\": \"172\",\"mass\": \"77\",\"hair_color\": \"blond\",\"skin_color\": \"fair\",\"eye_color\": \"blue\",\"birth_year\": \"19BBY\",\"gender\": \"male\",\"url\": \"https://swapi.info/api/people/1/\"}]".data(using: .utf8)!
            let decoder = JSONDecoder.swapi
            let person = try decoder.decode([Person].self, from: json)
            #expect(person.first?.name == "Luke Skywalker")
            #expect(person.first?.birthYear == "19BBY")
            #expect(person.first?.eyeColor == "blue")
    }
}
