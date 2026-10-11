# Maharaja X Md — Website Session Integration Requirements

## Purpose
This document describes the intended integration between the Maharaja X Md bot and the separate website at https://v0-maharaja-x-md.vercel.app. It is a specification for the website/backend integration, not a claim that a session-generator API already exists in this bot repository.

## Confirmed project facts
- The bot is a Node.js project.
- `package.json` declares a dependency named `baileys` sourced from a custom Git repository.
- The bot reads `SESSION_ID` from environment configuration (`config.js`).
- The repository also contains a messaging API mode; that is not automatically a session-generation API.
- The actual authentication/session implementation is in the bot's existing code and must be inspected before changing its format.

## Required website behavior
1. Remove the random-name option. A custom session name is required for every new pairing attempt.
2. Support phone-number pairing and QR pairing only if supported by the installed Baileys implementation.
3. Use this display/name convention: `Maharaja-x-md_<CUSTOM_NAME>`; example: `Maharaja-x-md_SHUBHAM62`.
4. Do not finalize/display success until WhatsApp authentication has succeeded and session credentials have been stored successfully.
5. After success, send a confirmation message to the linked WhatsApp account containing the session *name* only, for example `Maharaja-x-md_SHUBHAM62`. Never send raw credentials, auth-state files, or a secret serialized session string in the confirmation message.
6. Preserve the existing Maharaja X Md website design and its custom WhatsApp chat feature.
7. Handle duplicate names safely; never overwrite another user's session. Validate custom names and isolate each pairing flow.
8. Protect pairing/session endpoints with rate limits, expiry, ownership checks, and secure storage. Do not put credentials in URLs, client logs, or public API responses.

## Critical compatibility requirement
The displayed session name is not necessarily the session credential itself. Inspect the bot's real session-loading code and its custom Baileys dependency before implementing a session generator. Keep the bot's existing expected session serialization and storage format. Do not invent a session format or assume the repository's `SESSION_ID` environment variable is a custom label.

## Backend/deployment
The website's Vercel frontend may need a separate persistent Node.js backend if the Baileys connection requires a long-lived process. Decide this from the actual implementation and hosting limits. If needed, expose a configurable frontend base URL such as `SESSION_API_URL`; do not hardcode secrets in frontend code.

## Suggested workflow
- Inspect the actual bot auth/session implementation.
- Define the API contract from the inspected code.
- Implement the smallest compatible backend and connect the existing website UI.
- Test phone pairing and QR pairing independently, where supported.
- Test successful auth, failed auth, expiry, duplicate names, session persistence/reload, and confirmation messaging.
- Report only tests that were actually run.
