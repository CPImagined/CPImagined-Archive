//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.destructibles.DestructibleSoundManager
    {
        var _maxConcurrentSounds, _target, _numSoundsPlaying;
        function DestructibleSoundManager (target, maxConcurrentSounds) {
            if (maxConcurrentSounds == null) {
                maxConcurrentSounds = 3;
            }
            _maxConcurrentSounds = maxConcurrentSounds;
            _target = target;
            _numSoundsPlaying = 0;
        }
        static function playNextSoundAtTarget(sounds, target) {
            var _local_1 = new Sound(target);
            _local_1.attachSound(sounds[0]);
            sounds.push(sounds.shift());
            if (_local_1.duration != undefined) {
                _local_1.start(0, 1);
            }
        }
        function tryPlayNextSound(sounds) {
            if ((canPlaySound() && (sounds != null)) && (sounds.length > 0)) {
                var _local_2 = new Sound(_target);
                _local_2.attachSound(sounds[0]);
                sounds.push(sounds.shift());
                if (_local_2.duration != undefined) {
                    _numSoundsPlaying++;
                    _local_2.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onSoundComplete, _local_2);
                    _local_2.start(0, 1);
                    return(true);
                }
            }
            return(false);
        }
        function onSoundComplete(sfx) {
            _numSoundsPlaying--;
            if (_numSoundsPlaying < 0) {
                _numSoundsPlaying = 0;
            }
        }
        function canPlaySound() {
            return(_numSoundsPlaying < _maxConcurrentSounds);
        }
    }
