import Foundation

struct PeoplePage: Codable {
    let count: Int?
    let next: URL?
    let previous: URL?
    let results: [Person]
}

struct Person: Codable, Identifiable, Hashable {
    var id: String { url?.absoluteString ?? name }
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

extension JSONDecoder {
    static var swapi: JSONDecoder {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        d.dateDecodingStrategy = .iso8601
        return d
    }
}

enum SWAPIError: Error {
    case badURL, badResponse
}

actor SWAPIClient {
    static let shared = SWAPIClient()
    private let base = URL(string: "https://swapi.info/api/")!

    func peoplePage(from pageURL: URL? = nil) async throws -> PeoplePage {
        let url = pageURL ?? base.appendingPathComponent("people/")
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw SWAPIError.badResponse }
        return try JSONDecoder.swapi.decode(PeoplePage.self, from: data)
    }

    func person(from url: URL) async throws -> Person {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw SWAPIError.badResponse }
        return try JSONDecoder.swapi.decode(Person.self, from: data)
    }
}
