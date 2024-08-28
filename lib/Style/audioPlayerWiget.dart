import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class AudioPlayerWithWaveform extends StatefulWidget {
  final String audioUrl;

  AudioPlayerWithWaveform({required this.audioUrl});

  @override
  _AudioPlayerWithWaveformState createState() =>
      _AudioPlayerWithWaveformState();
}

class _AudioPlayerWithWaveformState extends State<AudioPlayerWithWaveform> {
  late final AudioPlayer _audioPlayer;
  final PlayerController _waveformController = PlayerController();
  bool _isPlaying = false;
  List<double>? _waveformData;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    wave();
    _fetchAudioData(widget.audioUrl);
    _loadAndProcessAudio();
  }

  void wave() async {
    await _waveformController.preparePlayer(
        path: widget.audioUrl,
        shouldExtractWaveform: true,
        noOfSamples: 100,
        volume: 1.0);
    _waveformController.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
    _waveformController.onCurrentExtractedWaveformData.listen((_) {
      setState(() {});
    });
  }

  Future<void> _loadAndProcessAudio() async {
    try {
      // Load the audio file into the player
      await _audioPlayer.setUrl(widget.audioUrl);

      // Fetch audio data (example using HTTP client or similar)
      Uint8List audioData = await _fetchAudioData(widget.audioUrl);

      // Process audio data to generate waveform (this is simplified)
      setState(() {
        _waveformData = _generateWaveformData(audioData);
      });

      // Listen to audio player state
      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            _isPlaying = false;
          });
        }
      });
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  // Placeholder for fetching audio data
  Future<Uint8List> _fetchAudioData(String url) async {
    // Implement your audio data fetching logic here
    // For example, use HttpClient to download the audio file as bytes
    return Uint8List(0); // Placeholder
  }

  // Placeholder for generating waveform data from audio bytes
  List<double> _generateWaveformData(Uint8List audioData) {
    // Implement actual waveform generation logic here
    // This is just a simple placeholder
    return List.generate(100, (index) => (index % 10 + 1) * 0.1);
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_waveformData);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _togglePlayPause,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width, 100.0),
                    playerController: _waveformController,
                    enableSeekGesture: true,
                    waveformData:_waveformData??[],
                    playerWaveStyle: const PlayerWaveStyle(
                      fixedWaveColor: Colors.white54,
                      liveWaveColor: Colors.blueAccent,
                      spacing: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
