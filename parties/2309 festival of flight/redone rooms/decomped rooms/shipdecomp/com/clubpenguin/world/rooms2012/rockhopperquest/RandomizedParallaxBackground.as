//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.rockhopperquest.RandomizedParallaxBackground implements com.clubpenguin.world.rooms2012.common.sequencer.items.ISequenceItem
    {
        var _libraryLinkageNames, _bounds, _container, _lastUpdate, _virtualXPositions, _clips, _leftLimit, _rightLimit, _id, _speed;
        function RandomizedParallaxBackground (container, bounds, libraryLinkageNames) {
            _libraryLinkageNames = libraryLinkageNames;
            _bounds = bounds;
            _container = container;
            _lastUpdate = getTimer();
            _virtualXPositions = [];
            _clips = [];
            _leftLimit = bounds.x - 60;
            _rightLimit = (bounds.x + bounds.width) + 60;
            _id = com.clubpenguin.world.rooms2012.common.UniqueID.getID("RandomizedParallaxBackground");
        }
        function init(speed, numberOfMovieClipToSpawn, startFrame) {
            var _local_8 = [];
            var _local_3 = 0;
            while (_local_3 < numberOfMovieClipToSpawn) {
                _local_8.push(Math.floor(Math.random() * _bounds.height) + _bounds.y);
                _local_3++;
            }
            _local_8.sort(Array.NUMERIC);
            var _local_2 = 0;
            while (_local_2 < numberOfMovieClipToSpawn) {
                var _local_5 = _libraryLinkageNames[Math.floor(Math.random() * _libraryLinkageNames.length)];
                var _local_6 = {_x:(_bounds.x + _bounds.width) + 100, _y:_local_8[_local_2]};
                var _local_4 = _container.attachMovie(_local_5, "clip_" + _local_2, _local_2, _local_6);
                _clips.push(_local_4);
                if (startFrame) {
                    _local_4.gotoAndStop(startFrame);
                }
                _virtualXPositions.push(_local_6._x + Math.floor(Math.random() * _bounds.width));
                _local_2++;
            }
            setSpeed(speed);
            _isEnding = false;
        }
        function compareY(a, b) {
            if (a._y < b._y) {
                return(-1);
            }
            if (a._y > b._y) {
                return(1);
            }
            return(0);
        }
        function setSpeed(newSpeed) {
            _speed = newSpeed;
        }
        function endAnimations() {
            _isEnding = true;
        }
        function update() {
            var _local_8 = getTimer();
            var _local_7 = _bounds.height - _bounds.y;
            var _local_5;
            var _local_3;
            var _local_4;
            var _local_6 = ((_local_8 - _lastUpdate) / 1000) * _speed;
            var _local_2 = _clips.length - 1;
            while (_local_2 >= 0) {
                _local_5 = _local_6 * (_clips[_local_2]._y / _local_7);
                _local_3 = _virtualXPositions[_local_2] - _local_5;
                _virtualXPositions[_local_2] = _local_3;
                _local_4 = true;
                if (_local_3 < _leftLimit) {
                    _local_3 = _rightLimit;
                    _local_4 = false;
                    if (_isEnding) {
                        _clipsDone++;
                        if (_clipsDone == _clips.length) {
                            return(true);
                        }
                    } else {
                        _virtualXPositions[_local_2] = (_bounds.x + _bounds.width) + Math.floor(Math.random() * _bounds.width);
                    }
                }
                if (_local_3 > _rightLimit) {
                    _local_3 = _rightLimit;
                    _local_4 = false;
                }
                _clips[_local_2]._visible = _local_4;
                _clips[_local_2]._x = _local_3;
                _local_2--;
            }
            _lastUpdate = getTimer();
            return(false);
        }
        function getID() {
            return(_id);
        }
        function getName() {
            return(_id);
        }
        function toString() {
            return("<RandomizedParallaxBackground />");
        }
        function toXML() {
            return(new XML("<RandomizedParallaxBackground />"));
        }
        var _isEnding = false;
        var _clipsDone = 0;
    }
