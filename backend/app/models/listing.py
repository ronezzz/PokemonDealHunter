from datetime import datetime
from enum import Enum
from typing import Optional

from pydantic import BaseModel, Field, HttpUrl, computed_field


class ListingFormat(str, Enum):
    buy_it_now = "buyItNow"
    auction = "auction"


class CardState(str, Enum):
    graded = "graded"
    raw = "raw"


class Listing(BaseModel):
    id: str
    title: str
    image_url: Optional[HttpUrl] = Field(default=None, alias="imageUrl")
    listing_url: HttpUrl = Field(alias="listingUrl")
    price: float = Field(ge=0)
    shipping: float = Field(ge=0)
    market_value: Optional[float] = Field(default=None, gt=0, alias="marketValue")
    market_value_source: Optional[str] = Field(default=None, alias="marketValueSource")
    match_confidence: Optional[float] = Field(default=None, ge=0, le=1, alias="matchConfidence")
    card_state: CardState = Field(alias="cardState")
    format: ListingFormat
    grade: Optional[str] = None
    ends_at: Optional[datetime] = Field(default=None, alias="endsAt")

    model_config = {"populate_by_name": True}

    @computed_field(alias="totalPrice")
    @property
    def total_price(self) -> float:
        return round(self.price + self.shipping, 2)

    @computed_field(alias="discountPercent")
    @property
    def discount_percent(self) -> Optional[float]:
        if self.market_value is None:
            return None
        return round((self.market_value - self.total_price) / self.market_value * 100, 2)
