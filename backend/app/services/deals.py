from dataclasses import dataclass

from app.models.listing import CardState, Listing


@dataclass(frozen=True)
class DealPolicy:
    max_total_price: float = 150
    min_discount_percent: float = 5
    min_match_confidence: float = 0.8


def qualifies(listing: Listing, policy: DealPolicy) -> bool:
    return (
        listing.total_price <= policy.max_total_price
        and listing.market_value is not None
        and listing.discount_percent is not None
        and listing.discount_percent >= policy.min_discount_percent
        and listing.match_confidence is not None
        and listing.match_confidence >= policy.min_match_confidence
    )


def qualifying_listings(listings: list[Listing], policy: DealPolicy) -> list[Listing]:
    eligible = [listing for listing in listings if qualifies(listing, policy)]
    return sorted(
        eligible,
        key=lambda item: (
            item.card_state != CardState.graded,
            -(item.discount_percent or 0),
            item.total_price,
        ),
    )
