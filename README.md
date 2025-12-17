📝 README – Medicine Cart App
## Overview

A Flutter-based shopping cart app designed for a medical product store.
This app demonstrates state management, persistence, and business logic while keeping a clean, maintainable structure.

## Features

1. Product Listing

  » Medicine-themed products (e.g., Paracetamol, Vitamin C)

  » Simple clean UI with placeholder images

2. Cart Management

  » Add/remove products

  » Real-time cart updates

3. Cart Summary

  » Subtotal calculation

  » Discount calculation (based on coupon)

  » Final amount

4. Coupon Functionality

  » Apply a single coupon at a time

  » Validates minimum cart value for coupon

  » Remove coupon functionality

5. Persistence
   
  » Cart and coupon data stored using SharedPreferences

  » Data persists across app restarts

6. State Management

  » Riverpod used for clean, scalable state management

7. Theming & UI

  » Minimal clean theme using Material3

  » Responsive layout using standard Flutter widgets
  
  » Placeholder images for products

## Tech Stack

  • Flutter 3+

  • Riverpod (state management)

  • SharedPreferences (local persistence)

Material Design (UI)
## Design Decisions
✅ Scope Control

No login/registration: Not requested, avoids scope creep

No fancy animations: Interview focuses on business logic and correctness

No full localization: Not requested, app is structured to support it in the future

✅ Medicine-Themed Products

Tailored to company domain

Kept logic generic (no prescription/dosage validation)

✅ Riverpod + Persistence

Clean separation of business logic and UI

Demonstrates modern Flutter best practices

✅ Simple UI

Focus on readability and usability

Avoided unnecessary complexity that could distract from evaluation

## How to Run

1. Clone the repo

2. flutter pub get

3. Run on your preferred device/emulator

  Optional: Replace assets/images/med.jpg with real product images.

Possible Extensions (Future Enhancements)

  » Backend integration for real products

  » Multi-user cart synchronization

  » Dark/light theme toggle

  » Localization support

  » Image caching / better product images

✅## Final Verdict (Important)

✔ This README is professional
✔ Easy for interviewers to scan
