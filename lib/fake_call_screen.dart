import 'package:fake_call_feature/ongoing_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FakeCallScreen extends StatefulWidget {
  final String callerName;
  final String callerImage;

  const FakeCallScreen({super.key, required this.callerName,required this.callerImage });

  @override
  FakeCallScreenState createState() => FakeCallScreenState();
}

class FakeCallScreenState extends State<FakeCallScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playRingtone();
  }

  void _playRingtone() async {
    await _audioPlayer.play(AssetSource('audios/ringtone.mp3')); // Replace with your ringtone file
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    super.dispose();
  }

  void _endCall() {
    _audioPlayer.stop();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(widget.callerImage.isEmpty ? widget.callerImage : 'assets/images/caller_icon.png'),
          ),
          SizedBox(height: 20),
          Text(widget.callerName, style: TextStyle(color: Colors.white, fontSize: 24)),
          SizedBox(height: 10),
          Text("Incoming Call...", style: TextStyle(color: Colors.white54, fontSize: 18)),
          SizedBox(height: 40),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _endCall,
                backgroundColor: Colors.red,
                child: Icon(Icons.call_end),
              ),
              SizedBox(width: 40),
              FloatingActionButton(
                onPressed: () {
                  _audioPlayer.stop(); // Stop ringtone before navigating
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OngoingCallScreen(
                        callerName: widget.callerName,
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.call),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

