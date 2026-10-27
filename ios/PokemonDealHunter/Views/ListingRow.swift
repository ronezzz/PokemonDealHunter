import SwiftUI

struct ListingRow: View {
    let listing: Listing

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(listing.title)
                        .font(.headline)
                    Text(listing.grade ?? listing.cardState.rawValue.capitalized)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                if let discount = listing.discountPercent {
                    Text("\(discount, specifier: "%.0f")% under")
                        .font(.caption.bold())
                        .foregroundStyle(.green)
                }
            }

            HStack {
                Label {
                    Text(listing.totalPrice, format: .currency(code: "USD"))
                } icon: {
                    Image(systemName: "tag")
                }
                Spacer()
                if let marketValue = listing.marketValue {
                    Text("Sample market: \(marketValue, format: .currency(code: "USD"))")
                        .foregroundStyle(.secondary)
                }
            }
            .font(.subheadline)

            if listing.isAuctionEndingSoon, let endsAt = listing.endsAt {
                Label("Ends \(endsAt, style: .relative)", systemImage: "clock.badge.exclamationmark")
                    .font(.caption.bold())
                    .foregroundStyle(.orange)
            }

            Link(destination: listing.listingUrl) {
                Label("Open listing", systemImage: "arrow.up.right.square")
            }
            .font(.subheadline.bold())
        }
        .padding(.vertical, 6)
    }
}
