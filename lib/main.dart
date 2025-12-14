import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/voice_screen.dart';
import 'services/speech_service.dart';
import 'services/yelp_service.dart';

void main() {
  runApp(const YelpAIApp());
}

class YelpAIApp extends StatelessWidget {
  const YelpAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SpeechService()),
        ChangeNotifierProvider(create: (_) => YelpService()),
      ],
      child: MaterialApp(
        title: 'Voice-First Discovery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFD32323),
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.interTextTheme(
            ThemeData.dark().textTheme,
          ),
          useMaterial3: true,
        ),
        home: const VoiceScreen(),
      ),
    );
  }
}

