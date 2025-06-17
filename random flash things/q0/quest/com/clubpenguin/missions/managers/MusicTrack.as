//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.missions.managers.MusicTrack
    {
        var _name, _url, _containerClip, _musicClip, _sound, dispatchEvent;
        function MusicTrack ($name, $url, $target) {
            mx.events.EventDispatcher.initialize(this);
            _name = $name;
            _url = $url;
            _containerClip = $target;
            _musicClip = _containerClip.createEmptyMovieClip($name + "MusicClip", _containerClip.getNextHighestDepth());
            _musicClip.loadMovie(_url);
            _containerClip.onEnterFrame = mx.utils.Delegate.create(this, checkMusicClip);
        }
        function checkMusicClip() {
            if (_musicClip.getBytesTotal() > 0) {
                _musicClip.stop();
                _sound = new Sound(_musicClip);
                delete _containerClip.onEnterFrame;
                dispatchEvent(new com.clubpenguin.missions.managers.MusicTrackEvent(com.clubpenguin.missions.managers.MusicTrackEvent.INIT, this));
            }
        }
        function play() {
            _musicClip.play();
        }
        function stop() {
            _musicClip.stop();
        }
        function fade($startVolume, $endVolume, $fadeDuration) {
            _sound.setVolume($startVolume);
            gs.TweenLite.to(_musicClip, $fadeDuration, {volume:$endVolume});
        }
        function setVolume($volumeLevel) {
            _sound.setVolume($volumeLevel);
        }
        function remove() {
            _musicClip.removeMovieClip();
        }
    }
