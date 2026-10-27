import Foundation

protocol ListingFetching {
    func fetchListings() async throws -> [Listing]
}

struct APIClient: ListingFetching {
    let session: URLSession
    let baseURL: URL

    init(session: URLSession = .shared, baseURL: URL = AppConfiguration.apiBaseURL) {
        self.session = session
        self.baseURL = baseURL
    }

    func fetchListings() async throws -> [Listing] {
        let url = baseURL.appendingPathComponent("listings")
        let (data, response) = try await session.data(from: url)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([Listing].self, from: data)
    }
}

struct SampleListingClient: ListingFetching {
    func fetchListings() async throws -> [Listing] {
        try await Task.sleep(nanoseconds: 150_000_000)
        return Listing.samples
    }
}
