import Foundation

extension Listing {
    static let samples: [Listing] = [
        Listing(
            id: "sample-graded-1",
            title: "SAMPLE — Graded Pokémon Card",
            imageUrl: nil,
            listingUrl: URL(string: "https://example.com/sample-graded")!,
            price: 84,
            shipping: 5,
            marketValue: 105,
            marketValueSource: "sample",
            matchConfidence: 0.95,
            cardState: .graded,
            format: .buyItNow,
            grade: "PSA 9",
            endsAt: nil,
            totalPrice: 89,
            discountPercent: 15.24
        ),
        Listing(
            id: "sample-raw-1",
            title: "SAMPLE — Raw Pokémon Card",
            imageUrl: nil,
            listingUrl: URL(string: "https://example.com/sample-raw")!,
            price: 38,
            shipping: 2,
            marketValue: 45,
            marketValueSource: "sample",
            matchConfidence: 0.9,
            cardState: .raw,
            format: .auction,
            grade: nil,
            endsAt: Date().addingTimeInterval(12 * 60),
            totalPrice: 40,
            discountPercent: 11.11
        ),
    ]
}
