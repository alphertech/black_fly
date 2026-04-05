import 'package:flutter/material.dart';
import '../models/server_model.dart';

class ConnectionCard extends StatefulWidget {
  final bool isConnected;
  final bool isConnecting;
  final VoidCallback onPowerPressed;
  final VoidCallback onCancel;
  final ServerModel? connectedServer;
  final String timerValue;

  const ConnectionCard({
    super.key,
    required this.isConnected,
    required this.isConnecting,
    required this.onPowerPressed,
    required this.onCancel,
    this.connectedServer,
    required this.timerValue,
  });

  @override
  State<ConnectionCard> createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A9D8F), Color(0xFF21867A)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Power Button
          GestureDetector(
            onTap: widget.isConnecting ? null : widget.onPowerPressed,
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: widget.isConnecting ? _pulseAnimation.value : 1.0,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isConnected ? Icons.power_settings_new : Icons.power_off,
                        size: 40,
                        color: widget.isConnected
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          
          // Status Text
          Text(
            _getStatusText(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _getSubStatusText(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          
          // Timer
          if (widget.isConnected)
            Text(
              widget.timerValue,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  String _getStatusText() {
    if (widget.isConnecting) return 'Connecting...';
    if (widget.isConnected) return 'Connected';
    return 'Disconnected';
  }

  String _getSubStatusText() {
    if (widget.isConnecting) return 'Establishing secure tunnel';
    if (widget.isConnected) return 'Your data is secure';
    return 'Your data is at risk';
  }
}