//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.balloons.BalloonManager extends MovieClip
    {
        var _shell, _engine, _interface, attachMovie, onEnterFrame;
        function BalloonManager () {
            super();
        }
        function setDependencies(shell, engine, _interface) {
            _shell = shell;
            _engine = engine;
            this._interface = _interface;
            BALLOON_TEXT_FORMAT = _interface.embeddedFontsClip.burbankSmall.getTextFormat();
            BALLOON_TEXT_FORMAT.leading = 0;
        }
        function createMC(playerID, depth, init, linkageOb) {
            var _local_8 = "p" + playerID;
            if (this[_local_8] != undefined) {
                return(false);
            }
            if ((depth == undefined) || (depth < 0)) {
                depth = _engine.findPlayerDepth(playerID);
                if (depth == _engine.SPEECH_BUBBLE_DEPTH_EMPTY_VALUE) {
                    return(false);
                }
            }
            if (init == undefined) {
                var _local_7 = _engine.getPlayerMovieClip(playerID);
                init = {_x:_local_7._x, _y:_local_7._y};
            }
            var _local_2;
            if (linkageOb.linkage == undefined) {
                if (_shell.isPlayerBuddyById(playerID)) {
                    _local_2 = BALLOON_BUDDY_LINKAGE;
                } else if (_shell.isPlayerMascotById(playerID)) {
                    _local_2 = BALLOON_MASCOT_LINKAGE;
                } else {
                    _local_2 = BALLOON_DEFAULT_LINKAGE;
                }
                linkageOb.linkage = _local_2;
            } else {
                _local_2 = linkageOb.linkage;
            }
            var _local_3 = this.attachMovie(_local_2, _local_8, depth, init);
            if (_engine.getRoomMovieClip().invertedPenguins) {
                _local_3._yscale = -100;
            }
            if (_local_3 == undefined) {
                return(false);
            }
            _local_3.type = _local_2;
            _local_3.gotoAndStop(com.clubpenguin.ui.balloons.AbstractBalloon.PARKED_FRAME);
            _local_3.cacheAsBitmap = true;
            return(true);
        }
        function changeMC(playerID, linkageOb) {
            var _local_6 = "p" + playerID;
            var _local_2 = this[_local_6];
            if (_local_2 == undefined) {
                return(false);
            }
            var _local_4 = _local_2.getDepth();
            var _local_5 = {_x:_local_2._x, _y:_local_2._y};
            removeMC(playerID);
            return(createMC(playerID, _local_4, _local_5, linkageOb));
        }
        function removeMC(playerID) {
            var _local_3 = getBalloonByPlayerID(playerID);
            if (_local_3 != undefined) {
                remove(_local_3);
            }
            var _local_2 = getMC(playerID);
            if (_local_2 == undefined) {
                return(undefined);
            }
            _local_2.removeMovieClip();
        }
        function getMC(playerID) {
            var _local_3 = "p" + playerID;
            var _local_2 = this[_local_3];
            if (_local_2 != undefined) {
                return(_local_2);
            }
            return(null);
        }
        function mcExistsByID(playerID) {
            if (this["p" + playerID] != undefined) {
                return(true);
            }
            return(false);
        }
        function showTextBalloon(playerID, message, linkageName, mcParamsObj) {
            if (!message.length) {
                return(undefined);
            }
            var _local_6 = getBalloonByPlayerID(playerID).linkage;
            var _local_5 = {linkage:linkageName};
            var _local_3;
            if (!mcExistsByID(playerID)) {
                _local_3 = createMC(playerID, null, mcParamsObj, _local_5);
            } else if (_local_6 != linkageName) {
                _local_3 = changeMC(playerID, _local_5);
            } else {
                _local_3 = true;
            }
            if (_local_3) {
                var _local_2 = com.clubpenguin.ui.balloons.TextBalloon(getTypedBalloonByPlayerID(playerID, com.clubpenguin.ui.balloons.TextBalloon));
                _local_2.linkage = _local_5.linkage;
                _local_2.duration = BALLOON_DURATION;
                _local_2.message = message;
                _local_2.textFormat = BALLOON_TEXT_FORMAT;
                _local_2.maxWidth = BALLOON_DEFAULT_WIDTH;
                _local_2.show();
                add(_local_2);
            }
        }
        function showEmoteBalloon(playerID, emoteID, linkageName, mcParamsObj, duration) {
            var _local_7 = getBalloonByPlayerID(playerID).linkage;
            var _local_5 = {linkage:linkageName};
            var _local_4;
            if (!mcExistsByID(playerID)) {
                _local_4 = createMC(playerID, null, mcParamsObj, _local_5);
            } else if (_local_7 != linkageName) {
                _local_4 = changeMC(playerID, _local_5);
            } else {
                _local_4 = true;
            }
            if (_local_4) {
                var _local_2 = com.clubpenguin.ui.balloons.EmoteBalloon(getTypedBalloonByPlayerID(playerID, com.clubpenguin.ui.balloons.EmoteBalloon));
                _local_2.linkage = _local_5.linkage;
                _local_2.duration = ((duration != undefined) ? (duration) : (BALLOON_DURATION));
                _local_2.emoteFrame = emoteID;
                _local_2.setSize(BALLOON_EMOTE_WIDTH, BALLOON_EMOTE_HEIGHT);
                _local_2.show();
                add(_local_2);
            }
            var _local_6 = _shell.getPlayerObjectById(playerID);
            _local_6.emoteIDDisplayedInCurrentRoom = emoteID;
            _shell.updateListeners(_shell.SHOW_EMOTE, {player_id:playerID, emote_id:emoteID});
        }
        function getTypedBalloonByPlayerID(playerID, type) {
            var _local_2 = "p" + playerID;
            var _local_3 = _activeBalloons[_local_2] || (_inactiveBalloons[_local_2]);
            if (_local_3 instanceof type) {
                return(_local_3);
            }
            remove(_local_3);
            _local_3 = com.clubpenguin.ui.balloons.AbstractBalloon(new type[undefined](this["p" + playerID]));
            return(_local_3);
        }
        function getBalloonByPlayerID(playerID) {
            var _local_2 = "p" + playerID;
            return(_activeBalloons[_local_2] || (_inactiveBalloons[_local_2]));
        }
        function add(balloon) {
            if (!_running) {
                init();
            }
            if (_activeBalloons[balloon.name] == undefined) {
                _numActiveBalloons++;
            }
            _activeBalloons[balloon.name] = balloon;
            if (_inactiveBalloons[balloon.name] != undefined) {
                _inactiveBalloons[balloon.name] = undefined;
                delete _inactiveBalloons[balloon.name];
            }
        }
        function remove(balloon) {
            deactivate(balloon);
            _inactiveBalloons[balloon.name] = null;
            delete _inactiveBalloons[balloon.name];
        }
        function deactivate(balloon) {
            if (_activeBalloons[balloon.name] == null) {
                return(undefined);
            }
            _inactiveBalloons[balloon.name] = balloon;
            _activeBalloons[balloon.name] = null;
            delete _activeBalloons[balloon.name];
            _numActiveBalloons--;
            if (_numActiveBalloons <= 0) {
                _numActiveBalloons = 0;
                halt();
            }
        }
        function handler() {
            var _local_2;
            for (var _local_4 in _activeBalloons) {
                _local_2 = _activeBalloons[_local_4];
                if (_local_2.counter >= _local_2.duration) {
                    if (_local_2 instanceof com.clubpenguin.ui.balloons.TextBalloon) {
                        var _local_3 = com.clubpenguin.ui.balloons.TextBalloon(_local_2);
                        if (!_local_3.isDone()) {
                            _local_3.showNextPart();
                            continue;
                        }
                    }
                    _local_2.hide();
                    deactivate(_local_2);
                }
                _local_2.counter = (_local_2.counter+1);
            }
        }
        function init() {
            _running = true;
            onEnterFrame = handler;
        }
        function halt() {
            if (_numActiveBalloons > 0) {
                return(undefined);
            }
            _running = false;
            onEnterFrame = null;
            delete onEnterFrame;
        }
        function reset() {
            for (var _local_2 in this) {
                if (this[_local_2] instanceof MovieClip) {
                    if ((this[_local_2]._name.charAt(0) == "p") && (this[_local_2]._parent == this)) {
                        this[_local_2].removeMovieClip();
                    }
                }
            }
            _inactiveBalloons = {};
            _activeBalloons = {};
            _numActiveBalloons = 0;
            halt();
        }
        static var BALLOON_DURATION = 125;
        static var BALLOON_EMOTE_WIDTH = 64;
        static var BALLOON_EMOTE_HEIGHT = 34;
        static var BALLOON_DEFAULT_WIDTH = 135;
        static var BALLOON_TEXT_FORMAT = new TextFormat();
        static var BALLOON_DEFAULT_LINKAGE = "DefaultBalloon";
        static var BALLOON_BUDDY_LINKAGE = "DefaultBalloon";
        static var BALLOON_MASCOT_LINKAGE = "DefaultBalloon";
        static var BALLOON_BLOCKED_LINKAGE = "DefaultBalloon";
        var _activeBalloons = {};
        var _inactiveBalloons = {};
        var _numActiveBalloons = 0;
        var _running = false;
    }
