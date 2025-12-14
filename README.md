# Voice-First Discovery - Flutter Android App

🎤 **Native Android app for voice-activated business discovery powered by Yelp AI API**

[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Yelp AI API](https://img.shields.io/badge/Yelp-AI%20API-red)](https://docs.developer.yelp.com/reference/v2_ai_chat)
[![Hackathon](https://img.shields.io/badge/Yelp-Hackathon%202025-orange)](https://yelp-ai.devpost.com/)

---

## 🎯 Overview

Native Android application for hands-free business discovery using voice commands and Yelp's AI API.

**Built for the Yelp AI API Hackathon 2025**

---

## ✨ Features

- 🎙️ **Native Voice Recognition** - Android Speech API
- 🔊 **Text-to-Speech** - Hear results aloud
- 🤖 **Yelp AI Integration** - Conversational search
- 📍 **GPS Location** - Real-time positioning
- 🎨 **Material Design 3** - Modern UI
- 📱 **60fps Performance** - Smooth animations

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android Studio
- Android SDK
- Android device or emulator

### Installation

1. **Install Flutter:**
```bash
# macOS (with Homebrew)
brew install flutter

# Or download from:
# https://flutter.dev/docs/get-started/install
```

2. **Clone the repository:**
```bash
git clone https://github.com/satishtamilan/yelpai-flutter.git
cd yelpai-flutter
```

3. **Install dependencies:**
```bash
flutter pub get
```

4. **Run the app:**
```bash
flutter run
```

---

## 📱 Build APK

### Debug APK:
```bash
flutter build apk
```

### Release APK:
```bash
flutter build apk --release
```

**APK location:**
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🛠️ Tech Stack

- **Framework:** Flutter 3.0+
- **Language:** Dart
- **State Management:** Provider
- **APIs:**
  - Yelp AI API (`/ai/chat/v2`)
  - Android Speech Recognition
  - Flutter TTS
  - Geolocator
- **UI:** Material Design 3, Google Fonts

---

## 📁 Project Structure

```
lib/
├── main.dart                  # App entry point
├── models/
│   └── business_model.dart    # Data models
├── services/
│   ├── speech_service.dart    # Voice I/O
│   └── yelp_service.dart      # API calls
├── screens/
│   └── voice_screen.dart      # Main screen
└── widgets/
    └── business_card.dart     # Business card UI
```

---

## 🔧 Configuration

### Yelp API Key

The API key is configured in `lib/services/yelp_service.dart`:

```dart
static const String _apiKey = 'your-api-key-here';
```

**For production:** Use environment variables or Flutter dotenv.

### Permissions

Required permissions (already configured):
- INTERNET
- RECORD_AUDIO
- ACCESS_FINE_LOCATION
- ACCESS_COARSE_LOCATION

---

## 🎮 Usage

1. Launch the app
2. Tap the microphone button
3. Allow permissions (microphone, location)
4. Speak your query naturally
5. View results and tap cards to hear details

---

## 🧪 Testing

### Run tests:
```bash
flutter test
```

### Run on device:
```bash
flutter devices  # List devices
flutter run -d <device-id>
```

---

## 📦 Dependencies

```yaml
http: ^1.1.0                    # API calls
speech_to_text: ^6.6.0          # Voice input
flutter_tts: ^3.8.3             # Voice output
geolocator: ^10.1.0             # GPS
permission_handler: ^11.1.0     # Permissions
provider: ^6.1.1                # State management
google_fonts: ^6.1.0            # Typography
```

---

## 🎨 Design Features

- Modern dark theme with Yelp red accent
- Smooth animations (60fps)
- Large touch targets for accessibility
- Material Design 3 components
- Custom gradient backgrounds
- Responsive layouts

---

## 🔒 Security

- API keys should use environment variables in production
- Location data used only for search, not stored
- Voice data processed locally
- HTTPS for all network requests

---

## 🚧 Future Enhancements

- [ ] Offline mode with cached results
- [ ] Restaurant reservation booking
- [ ] Favorites and history
- [ ] Multi-language support
- [ ] iOS version
- [ ] Widget support
- [ ] Android Auto integration

---

## 📱 Screenshots

*Add screenshots after building the app*

---

## 🤝 Related Projects

- **Web App:** https://github.com/satishtamilan/yelpai
- **Live Demo:** https://yelpai.vercel.app (or your URL)

---

## 📄 License

MIT License

---

## 👤 Author

**Satish Tamil**
- GitHub: [@satishtamilan](https://github.com/satishtamilan)
- Hackathon: [Yelp AI API Hackathon 2025](https://yelp-ai.devpost.com/)

---

## 🙏 Acknowledgments

- Yelp for the AI API
- Flutter team for the amazing framework
- Open source community

---

**Built with ❤️ for the Yelp AI API Hackathon 2025**

**Deadline:** December 17, 2025 @ 5:00pm EST

