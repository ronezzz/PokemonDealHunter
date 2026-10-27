# Pokémon Deal Hunter

An iPhone app and Python service for reviewing potentially under-market Pokémon card listings. The app helps a human find candidates; it does **not** buy cards or claim that a listing is a guaranteed deal.

## Current status

This repository is a development scaffold. It runs with clearly labeled sample listings so the app and API contract can be developed safely.

| Capability | Status |
|---|---|
| SwiftUI deal feed and filters | Implemented against sample/local API data |
| Python API and deal rules | Implemented |
| Total price at or below $150 | Implemented and tested |
| At least 5% below a matched market value | Implemented and tested |
| Graded preferred; raw included | Implemented as ranking, not exclusion |
| Live eBay listings | **Not connected** |
| Reliable identity matching and sold comparisons | **Not connected** |
| PriceCharting and TCGplayer | **Not connected**; terms/API access must be verified |
| Auction monitoring | Data model/UI implemented; scheduler **not connected** |
| iPhone push notifications | **Not connected**; requires Apple credentials and a device |

Sample values are fictional and carry `marketValueSource: "sample"`. The backend never presents them as real market prices.

## Repository layout

- `ios/` — SwiftUI iOS application and unit tests
- `backend/` — FastAPI service, deal rules, provider boundaries, and tests
- `docs/ARCHITECTURE.md` — data flow, matching safeguards, and integration plan
- `.env.example` — non-secret configuration template

## Quick start: backend

Prerequisites: Python 3.9+.

```bash
make backend-install
make backend-test
make backend-run
```

Then open <http://127.0.0.1:8000/docs> or request:

```bash
curl http://127.0.0.1:8000/api/v1/listings
```

Configuration is read from environment variables. Copy `.env.example` to `.env` for your own reference, but export variables in your shell or use a process manager when running the service; `.env` loading is intentionally not implicit yet.

## Quick start: iPhone app

Prerequisites: macOS with Xcode 16 or later.

1. Open `ios/PokemonDealHunter.xcodeproj`.
2. Select the `PokemonDealHunter` scheme and an iPhone simulator.
3. Run. The app starts in sample mode and needs no backend.
4. To use the local backend, edit `AppConfiguration.swift`, set `usesSampleData` to `false`, and run the backend first.

The simulator can reach the Mac backend at `127.0.0.1`. A physical iPhone needs the Mac's LAN address, an appropriate App Transport Security configuration for local development, and both devices on the same network.

## Deal qualification rules

A listing is eligible only when:

1. Listing price plus shipping is no more than `$150`.
2. A market estimate exists from sufficiently reliable, identity-matched comparisons.
3. `(market value - total cost) / market value` is at least `5%`.

Graded listings rank ahead of otherwise comparable raw listings. Grade, grading company, set, card number, variation, language, edition, and condition must be part of identity matching; missing or conflicting attributes must reduce confidence or prevent a deal designation.

## Adding live integrations

Provider interfaces are in `backend/app/providers/`. Implementations should fetch permitted data and return normalized listings or comparable sales. Do not scrape services in violation of their terms. Before enabling deal labels:

- obtain eBay developer credentials and confirm API access and rate limits;
- confirm legal/API access for PriceCharting and TCGplayer;
- implement deterministic card identity normalization;
- reject mixed raw/graded, wrong set/number, wrong language, and dissimilar-condition comps;
- retain evidence and confidence for every market estimate.

APNs additionally requires an Apple Developer membership, an explicit App ID, push entitlement, APNs signing key, device-token registration, and a backend notification worker.

## Moving or publishing with Git

No remote is configured and nothing has been pushed. The easiest transfer is to create an empty **private** repository on your preferred Git host, then from this folder run:

```bash
git remote add origin <your-repository-url>
git branch -M main
git push -u origin main
```

Review the remote URL and confirm that no secrets were added before pushing.

On the primary Mac, clone that private repository and follow the quick-start sections above. If you prefer not to use a host, copy the entire `PokemonDealHunter` folder (including its hidden `.git` directory) with AirDrop or an external drive.
