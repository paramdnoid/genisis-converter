# Security

## Baseline

- Do not commit secrets.
- Store tokens only in secure storage once authentication is implemented.
- Enforce HTTPS outside local development.
- Treat local customer, object, photo, signature, and report data as sensitive.
- Keep tenant separation as a backend invariant.

Database encryption is intentionally left as a later evaluation item because it affects performance, platform setup, and operational support.
