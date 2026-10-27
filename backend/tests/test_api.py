from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health_identifies_sample_mode() -> None:
    assert client.get("/health").json() == {"status": "ok", "dataMode": "sample"}


def test_listings_meet_policy() -> None:
    response = client.get("/api/v1/listings")
    assert response.status_code == 200
    for item in response.json():
        assert item["totalPrice"] <= 150
        assert item["discountPercent"] >= 5
        assert item["marketValueSource"] == "sample"
