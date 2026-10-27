import XCTest
@testable import PokemonDealHunter

final class PokemonDealHunterTests: XCTestCase {
    func testAuctionWithinFifteenMinutesIsEndingSoon() throws {
        var listing = Listing.samples[1]
        XCTAssertTrue(listing.isAuctionEndingSoon)

        listing = Listing(
            id: listing.id,
            title: listing.title,
            imageUrl: listing.imageUrl,
            listingUrl: listing.listingUrl,
            price: listing.price,
            shipping: listing.shipping,
            marketValue: listing.marketValue,
            marketValueSource: listing.marketValueSource,
            matchConfidence: listing.matchConfidence,
            cardState: listing.cardState,
            format: listing.format,
            grade: listing.grade,
            endsAt: Date().addingTimeInterval(16 * 60),
            totalPrice: listing.totalPrice,
            discountPercent: listing.discountPercent
        )
        XCTAssertFalse(listing.isAuctionEndingSoon)
    }
}
