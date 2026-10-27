import Foundation

struct Listing: Codable, Identifiable, Hashable {
    enum CardState: String, Codable {
        case graded
        case raw
    }

    enum ListingFormat: String, Codable {
        case buyItNow
        case auction
    }

    let id: String
    let title: String
    let imageUrl: URL?
    let listingUrl: URL
    let price: Double
    let shipping: Double
    let marketValue: Double?
    let marketValueSource: String?
    let matchConfidence: Double?
    let cardState: CardState
    let format: ListingFormat
    let grade: String?
    let endsAt: Date?
    let totalPrice: Double
    let discountPercent: Double?

    var isAuctionEndingSoon: Bool {
        guard format == .auction, let endsAt else { return false }
        let remaining = endsAt.timeIntervalSinceNow
        return remaining > 0 && remaining <= 15 * 60
    }
}
