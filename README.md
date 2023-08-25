# Travel Brain 🌍✈️

Welcome to Travel Brain! Your go-to app for personalized travel suggestions tailored to your interests and dislikes. Get travel notes, historical background, and more!

## Features 🌟

- **Travel Suggestions 🗺️**: Get destinations that match your vibe.
- **Insightful Information 📚**: Learn more about each place.
- **gRPC Communication ⚡**: Fast and efficient backend communication.
- **Offline Support 📴**: No internet? No problem!

## Architecture 🏗️

This project is organized into three main layers: UI, Data, and Domain. Each layer is in its own package to prevent code mixing.

- **UI Package 🎨**: Widgets only, depends on domain.
- **Data Package 💾**: Classes that produce domain language.
- **Domain Package 🛠️**: Interfaces and models only.
- **App Package 📦**: The glue that binds everything.

📝 **Upcoming**: Detailed article on architecture.

## Getting Started 🚀

### Prerequisites 🛠️

- Flutter SDK
- Docker
- Firebase project

### Firebase Setup 🔥

Provide these files for Firebase:

- `android/app/google-services.json`
- `lib/firebase_options.dart`
- `ios/firebase_app_id_file.json`
- `ios/Runner/GoogleService-Info.plist`

### Step 1: Env Setup 🌱

Rename `.env.example` to `.env` and fill it out.

```bash
mv .env.example .env
```

📝 **Note**: Open `.env` and complete the variables.

### Step 2: Docker Up 🐳

Run this to start Docker containers:

```bash
docker compose up -d
```

🟢 **Success**: Containers should be running.

### Step 3: Flutter Run 🏃‍♂️

Run your Flutter app:

```bash
flutter run
```

## Contributing 🤝

We welcome your help! Here's what you can do:

1. **Platform Testing 📱**: Help needed for iOS and web.
2. **Testing 🧪**: Tests are in progress.
3. **UI/UX 🎨**: Room for improvement.

## License 📄

[License Information]

## Contact 📞

Questions? Reach out to [Mohammad Teimouri](mailto:moshi1376@yahoo.com).
