import SwiftUI

@main
struct PokemonDealHunterApp: App {
    @StateObject private var store = ListingStore()

    var body: some Scene {
        WindowGroup {
            DealListView()
                .environmentObject(store)
        }
    }
}
