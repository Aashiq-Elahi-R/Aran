
import 'package:flutter/material.dart';

class OngoingCallScreen extends StatefulWidget {
  final String callerName;

  const OngoingCallScreen({super.key, required this.callerName});

  @override
  OngoingCallScreenState createState() => OngoingCallScreenState();
}

class OngoingCallScreenState extends State<OngoingCallScreen> {
  bool isMuted = false;
  bool isSpeakerOn = false;
  int callDuration = 0;
  late final Stopwatch stopwatch;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch()..start();
    _updateCallDuration();
  }

  void _updateCallDuration() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          callDuration = stopwatch.elapsed.inSeconds;
        });
        _updateCallDuration();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  void _toggleSpeaker() {
    setState(() {
      isSpeakerOn = !isSpeakerOn;
    });
  }

  void _endCall() {
    stopwatch.stop();
    Navigator.popUntil(context, (route) => route.isFirst); // Go back to the first screen
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.callerName,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            _formatDuration(callDuration),
            style: const TextStyle(color: Colors.white54, fontSize: 18),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCallButton(Icons.mic_off, "Mute", _toggleMute, isMuted),
              _buildCallButton(Icons.pause, "Hold", () {}),
              _buildCallButton(Icons.add_call, "Add Call", () {}),
              _buildCallButton(Icons.dialpad, "Keypad", () {}),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCallButton(Icons.volume_up, "Speaker", _toggleSpeaker, isSpeakerOn),
              _buildCallButton(Icons.call_end, "End Call", _endCall, true, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton(IconData icon, String label, VoidCallback onPressed,
      [bool active = false, Color? color]) {
    return Padding(
      padding: const EdgeInsets.all(3.0), // Add 3dp margin here
      child: Column(
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: active ? Colors.green : Colors.white),
            iconSize: 32,
          ),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
