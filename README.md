# 🎤 Voice-First Discovery - Flutter Android App

✅ **ALL WEB APP FEATURES NOW INCLUDED!**

Native Android app with **100% feature parity** with the web version!

---

## ✨ Features (Same as Web App!)

### 🎤 **Voice Search**
- Voice-activated business discovery
- Natural language processing  
- Continuous listening mode
- Real-time speech recognition

### 📅 **Booking System**
- Smart booking modal
- Date/time picker
- Party size selection
- Confirmation numbers
- Voice feedback

### 🗺️ **Directions**  
- Google Maps integration
- Opens native Maps app
- Turn-by-turn navigation
- From current location

### 📞 **Call Functionality**
- Direct phone integration  
- One-tap calling
- Phone number display

### 🤖 **Yelp AI Integration**
- Conversational AI API
- Smart recommendations
- Context-aware responses
- UK locale support

---

## 🚀 Quick Start

### Install Dependencies:
```bash
cd /Users/sanandhan/code/yelpai-flutter
flutter pub get
```

### Run on Device:
```bash
flutter run
```

### Build APK:
```bash
flutter build apk --release
```

**APK location:**
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📱 What's New

### Added from Web App:
- ✅ **Directions button** - Opens Google Maps
- ✅ **Call button** - Phone integration  
- ✅ **Booking button** - Same as web
- ✅ **Better UI** - Action buttons on cards
- ✅ **url_launcher** package for maps/phone

---

## 🎯 Features Comparison

| Feature | Web App | Flutter App |
|---------|---------|-------------|
| Voice Search | ✅ | ✅ |
| Booking | ✅ | ✅ |
| Directions | ✅ | ✅ |
| Calling | ✅ | ✅ |
| Yelp AI | ✅ | ✅ |
| GPS | ✅ | ✅ |

**100% Parity!** 🎉

---

## 📂 Project Structure

```
lib/
├── main.dart                  # App entry
├── models/
│   └── business_model.dart    # Data models
├── services/
│   ├── speech_service.dart    # Voice I/O  
│   └── yelp_service.dart      # API calls
├── screens/
│   └── voice_screen.dart      # Main screen
└── widgets/
    └── business_card.dart     # Cards with actions
```

---

## 🔧 Dependencies

```yaml
http: ^1.1.0                    # API calls
speech_to_text: ^6.6.0          # Voice input
flutter_tts: ^3.8.3             # Voice output
geolocator: ^10.1.0             # GPS
permission_handler: ^11.1.0     # Permissions
provider: ^6.1.1                # State
google_fonts: ^6.1.0            # Typography
url_launcher: ^6.2.2            # Maps/Phone
```

---

## 🎮 Usage

1. Launch app
2. Tap microphone
3. Say "Find pizza places"
4. Tap "Directions" → Opens Maps
5. Tap "Call" → Opens Phone
6. Tap "Book" → Opens booking form

---

## 🏗️ Build Instructions

### Debug:
```bash
flutter run
```

### Release APK:
```bash
flutter build apk --release
```

### Install on Device:
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## 📱 Testing

### On Emulator:
```bash
flutter emulators
flutter emulators --launch <emulator_id>
flutter run
```

### On Real Device:
1. Enable USB debugging
2. Connect device
3. `flutter devices`
4. `flutter run`

---

## 🎯 For Hackathon

### What to Submit:
- ✅ Web app URL
- ✅ Flutter APK file  
- ✅ GitHub repos (both)
- ✅ Demo video

### Talking Points:
- Cross-platform (Web + Mobile)
- Voice-first hands-free
- Native performance
- Complete features
- Real API integration

---

## 🚀 Deploy

### Web App:
Already deployed at your URL! ✅

### Flutter App:
1. Build APK: `flutter build apk --release`
2. Test on device
3. Upload APK to Devpost
4. Include in submission

---

## 💡 Pro Tips

- Test on real Android device
- Check microphone permissions  
- Verify location permissions
- Test Maps integration
- Test voice recognition

---

## 🔗 Links

- **Web App:** https://yelpai.vercel.app (or your URL)
- **Web Repo:** https://github.com/satishtamilan/yelpai
- **Flutter Repo:** This folder!

---

## 📄 License

MIT License

---

## 👤 Author

**Satish Tamil**
- GitHub: [@satishtamilan](https://github.com/satishtamilan)
- Hackathon: Yelp AI API Hackathon 2025

---

**Built with ❤️ for Yelp AI API Hackathon 2025**

**Deadline:** December 17, 2025
