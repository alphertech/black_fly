import 'package:flutter/material.dart';
import '../models/server_model.dart';

class ServerCardHorizontal extends StatelessWidget {
  final ServerModel server;
  final VoidCallback onTap;

  const ServerCardHorizontal({
    super.key,
    required this.server,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  server.countryCode.toUpperCase(),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    server.displayName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${server.ping} ms',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServerCardFull extends StatelessWidget {
  final ServerModel server;
  final VoidCallback onConnect;
  final VoidCallback onFavorite;

  const ServerCardFull({
    super.key,
    required this.server,
    required this.onConnect,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                server.countryCode.toUpperCase(),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  server.displayName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${server.ping} ms',
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Load: ${server.load}%',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: server.load / 100,
                        backgroundColor: Colors.grey[700],
                        color: const Color(0xFF2A9D8F),
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              server.isFavorite ? Icons.star : Icons.star_border,
              color: server.isFavorite ? Colors.amber : Colors.grey,
            ),
            onPressed: onFavorite,
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onConnect,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A9D8F),
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