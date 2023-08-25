# Travel Suggestion App

Welcome to the Travel Suggestion App, a minimal real-world example that covers essential features from frontend to backend. This app is designed to suggest travel destinations based on your interests and dislikes, providing insightful information such as travel notes, historical background, and more.

## Features

- **Travel Suggestions**: Personalized travel destinations based on user preferences.
- **Insightful Information**: Detailed insights about each suggested place.
- **gRPC Communication**: Utilizes gRPC for efficient communication with the backend.
- **Offline Support**: Access your travel suggestions even without an internet connection.

## Architecture

The project consists of three main layers: UI, Data, and Domain. Each layer resides in its own package to (100%)prevent mixing data/UI code.

- **UI Package**: All Widgets. they depend on domain only.
- **Data Package**: All classes that help produce domain language.
- **Domain Package**: All interfaces and models. no implementation allowed.
- **App Package**: Connects all three packages and is the runnable application.

A complete article regarding this architecture will be available in the future.

## Getting Started

### Prerequisites

- Flutter SDK

### Firebase Configuration

You'll need to setup a firebase project and provide the following files:

- `android/app/google-services.json`
- `lib/firebase_options.dart`
- `ios/firebase_app_id_file.json`
- `ios/Runner/GoogleService-Info.plist`

### Running the Backend

Follow the guide [here](https://github.com/Pr0nE/trip-brain-back) in the backend repository.

### Running the Flutter Project

```bash
flutter run
```

## Remaining Tasks

1. **Platform Testing**: Currently tested on Android only. Help needed for iOS and web testing.
2. **Testing**: Tests are not done yet, only initiated a simple integration test.

## Contributing

Your contributions are welcome! Whether it's testing on different platforms or writing tests, your help is appreciated.

## License

[License Information]

## Contact

For any inquiries, please contact [Mohammad Teimouri](mailto:moshi1376@yahoo.com).

