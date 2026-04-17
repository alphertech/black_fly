import 'package:flutter/material.dart';
import '../models/server_model.dart';

class ServerItem extends StatelessWidget {
  final ServerModel server;
  final VoidCallback onConnect;
  final VoidCallback onFavorite;

  const ServerItem({
    super.key,
    required this.server,
    required this.onConnect,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Flag
          Container(
            width: 48,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage('https://flagcdn.com/w60/${server.countryCode.toLowerCase()}.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Server info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${server.city}, ${server.country}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${server.ping} ms',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Load: ${server.load}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: server.load / 100,
                        backgroundColor: Colors.grey[300],
                        color: server.load < 50 ? Colors.green : Colors.orange,
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          IconButton(
            icon: Icon(
              server.isFavorite ? Icons.star : Icons.star_border,
              color: server.isFavorite ? Colors.amber : Colors.grey,
            ),
            onPressed: onFavorite,
          ),
          ElevatedButton(
            onPressed: onConnect,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }
}