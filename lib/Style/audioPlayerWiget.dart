import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayerWithWaveform extends StatefulWidget {
  final String audioUrl;

  AudioPlayerWithWaveform({required this.audioUrl});

  @override
  _AudioPlayerWithWaveformState createState() =>
      _AudioPlayerWithWaveformState();
}

class _AudioPlayerWithWaveformState extends State<AudioPlayerWithWaveform> {
  final PlayerController _waveformController = PlayerController();
  bool _isPlaying = false;
  String? _localFilePath;

  @override
  void initState() {
    super.initState();
    _loadAndProcessAudio();
  }

  Future<void> _loadAndProcessAudio() async {
    try {
      // Get the temporary directory of the device
      final tempDir = await getTemporaryDirectory();
      final localFilePath = '${tempDir.path}/downloaded_audio.mp3';

      // Download the audio file
      await Dio().download(
        widget.audioUrl,
        localFilePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print(
                "Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      // Save the local path
      setState(() {
        _localFilePath = localFilePath;
      });

      // Prepare the player with the downloaded file
      await _waveformController.preparePlayer(
        path: _localFilePath!,
        shouldExtractWaveform: true,
      );
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _waveformController.pausePlayer();
    } else {
      _waveformController.startPlayer();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
