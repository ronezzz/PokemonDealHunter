from fastapi import APIRouter, Query

from app.models.listing import Listing
from app.services.catalog import sample_listings
from app.services.deals import DealPolicy, qualifying_listings

router = APIRouter()


@router.get("/listings", response_model=list[Listing])
def listings(
    max_total_price: float = Query(default=150, gt=0, le=150),
    min_discount_percent: float = Query(default=5, ge=5, le=100),
) -> list[Listing]:
    policy = DealPolicy(
        max_total_price=max_total_price,
        min_discount_percent=min_discount_percent,
    )
    return qualifying_listings(sample_listings(), policy)
