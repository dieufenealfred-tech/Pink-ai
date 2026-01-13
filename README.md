# Pink AI
Luxury, Barbie-pink first-date planning concierge MVP built with Flutter.

## Requirements
- Flutter stable
- Xcode + iOS Simulator

## Run the app
1. Install dependencies:
   ```bash
   flutter pub get
   ```
2. Run on iOS Simulator:
   ```bash
   flutter run -d "iPhone" --dart-define=OPENAI_API_KEY=YOUR_KEY_HERE
   ```

## OpenAI API key
The app expects the API key via `--dart-define`. Do not hardcode secrets.

Example:
```bash
flutter run -d "iPhone" --dart-define=OPENAI_API_KEY=YOUR_KEY_HERE
```
