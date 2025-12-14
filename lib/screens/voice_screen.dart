import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/speech_service.dart';
import '../services/yelp_service.dart';
import '../widgets/business_card.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  bool _hasResults = false;

  @override
  void initState() {
    super.initState();
    _initServices();
  }

  Future<void> _initServices() async {
    final speechService = context.read<SpeechService>();
    final yelpService = context.read<YelpService>();
    
    await speechService.initialize();
    await yelpService.getUserLocation();
  }

  Future<void> _handleVoiceInput() async {
    final speechService = context.read<SpeechService>();
    final yelpService = context.read<YelpService>();

    if (speechService.isListening) {
      await speechService.stopListening();
      return;
    }

    await speechService.startListening(
      onResult: (transcript) async {
        if (transcript.isNotEmpty) {
          // Query Yelp AI
          final response = await yelpService.queryAI(transcript);
          
          // Speak the response
          await speechService.speak(response.text);
          
          setState(() {
            _hasResults = true;
          });
        }
      },
    );
  }

  void _handleSuggestion(String query) async {
    final speechService = context.read<SpeechService>();
    final yelpService = context.read<YelpService>();

    final response = await yelpService.queryAI(query);
    await speechService.speak(response.text);
    
    setState(() {
      _hasResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1a1a1a), Color(0xFF2d2d2d)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _hasResults
                    ? _buildResults()
                    : _buildVoiceInterface(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            '🎤',
            style: TextStyle(fontSize: 60),
          ),
          const SizedBox(height: 10),
          Text(
            'Voice-First Discovery',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD32323),
            ),
          ),
          Text(
            'Powered by Yelp AI',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceInterface() {
    return Consumer<SpeechService>(
      builder: (context, speechService, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _handleVoiceInput,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: speechService.isListening
                        ? [const Color(0xFFFF1744), const Color(0xFFFF4444)]
                        : [const Color(0xFFD32323), const Color(0xFFFF1744)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD32323).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  speechService.isListening ? Icons.mic : Icons.mic_none,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              speechService.isListening
                  ? '🎧 Listening...'
                  : 'Tap to speak',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                speechService.transcript.isEmpty
                    ? 'Say: "Find pizza places near me"'
                    : speechService.transcript,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: speechService.transcript.isEmpty
                      ? Colors.grey
                      : Colors.greenAccent,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            _buildSuggestions(),
          ],
        );
      },
    );
  }

  Widget _buildSuggestions() {
    final suggestions = [
      '🍕 Find pizza places',
      '☕ Best coffee shops',
      '🥗 Vegan restaurants',
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: suggestions.map((suggestion) {
        return InkWell(
          onTap: () => _handleSuggestion(suggestion.substring(2)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFD32323).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFD32323).withOpacity(0.5),
              ),
            ),
            child: Text(suggestion),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildResults() {
    return Consumer<YelpService>(
      builder: (context, yelpService, _) {
        final response = yelpService.lastResponse;
        if (response == null) return const SizedBox();

        return Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: const Border(
                  left: BorderSide(
                    color: Color(0xFFD32323),
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🤖 AI Response',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFFFF4444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    response.text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: response.businesses.length,
                itemBuilder: (context, index) {
                  return BusinessCard(
                    business: response.businesses[index],
                    onTap: () async {
                      final speechService = context.read<SpeechService>();
                      final business = response.businesses[index];
                      await speechService.speak(
                        '${business.name}. Rated ${business.rating} stars. ${business.aiTip}',
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _hasResults = false;
                        });
                      },
                      icon: const Icon(Icons.mic),
                      label: const Text('Ask Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD32323),
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _hasResults = false;
                        });
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

