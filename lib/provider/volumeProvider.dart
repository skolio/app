import 'package:volume_regulator/volume_regulator.dart';

class VolumeProvider {
  int _lastVolume = 0;
  bool _muted = false;

  Stream get volumeStream => VolumeRegulator.volumeStream;

  initProvider() async {
    _lastVolume = await VolumeRegulator.getVolume();
    print(_lastVolume);

    if (_lastVolume == 0)
      VolumeRegulator.setVolume(100);
    else
      VolumeRegulator.setVolume(0);

    _muted = _lastVolume == 0;
    VolumeRegulator.setVolume(_lastVolume);
  }

  toggleVolume() async {
    print("We are doing something right now");
    print(_lastVolume);

    if (_muted) {
      if (_lastVolume == 0) _lastVolume = 50;
      VolumeRegulator.setVolume(_lastVolume);
    } else {
      _lastVolume = await VolumeRegulator.getVolume();
      VolumeRegulator.setVolume(0);
    }

    _muted = !_muted;
  }
}

final volumeProvider = VolumeProvider();
