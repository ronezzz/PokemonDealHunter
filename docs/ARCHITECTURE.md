# Architecture and integration guardrails

## Data flow

1. Listing providers retrieve active card listings.
2. The normalizer extracts a card identity: name, set, number, variation, language, edition, raw/graded status, grading company, grade, and condition.
3. Market providers retrieve permitted sold comparisons or price-guide observations.
4. The matcher accepts only comparable identities and records its evidence and confidence.
5. The evaluator applies the total-price and minimum-discount rules.
6. The API serves ranked candidates to the iOS app.
7. A future scheduler revisits listings and sends APNs alerts for qualifying deals or auctions entering the alert window.

## Market-value policy

A market value must never be inferred from a title substring alone. A production estimate should include:

- normalized identity fields and every mismatch;
- source and observation timestamp;
- comparable sale IDs/prices, with shipping when available;
- outlier handling and sample size;
- confidence and an expiry time.

Raw cards and graded cards are separate markets. Different grading companies and grades are not interchangeable. When evidence is insufficient, the system should show the listing without a discount badge rather than inventing a value.

## Provider boundaries

The first live implementation should use eBay's official APIs for active listings and permitted market evidence. PriceCharting and TCGplayer should remain optional corroborating sources until access, terms, identifiers, and rate limits are confirmed.

## Notifications

Alert deduplication should use `(user, listing, alert type, threshold)` and persist delivery state. Auction alerts should be scheduled from authoritative end times, refreshed before delivery, and suppressed if the listing ended, changed identity, exceeded the price cap, or no longer qualifies.
