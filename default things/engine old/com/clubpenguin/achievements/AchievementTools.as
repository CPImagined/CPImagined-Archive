
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementTools
    {
        static var _shell, _engine, __get__shell, __get__engine, __get__debug, __set__shell, __set__engine, __set__debug;
        function AchievementTools () {
        }
        static function getClipFromObject(o) {
            switch (o.type) {
                case _shell.BALL_LAND : 
                    return(_engine.getRoomMovieClip()["i" + o.id]);
                    break;
                default : 
            }
            return(null);
        }
        static function getClipsFromIDs(ids) {
            var _local4 = [];
            var _local2 = 0;
            while (_local2 < ids.length) {
                if (ids[_local2].player_id != null) {
                    var _local8 = _engine.getPlayerMovieClip(ids[_local2].player_id);
                    if (_local8 != null) {
                        _local4.push(_local8);
                    }
                } else if (ids[_local2].type != null) {
                    var _local8 = getClipFromObject(ids[_local2]);
                    if (_local8 != null) {
                        _local4.push(_local8);
                    }
                } else {
                    switch (ids[_local2]) {
                        case "user" : 
                            debugTrace("Push the user clip: " + _engine.getPlayerMovieClip(_shell.getMyPlayerId()));
                            _local4.push(_engine.getPlayerMovieClip(_shell.getMyPlayerId()));
                            break;
                        case "anyExceptUser" : 
                            var _local6 = _shell.getPlayerList();
                            var _local3 = 0;
                            while (_local3 < _local6.length) {
                                if (_local6[_local3].player_id != _shell.getMyPlayerId()) {
                                    _local4.push(_engine.getPlayerMovieClip(_local6[_local3].player_id));
                                }
                                _local3++;
                            }
                            break;
                        case "any" : 
                            _local6 = _shell.getPlayerList();
                            _local3 = 0;
                            while (_local3 < _local6.length) {
                                _local4.push(_engine.getPlayerMovieClip(_local6[_local3].player_id));
                                _local3++;
                            }
                            break;
                        default : 
                            debugTrace(("unrecognised token '" + ids[_local2]) + "' is this a room clip?");
                            var _local7 = ids[_local2].split(".");
                            var _local1 = _engine.getRoomMovieClip();
                            while ((_local7.length > 0) && (_local1 != undefined)) {
                                _local1 = _local1[_local7.shift()];
                            }
                            debugTrace("room is " + _engine.getRoomMovieClip());
                            debugTrace("clip is " + _local1);
                            if (_local1 != null) {
                                _local4.push(_local1);
                            }
                            break;
                    }
                }
                _local2++;
            }
            return(_local4);
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
