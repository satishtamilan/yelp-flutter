import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeechService extends ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  
  bool _isListening = false;
  bool _isInitialized = false;
  String _transcript = '';
  
  bool get isListening => _isListening;
  bool get isInitialized => _isInitialized;
  String get transcript => _transcript;

  Future<bool> initialize() async {
    if (_isInitialized) return true;

    // Request microphone permission
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      return false;
    }

    // Initialize speech recognition
    _isInitialized = await _speech.initialize(
      onError: (error) {
        debugPrint('Speech error: $error');
        _isListening = false;
        notifyListeners();
      },
      onStatus: (status) {
        debugPrint('Speech status: $status');
        if (status == 'done' || status == 'notListening') {
          _isListening = false;
          notifyListeners();
        }
      },
    );

    // Initialize TTS
    await _tts.setLanguage('en-GB');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    notifyListeners();
    return _isInitialized;
  }

  Future<void> startListening({
    required Function(String) onResult,
  }) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) return;
    }

    if (_isListening) return;

    _transcript = '';
    _isListening = true;
    notifyListeners();

    await _speech.listen(
      onResult: (result) {
        _transcript = result.recognizedWords;
        notifyListeners();
        
        if (result.finalResult) {
          onResult(_transcript);
          stopListening();
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      partialResults: true,
      localeId: 'en_GB',
    );
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    
    await _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  Future<void> speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
    await stopListening();
  }

  @override
  void dispose() {
    _tts.stop();
    _speech.stop();
    super.dispose();
  }
}

