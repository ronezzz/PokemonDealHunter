from datetime import datetime, timedelta, timezone

from app.models.listing import CardState, Listing, ListingFormat


def sample_listings() -> list[Listing]:
    """Fictional records for UI development; never use as market evidence."""
    now = datetime.now(timezone.utc)
    return [
        Listing(
            id="sample-graded-1",
            title="SAMPLE — Graded Pokémon Card",
            listingUrl="https://example.com/sample-graded",
            price=84,
            shipping=5,
            marketValue=105,
            marketValueSource="sample",
            matchConfidence=0.95,
            cardState=CardState.graded,
            format=ListingFormat.buy_it_now,
            grade="PSA 9",
        ),
        Listing(
            id="sample-raw-1",
            title="SAMPLE — Raw Pokémon Card",
            listingUrl="https://example.com/sample-raw",
            price=38,
            shipping=2,
            marketValue=45,
            marketValueSource="sample",
            matchConfidence=0.9,
            cardState=CardState.raw,
            format=ListingFormat.auction,
            endsAt=now + timedelta(minutes=12),
        ),
        Listing(
            id="sample-rejected-price",
            title="SAMPLE — Above maximum total",
            listingUrl="https://example.com/sample-rejected",
            price=149,
            shipping=10,
            marketValue=190,
            marketValueSource="sample",
            matchConfidence=0.99,
            cardState=CardState.graded,
            format=ListingFormat.buy_it_now,
        ),
    ]
