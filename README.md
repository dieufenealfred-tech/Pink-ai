# Pink AI
First-date planning assistant MVP built with Flutter.

## Features
- Splash → Gender select → Form → Paywall → Result flow
- OpenAI-powered personalized plan generation
- Fake paywall unlock for now

## Requirements
- Flutter stable
- Xcode + iOS Simulator

## Run the app
1. Install dependencies:
   ```bash
   flutter pub get
   ```
2. Run on simulator (or device):
   ```bash
   flutter run --dart-define=OPENAI_API_KEY=YOUR_KEY_HERE
   ```

### iOS Simulator steps
1. Open Xcode and ensure command-line tools are installed.
2. Start a simulator:
   ```bash
   open -a Simulator
   ```
3. Run:
   ```bash
   flutter run --dart-define=OPENAI_API_KEY=YOUR_KEY_HERE
   ```

## OpenAI API key
The app expects the API key via `--dart-define`. Do not hardcode secrets.

You can copy `.env.example` as a reminder, but the app reads the key only via `--dart-define`:
```bash
flutter run --dart-define=OPENAI_API_KEY=YOUR_KEY_HERE
```
