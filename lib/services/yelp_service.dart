import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/business_model.dart';

class YelpService extends ChangeNotifier {
  static const String _apiKey = 'PCJyCg_1zfY8RD8N36287hpNvV8xU8jeHy8dR47eNuvHhwqYzTnY3l29UaG8fM8iR3ibXY2QKGwwBpEdN8cTf1ckn0Fy5yAPTF9xDCixHxrp-BBPRQvf4jWu2gA-aXYx';
  static const String _baseUrl = 'https://api.yelp.com/ai/chat/v2';
  
  bool _isLoading = false;
  String? _error;
  YelpResponse? _lastResponse;
  Position? _userLocation;
  
  bool get isLoading => _isLoading;
  String? get error => _error;
  YelpResponse? get lastResponse => _lastResponse;

  Future<void> getUserLocation() async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Use London as default
        _userLocation = Position(
          latitude: 51.5074,
          longitude: -0.1278,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        return;
      }

      _userLocation = await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('Location error: $e');
      // Use London as fallback
      _userLocation = Position(
        latitude: 51.5074,
        longitude: -0.1278,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
    }
  }

  Future<YelpResponse> queryAI(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Ensure we have location
      if (_userLocation == null) {
        await getUserLocation();
      }

      // Make API request
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'query': '$query near ${_userLocation!.latitude}, ${_userLocation!.longitude}',
          'user_context': {
            'locale': 'en_GB',
            'latitude': _userLocation!.latitude,
            'longitude': _userLocation!.longitude,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _lastResponse = _parseResponse(data);
        _isLoading = false;
        notifyListeners();
        return _lastResponse!;
      } else {
        debugPrint('API Error: ${response.statusCode} - ${response.body}');
        // Return mock data as fallback
        _lastResponse = _getMockResponse(query);
        _isLoading = false;
        notifyListeners();
        return _lastResponse!;
      }
    } catch (e) {
      debugPrint('Query error: $e');
      _error = e.toString();
      // Return mock data as fallback
      _lastResponse = _getMockResponse(query);
      _isLoading = false;
      notifyListeners();
      return _lastResponse!;
    }
  }

  YelpResponse _parseResponse(Map<String, dynamic> data) {
    final businesses = <Business>[];
    
    if (data['entities'] != null) {
      for (var entity in data['entities']) {
        if (entity['businesses'] != null) {
          for (var business in entity['businesses']) {
            businesses.add(Business.fromJson(business));
          }
        }
      }
    }

    return YelpResponse(
      text: data['response']?['text'] ?? 'Here are some great options!',
      businesses: businesses,
    );
  }

  YelpResponse _getMockResponse(String query) {
    return YelpResponse(
      text: 'I found 3 great options for you based on your request!',
      businesses: [
        Business(
          id: '1',
          name: 'The Ivy Restaurant',
          rating: 4.5,
          price: '£££',
          category: 'British',
          address: '1-5 West St, London WC2H 9NQ',
          aiTip: 'Classic British dining with a modern twist.',
        ),
        Business(
          id: '2',
          name: 'Dishoom',
          rating: 4.7,
          price: '££',
          category: 'Indian',
          address: '12 Upper St Martin\'s Lane, London WC2H 9FB',
          aiTip: 'Bombay-inspired cafe with exceptional breakfast.',
        ),
        Business(
          id: '3',
          name: 'Wagamama',
          rating: 4.4,
          price: '££',
          category: 'Asian',
          address: '14A Irving St, London WC2H 7AF',
          aiTip: 'Fresh ramen and Asian dishes.',
        ),
      ],
    );
  }
}

