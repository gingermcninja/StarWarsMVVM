import Foundation

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

    func peoplePage(from pageURL: URL? = nil) async throws -> [Person] {
        let url = pageURL ?? base.appendingPathComponent("people/")
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw SWAPIError.badResponse }
        return try await JSONDecoder.swapi.decode([Person].self, from: data)
    }
}
