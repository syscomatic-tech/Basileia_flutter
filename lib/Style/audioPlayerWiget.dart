import 'dart:typed_data';

import 'package:basileia/Style/colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:basileia/RestAPI/RestClient.dart';

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
  Uint8List? audio_data;
  bool _isPlaying = false;
  List<double> _generateWaveformData(Uint8List audioData) {
    // Implement actual logic to generate waveform data from audio bytes.
    // The following is placeholder logic, you'll need a proper method here.
    return List.generate(100, (index) => (index % 10 + 1) * 0.1);
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    fetchAudioData(widget.audioUrl).then((data) {
      audio_data = data;
      _audioPlayer.setUrl(widget.audioUrl).then((_) {
        _audioPlayer.positionStream.listen((position) {
          _waveformController.onPlayerStateChanged.listen((_) {});
        });
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _waveformController.dispose();
    super.dispose();
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
                  waveformType: WaveformType.long,
                  waveformData: _generateWaveformData(audio_data!),
                  playerWaveStyle: const PlayerWaveStyle(
                    fixedWaveColor: Colors.white54,
                    liveWaveColor: Colors.blueAccent,
                    spacing: 6,
                  ),
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
