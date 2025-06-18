//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelroof.RainbowCannon
    {
        var _this, _INTERFACE, _SHELL;
        function RainbowCannon (cannonReference) {
            _this = cannonReference;
            _INTERFACE = _global.getCurrentInterface();
            _SHELL = _global.getCurrentShell();
            _this.cannonAnimation_mc.gotoAndStop("idleState");
            _this.cannon_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, cannonRollOver, "over");
            _this.cannon_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, cannonRollOver, "out");
        }
        function playCannonAnimation() {
            _this.cannon_btn._visible = false;
            _this.cannon_btn.enabled = false;
            _this.cannonAnimation_mc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackGuestCannonAnimation);
            _this.cannonAnimation_mc.gotoAndPlay(15);
        }
        function trackGuestCannonAnimation() {
            var _local_2 = _this.cannonAnimation_mc;
            if (_local_2._currentframe == 1) {
                _local_2.gotoAndPlay(15);
            }
            if (_local_2._currentframe == END_FRAME_OF_CANNON_ANIM) {
                _local_2.gotoAndStop(1);
                _this.cannon_btn._visible = true;
                _this.cannon_btn.enabled = true;
                delete _local_2.onEnterFrame;
                return(undefined);
            }
        }
        function cannonRollOver(state) {
            switch (state) {
                case "over" : 
                    _this.cannonAnimation_mc.gotoAndStop("rollOverState");
                    break;
                case "out" : 
                    _this.cannonAnimation_mc.gotoAndStop("idleState");
                    break;
            }
        }
        function accessCannon(players) {
            playersOnCannon = players;
            var _local_6 = false;
            var _local_7;
            var _local_4 = 0;
            while (_local_4 < players.length) {
                var _local_3 = _SHELL.getPlayerObjectById(players[_local_4]);
                if (canPlayerAccessCannon(_local_3)) {
                    _local_6 = true;
                    _local_7 = _local_3;
                    break;
                }
                _local_4++;
            }
            if (((_this.cannonAnimation_mc._currentframe == 1) || (_this.cannonAnimation_mc._currentframe == 140)) && (_local_6)) {
                _global.getCurrentEngine().getPlayerMovieClip(_local_3.player_id)._visible = false;
                _global.getCurrentEngine().getNicknameMovieClip(_local_3.player_id)._visible = false;
                if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_3, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                    _global.getCurrentEngine().puffleAvatarController.hidePuffle(_local_3.attachedPuffle.id);
                }
                fireCannon(_local_7);
            }
        }
        function playersRemovedFromCannon(players) {
            var _local_5 = 0;
            while (_local_5 < playersOnCannon.length) {
                var _local_3 = 0;
                while (_local_3 < players.length) {
                    if (playersOnCannon[_local_5] == players[_local_3]) {
                        playersOnCannon.splice(_local_5, 1);
                        _global.getCurrentEngine().getPlayerMovieClip(players[_local_3])._visible = true;
                        _global.getCurrentEngine().getNicknameMovieClip(players[_local_3])._visible = true;
                        if (_SHELL.isMyPlayer(players[_local_3])) {
                            _internalCannonFrameCounter = 0;
                            _this.cannonAnimation_mc.gotoAndStop(1);
                            delete _this.cannonAnimation_mc.onEnterFrame;
                        }
                    }
                    _local_3++;
                }
                _local_5++;
            }
            if (playersOnCannon.length == 0) {
                _this.cannonAnimation_mc.gotoAndStop(1);
                _this.cannon_btn._visible = true;
            }
        }
        function canPlayerAccessCannon(playerObj) {
            if (!_SHELL.isMyPlayer(playerObj.player_id)) {
                return(false);
            }
            if (!playerObj.is_member) {
                _global.getCurrentInterface().showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.NONMEMBER_OOPS_CANNON);
                return(false);
            }
            if (_SHELL.getRainbowPuffleQuest().getIsCannonAvailable()) {
                return(true);
            } else {
                _INTERFACE.showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.CANNON_LOCKED_MESSAGE);
                return(false);
            }
        }
        function fireCannon(playerObj) {
            _this.cannonAnimation_mc.gotoAndPlay(2);
            _this.cannon_btn._visible = false;
            if (_SHELL.isMyPlayer(playerObj.player_id)) {
                enterFrameCount = enterFrameCount + 1;
                _this.cannonAnimation_mc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackCannonAnimation, enterFrameCount);
            }
        }
        function trackCannonAnimation(enterFrameCount) {
            var _local_3 = _this.cannonAnimation_mc;
            if (_local_3._currentframe == 1) {
                _local_3.gotoAndPlay(2);
            }
            if (_local_3._currentframe == END_FRAME_OF_CANNON_ANIM) {
                _internalCannonFrameCounter = 0;
                _local_3.gotoAndStop(1);
                _this.cannon_btn._visible = true;
                exit("cloudforest", 100, 200);
                delete _local_3.onEnterFrame;
                return(undefined);
            }
            if (_internalCannonFrameCounter == (END_FRAME_OF_CANNON_ANIM + 5)) {
                _local_3.gotoAndStop(1);
                _this.cannon_btn._visible = true;
                _internalCannonFrameCounter = 0;
                delete _local_3.onEnterFrame;
                _global.getCurrentEngine().getPlayerMovieClip(_SHELL.getMyPlayerId())._visible = true;
                _global.getCurrentEngine().getNicknameMovieClip(_SHELL.getMyPlayerId())._visible = true;
            }
            _internalCannonFrameCounter++;
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function clean() {
            delete _this.cannonAnimation_mc.onEnterFrame;
            _internalCannonFrameCounter = 0;
        }
        static var END_FRAME_OF_CANNON_ANIM = 135;
        var playersOnCannon = new Array();
        var _internalCannonFrameCounter = 0;
        var enterFrameCount = 0;
    }
