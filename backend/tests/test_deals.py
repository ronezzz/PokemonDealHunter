from app.models.listing import CardState, Listing, ListingFormat
from app.services.deals import DealPolicy, qualifies, qualifying_listings


def listing(**overrides: object) -> Listing:
    data: dict[str, object] = {
        "id": "test",
        "title": "Test card",
        "listingUrl": "https://example.com/listing",
        "price": 90,
        "shipping": 0,
        "marketValue": 100,
        "marketValueSource": "test",
        "matchConfidence": 0.9,
        "cardState": CardState.raw,
        "format": ListingFormat.buy_it_now,
    }
    data.update(overrides)
    return Listing(**data)


def test_qualifies_at_exact_boundaries() -> None:
    item = listing(price=142.5, shipping=7.5, marketValue=157.9)
    assert qualifies(item, DealPolicy())


def test_rejects_total_above_cap() -> None:
    assert not qualifies(listing(price=145, shipping=6), DealPolicy())


def test_rejects_discount_below_five_percent() -> None:
    assert not qualifies(listing(price=96, marketValue=100), DealPolicy())


def test_rejects_missing_or_low_confidence_market_evidence() -> None:
    assert not qualifies(listing(marketValue=None, matchConfidence=None), DealPolicy())
    assert not qualifies(listing(matchConfidence=0.79), DealPolicy())


def test_graded_cards_are_preferred_without_excluding_raw() -> None:
    raw = listing(id="raw", cardState=CardState.raw, price=70)
    graded = listing(id="graded", cardState=CardState.graded, price=90)
    result = qualifying_listings([raw, graded], DealPolicy())
    assert [item.id for item in result] == ["graded", "raw"]
