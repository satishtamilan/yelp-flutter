import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/business_model.dart';

class BusinessCard extends StatelessWidget {
  final Business business;
  final VoidCallback onTap;
  final VoidCallback? onBook;

  const BusinessCard({
    super.key,
    required this.business,
    required this.onTap,
    this.onBook,
  });

  Future<void> _openMaps() async {
    if (business.address.isEmpty) {
      return;
    }
    
    final encodedAddress = Uri.encodeComponent(business.address);
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _makeCall(BuildContext context) async {
    // In a real app, you'd have phone number from API
    // For demo, show a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2d2d2d),
        title: const Text('📞 Call Restaurant', style: TextStyle(color: Colors.white)),
        content: Text(
          'To call ${business.name}:\n\n'
          '1. Check their Yelp page for phone number\n'
          '2. Or search "${business.name}" on Yelp app',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Color(0xFFD32323))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                business.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    '${business.rating}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    business.price,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    business.category,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              if (business.address.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        business.address,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFD32323).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: const Border(
                    left: BorderSide(
                      color: Color(0xFFD32323),
                      width: 3,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Text('💡', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        business.aiTip,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onBook,
                      icon: const Icon(Icons.calendar_today, size: 16),
                      label: const Text('Book'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD32323),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: business.address.isNotEmpty ? _openMaps : null,
                      icon: const Icon(Icons.directions, size: 16),
                      label: const Text('Directions'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _makeCall(context),
                      icon: const Icon(Icons.phone, size: 16),
                      label: const Text('Call'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
