from typing import Protocol

from app.models.listing import Listing


class ListingProvider(Protocol):
    """Boundary for a future official listing API implementation."""

    async def fetch_active_listings(self) -> list[Listing]: ...


class MarketValueProvider(Protocol):
    """Boundary for evidence-backed, identity-matched market estimates."""

    async def enrich(self, listing: Listing) -> Listing: ...
