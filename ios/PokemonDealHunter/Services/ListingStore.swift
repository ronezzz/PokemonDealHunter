import Foundation

@MainActor
final class ListingStore: ObservableObject {
    @Published private(set) var listings: [Listing] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let client: ListingFetching

    init(client: ListingFetching? = nil) {
        self.client = client ?? (AppConfiguration.usesSampleData ? SampleListingClient() : APIClient())
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            listings = try await client.fetchListings()
        } catch {
            errorMessage = "Could not load listings. \(error.localizedDescription)"
        }
    }
}
