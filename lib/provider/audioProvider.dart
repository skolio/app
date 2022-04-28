import 'package:audioplayers/audioplayers.dart';

class AudioProvider {
  AudioPlayer _audioPlayer = AudioPlayer();

  Stream get playerState => _audioPlayer.onPlayerStateChanged;

  togglePlayer() {
    print(_audioPlayer.state);
    if (_audioPlayer.state == PlayerState.PLAYING)
      _audioPlayer.pause();
    else
      _audioPlayer.resume();
  }

  setURL(String url) async {
    print(url);

    await _audioPlayer.setUrl(url);
    await _audioPlayer.pause();
    _audioPlayer.getDuration();
  }

  Future<int> getDuration() => _audioPlayer.getDuration();

  stopPlayingAudio() {
    _audioPlayer.stop();
  }
}
