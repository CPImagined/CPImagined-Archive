//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementTools
    {
        static var _shell, _engine, __get__shell, __get__engine, __get__debug;
        function AchievementTools () {
        }
        static function getClipFromObject(o) {
            switch (o.type) {
                case _shell.BALL_LAND : 
                    return(_engine.getRoomMovieClip()["i" + o.id]);
                    return(null);
                default : 
            }
            return(null);
        }
        static function getClipsFromIDs(ids) {
            var _local_4 = [];
            var _local_2 = 0;
            while (_local_2 < ids.length) {
                if (ids[_local_2].player_id != null) {
                    var _local_8 = _engine.getPlayerMovieClip(ids[_local_2].player_id);
                    if (_local_8 != null) {
                        _local_4.push(_local_8);
                    }
                } else if (ids[_local_2].type != null) {
                    var _local_8 = getClipFromObject(ids[_local_2]);
                    if (_local_8 != null) {
                        _local_4.push(_local_8);
                    }
                } else {
                    switch (ids[_local_2]) {
                        case "user" : 
                            debugTrace("Push the user clip: " + _engine.getPlayerMovieClip(_shell.getMyPlayerId()));
                            _local_4.push(_engine.getPlayerMovieClip(_shell.getMyPlayerId()));
                            break;
                        case "anyExceptUser" : 
                            var _local_6 = _shell.getPlayerList();
                            var _local_3 = 0;
                            while (_local_3 < _local_6.length) {
                                if (_local_6[_local_3].player_id != _shell.getMyPlayerId()) {
                                    _local_4.push(_engine.getPlayerMovieClip(_local_6[_local_3].player_id));
                                }
                                _local_3++;
                            }
                            break;
                        case "any" : 
                            _local_6 = _shell.getPlayerList();
                            _local_3 = 0;
                            while (_local_3 < _local_6.length) {
                                _local_4.push(_engine.getPlayerMovieClip(_local_6[_local_3].player_id));
                                _local_3++;
                            }
                            break;
                        default : 
                            debugTrace(("unrecognised token '" + ids[_local_2]) + "' is this a room clip?");
                            var _local_7 = ids[_local_2].split(".");
                            var _local_1 = _engine.getRoomMovieClip();
                            while ((_local_7.length > 0) && (_local_1 != undefined)) {
                                _local_1 = _local_1[_local_7.shift()];
                            }
                            debugTrace("room is " + _engine.getRoomMovieClip());
                            debugTrace("clip is " + _local_1);
                            if (_local_1 != null) {
                                _local_4.push(_local_1);
                            }
                            break;
                    }
                }
                _local_2++;
            }
            return(_local_4);
        }
        static function debugTrace(msg) {
            if (_debug) {
            }
        }
        static function set shell(s) {
            _shell = s;
            //return(__get__shell());
        }
        static function set engine(e) {
            _engine = e;
            //return(__get__engine());
        }
        static function set debug(d) {
            _debug = d;
            //return(__get__debug());
        }
        static var _debug = false;
    }
