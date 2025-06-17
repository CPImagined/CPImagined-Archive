//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementEvent
    {
        static var _subjectFactory;
        var _debug, _shell, _customEventId, _subject, _eventType, _customEventType, _refToLocalCallback, _eventCallback, __get__shell, __get__eventCallback;
        function AchievementEvent (shell, descriptor, debug) {
            _debug = debug || false;
            _shell = shell;
            _customEventId = INVALID_INTERVAL_ID;
            debugTrace(("AchievementEvent: (" + descriptor.join(" ")) + ")");
            if (_subjectFactory == null) {
                _subjectFactory = new com.clubpenguin.achievements.subjects.AchievementSubjectFactory();
            }
            if (descriptor[0] != "every") {
                _subjectFactory.debug = debug;
                _subject = _subjectFactory.createSubject(descriptor);
                _subject.debug = debug;
                _subject.shell = _shell;
            }
            var _local_3 = String(descriptor.shift());
            var _local_4;
            var _local_6;
            debugTrace("type: " + _local_3);
            switch (_local_3) {
                case "login" : 
                    _eventType = _shell.WORLD_CONNECT_SUCCESS;
                    break;
                case "enterIgloo" : 
                    _eventType = _shell.JOIN_PLAYER_IGLOO;
                    break;
                case "enterRoom" : 
                    _eventType = _subject.getEnterRoomEvent();
                    break;
                case "leaveRoom" : 
                    _eventType = _shell.REMOVE_PLAYER;
                    break;
                case "iglooFurnitureLoaded" : 
                    _eventType = _shell.IGLOO_FURNITURE_COMPLETE;
                    break;
                case "iglooEdited" : 
                    _eventType = _shell.IGLOO_EDIT_MODE;
                    break;
                case "wearItem" : 
                    _eventType = _shell.UPDATE_PLAYER;
                    break;
                case "throwSnowball" : 
                    _eventType = _shell.THROW_BALL;
                    break;
                case "snowballHit" : 
                    _eventType = _shell.BALL_LAND;
                    break;
                case "move" : 
                    _eventType = _shell.PLAYER_MOVE;
                    break;
                case "moveEnd" : 
                    _eventType = _shell.PLAYER_MOVE_DONE;
                    break;
                case "changesFrame" : 
                    _eventType = _shell.PLAYER_FRAME;
                    break;
                case "playerAction" : 
                    _eventType = _shell.PLAYER_ACTION;
                    break;
                case "purchaseItem" : 
                    _eventType = _shell.BUY_INVENTORY;
                    break;
                case "sendMessage" : 
                    _eventType = _shell.SEND_MESSAGE;
                    break;
                case "purchaseFurniture" : 
                    _eventType = _shell.BUY_FURNITURE;
                    break;
                case "sendEmote" : 
                    _eventType = _shell.SHOW_EMOTE;
                    break;
                case "hasAchievementEvent" : 
                    _eventType = _shell.ACHIEVEMENT_EVENT;
                    break;
                case "every" : 
                    _customEventType = CUSTOM_EVENT_PERIODIC;
                    _local_6 = String(descriptor.shift());
                    _local_4 = String(descriptor.shift());
                    break;
                default : 
                    throw new com.clubpenguin.achievements.AchievementException(("AchievementEvent did not recognise event type:\"" + _local_3) + "\"");
                    break;
            }
            if (_eventType != null) {
                debugTrace("_eventType: " + _eventType);
                _refToLocalCallback = com.clubpenguin.util.Delegate.create(this, onEvent);
                if (!_shell.addListener(_eventType, _refToLocalCallback, null)) {
                    throw new com.clubpenguin.achievements.AchievementException(("AchievementEvent could not add a listener for event type:\"" + _local_3) + "\"");
                }
            }
            if (_customEventType != null) {
                debugTrace("_customEventType: " + _customEventType);
                if (_customEventType == CUSTOM_EVENT_PERIODIC) {
                    var _local_5 = getIntervalPeriod(_local_4, _local_6);
                    _customEventId = setInterval(this, "onEvent", _local_5, null);
                }
            }
        }
        function destroy() {
            if (_eventType != null) {
                _shell.removeListener(_eventType, _refToLocalCallback);
                _refToLocalCallback = null;
                _eventType = null;
            }
            if (_customEventType != null) {
                if (_customEventId != INVALID_INTERVAL_ID) {
                    clearInterval(_customEventId);
                    _customEventId = INVALID_INTERVAL_ID;
                }
                _customEventType = null;
            }
        }
        function onEvent(event) {
            debugTrace(("onEvent - _eventType: '" + (_eventType || ("Custom " + _customEventType))) + "'");
            if ((_subject == null) || (_subject.shouldEventFire(event))) {
                _eventCallback(event);
            }
        }
        static function getIntervalPeriod(periodMultiplier, value) {
            var _local_1;
            switch (periodMultiplier) {
                case "second" : 
                case "seconds" : 
                    _local_1 = INTERVAL_SECOND;
                    break;
                case "minute" : 
                case "minutes" : 
                    _local_1 = INTERVAL_MINUTE;
                    break;
                case "hour" : 
                case "hours" : 
                    _local_1 = INTERVAL_HOUR;
                    break;
                case "day" : 
                case "days" : 
                    _local_1 = INTERVAL_DAY;
                    break;
                default : 
                    throw new com.clubpenguin.achievements.AchievementException(("AchievementEvent::getIntervalPeriod did not recognise periodMultiplier type:\"" + periodMultiplier) + "\"");
            }
            var _local_2 = _local_1 * Number(value);
            if (isNaN(_local_2)) {
                throw new com.clubpenguin.achievements.AchievementException(((("AchievementEvent::getIntervalPeriod calculated an invalid period from the description: \"" + value) + " ") + periodMultiplier) + "\"");
            }
            return(_local_2);
        }
        function set shell(s) {
            _shell = s;
            //return(__get__shell());
        }
        function set eventCallback(callback) {
            _eventCallback = callback;
            //return(__get__eventCallback());
        }
        function get type() {
            return(_eventType);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        static var CUSTOM_EVENT_PERIODIC = 0;
        static var INVALID_INTERVAL_ID = -1;
        static var INTERVAL_SECOND = 1000;
        static var INTERVAL_MINUTE = 60 * INTERVAL_SECOND;
        static var INTERVAL_HOUR = 60 * INTERVAL_MINUTE;
        static var INTERVAL_DAY = 24 * INTERVAL_HOUR;
    }
