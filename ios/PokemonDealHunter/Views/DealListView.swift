import SwiftUI

struct DealListView: View {
    enum Filter: String, CaseIterable, Identifiable {
        case deals = "Deals"
        case endingSoon = "Ending Soon"
        var id: Self { self }
    }

    @EnvironmentObject private var store: ListingStore
    @State private var filter: Filter = .deals

    private var visibleListings: [Listing] {
        switch filter {
        case .deals:
            return store.listings
        case .endingSoon:
            return store.listings.filter(\.isAuctionEndingSoon)
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading && store.listings.isEmpty {
                    ProgressView("Finding sample deals…")
                } else if let message = store.errorMessage, store.listings.isEmpty {
                    ContentUnavailableView(
                        "Unable to Load Deals",
                        systemImage: "wifi.exclamationmark",
                        description: Text(message)
                    )
                } else if visibleListings.isEmpty {
                    ContentUnavailableView(
                        "No Matching Listings",
                        systemImage: "tray",
                        description: Text("Try again after listings refresh.")
                    )
                } else {
                    List(visibleListings) { listing in
                        ListingRow(listing: listing)
                    }
                    .listStyle(.plain)
                    .refreshable { await store.load() }
                }
            }
            .navigationTitle("Pokémon Deals")
            .safeAreaInset(edge: .top) {
                VStack(spacing: 8) {
                    Text("DEMO DATA · PRICES ARE FICTIONAL")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background(.orange)
                    Picker("Listing filter", selection: $filter) {
                        ForEach(Filter.allCases) { item in
                            Text(item.rawValue).tag(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                }
                .background(.background)
            }
            .task { await store.load() }
        }
    }
}
