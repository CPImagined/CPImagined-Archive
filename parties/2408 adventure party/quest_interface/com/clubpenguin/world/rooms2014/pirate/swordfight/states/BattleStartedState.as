//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStartedState extends com.clubpenguin.world.rooms2014.pirate.swordfight.states.BaseBattleState
    {
        var _timeoutMilliseconds, _flipAttackWidget, _startTime, _numLoadedAvatars, _enterFrameMc, _engine, _battle, _controller, _shell, _destroyDelegate, _timerIntervalId, _attackWidget, _creatorMc, _nextHitSound;
        function BattleStartedState (manager, controller, battle, timeoutSeconds) {
            super("BattleStartedState", manager, controller, battle);
            _timeoutMilliseconds = timeoutSeconds;
            _flipAttackWidget = false;
        }
        function onEnterState() {
            _startTime = getTimer();
            _numLoadedAvatars = 0;
            _enterFrameMc = _engine.createEmptyMovieClip("PirateBattleEnterFrame_" + _battle.creatorId, _engine.getNextHighestDepth());
            if (!com.clubpenguin.world.rooms2014.pirate.party.PirateParty.isPlayerABattleAvatar(_battle.creatorId)) {
                _controller.loadCreatorAvatar().addOnce(com.clubpenguin.util.Delegate.create(this, onAvatarLoaded, true), this);
            } else {
                _numLoadedAvatars = 1;
            }
            _controller.loadChallengerAvatar().addOnce(com.clubpenguin.util.Delegate.create(this, onAvatarLoaded, false), this);
            if (_controller.isLocalPlayerBattle) {
                var _local_3 = _shell.getMyPlayerId();
                com.clubpenguin.world.rooms2014.pirate.party.PirateParty.sendSwordFightJoinBI(_local_3, _battle.creatorId == _local_3);
                com.clubpenguin.world.rooms2014.pirate.party.PirateParty.activatePartyCookieListener();
                com.clubpenguin.world.rooms2014.pirate.party.PiratePartyQuestCommunicator.clearDuelPlayersTimeout();
                com.clubpenguin.util.Log.debug("track if a player leaves the room");
                _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
                _shell.addListener(_shell.ROOM_DESTROYED, _destroyDelegate);
            }
            var _local_5 = _engine.getPlayerMovieClip(_battle.challengerId);
            var _local_2 = _engine.getPlayerMovieClip(_battle.creatorId);
            var _local_4;
            var _local_6;
            if (_local_5._x < _local_2._x) {
                _local_4 = _local_2._x - com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController.CHALLENGER_X_OFFSET;
            } else {
                _local_4 = _local_2._x + com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController.CHALLENGER_X_OFFSET;
            }
            _local_6 = _local_2._y;
            _engine.teleportPlayer(_battle.challengerId, _local_4, _local_6);
        }
        function onExitState() {
            clearInterval(_timerIntervalId);
            _attackWidget.unloadMovie();
            _attackWidget.removeMovieClip();
            _enterFrameMc.removeMovieClip();
            _engine.enableMouseMovement();
        }
        function onAvatarLoaded(player, newAvatar, isCreator) {
            _numLoadedAvatars++;
            var _local_2 = _engine.getPlayerMovieClip(_battle.creatorId);
            var _local_3 = _engine.getPlayerMovieClip(_battle.challengerId);
            _creatorMc = _local_2;
            if (isCreator) {
                _local_2.art_mc.gotoAndStop("pose");
                _controller.tintAvatar(_battle.creatorId);
            } else {
                _local_3.art_mc.gotoAndStop("pose");
                _controller.tintAvatar(_battle.challengerId);
            }
            if (_numLoadedAvatars == 2) {
                com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.stopPenguinInvitation(_battle.creatorId);
                _local_2.art_mc.gotoAndStop("duel");
                _local_3.art_mc.gotoAndStop("duel");
                _controller.tintAvatar(_battle.creatorId);
                _controller.tintAvatar(_battle.challengerId);
                if (_local_3._x < _local_2._x) {
                    if (_shell.isMyPlayer(_battle.creatorId)) {
                        _flipAttackWidget = true;
                    }
                    _local_2._xscale = _local_2._xscale * -1;
                } else if (_local_2._x < _local_3._x) {
                    if (_shell.isMyPlayer(_battle.challengerId)) {
                        _flipAttackWidget = true;
                    }
                    _local_3._xscale = _local_3._xscale * -1;
                }
                if ((_battle.creatorId == _shell.getMyPlayerId()) || (_battle.challengerId == _shell.getMyPlayerId())) {
                    showAttackSelectionWidget();
                }
                if (_shell.isMyPlayer(_battle.creatorId) || (_shell.isMyPlayer(_battle.challengerId))) {
                    _engine.disableMouseMovement();
                    _controller.createNavigationBlocker();
                }
            }
        }
        function onEnterFrame() {
            var _local_2 = _creatorMc.art_mc.lazer._currentframe;
            if (((_local_2 == HIT_ONE_FRAME) || (_local_2 == HIT_TWO_FRAME)) || (_local_2 == HIT_THREE_FRAME)) {
                if (_local_2 == HIT_THREE_FRAME) {
                    randomizeNextHitSound();
                }
            }
        }
        function getNextHitSound() {
            _nextHitSound++;
            if (_nextHitSound > 3) {
                _nextHitSound = 1;
            }
            var _local_2;
            switch (_nextHitSound) {
                case 1 : 
                    _local_2 = com.clubpenguin.world.rooms2014.pirate.swordfight.BattleSoundManager.SFX_LIGHT_SABER_HIT_1;
                    break;
                case 2 : 
                    _local_2 = com.clubpenguin.world.rooms2014.pirate.swordfight.BattleSoundManager.SFX_LIGHT_SABER_HIT_2;
                    break;
                case 3 : 
                    _local_2 = com.clubpenguin.world.rooms2014.pirate.swordfight.BattleSoundManager.SFX_LIGHT_SABER_HIT_3;
                    break;
            }
            return(_local_2);
        }
        function randomizeNextHitSound() {
            _nextHitSound = 1 + Math.floor(Math.random() * 2);
        }
        function showAttackSelectionWidget() {
            var _local_4 = _shell.getPath(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.SWORD_ATTACK_WIDGET_PATH);
            var _local_5 = com.clubpenguin.util.URLUtils.getCacheResetURL(_local_4);
            var _local_2 = _engine.getRoomMovieClip();
            _attackWidget = _local_2.createEmptyMovieClip(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.attackWidgetHolderName, _local_2.getNextHighestDepth());
            var _local_3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onAttackSelectionWidgetLoaded));
            _local_3.loadClip(_local_5, _attackWidget, "BattleStartedState showAttackSelectionWidget()");
        }
        function onAttackSelectionWidgetLoaded(event) {
            var _local_3 = _engine.getPlayerMovieClip(_battle.creatorId);
            var _local_5 = _engine.getPlayerMovieClip(_battle.challengerId);
            var _local_2 = 58;
            var _local_4 = _local_3._x + ((_local_5._x - _local_3._x) / 2);
            _attackWidget._x = _local_4;
            _attackWidget._y = (_local_3._y - _attackWidget._height) - 50;
            _attackWidget.timer.gotoAndStop(1);
            if (_flipAttackWidget) {
                _attackWidget.widget._xscale = _attackWidget.widget._xscale * -1;
            }
            if (_attackWidget._y < 0) {
                _attackWidget._y = _local_3._y + 30;
            }
            if ((_attackWidget._x - (_local_2 / 2)) < 0) {
                _attackWidget._x = _local_2 / 2;
            } else if ((_attackWidget._x + (_local_2 / 2)) > Stage.width) {
                _attackWidget._x = Stage.width - (_local_2 / 2);
            }
            _attackWidget.widget.attack_0.onRelease = com.clubpenguin.util.Delegate.create(this, onAttackSelected, 0);
            _attackWidget.widget.attack_1.onRelease = com.clubpenguin.util.Delegate.create(this, onAttackSelected, 1);
            _attackWidget.widget.attack_2.onRelease = com.clubpenguin.util.Delegate.create(this, onAttackSelected, 2);
            _attackWidget.widget.attack_0.onRollOver = com.clubpenguin.util.Delegate.create(this, onAttackRollover, 0);
            _attackWidget.widget.attack_1.onRollOver = com.clubpenguin.util.Delegate.create(this, onAttackRollover, 1);
            _attackWidget.widget.attack_2.onRollOver = com.clubpenguin.util.Delegate.create(this, onAttackRollover, 2);
            _attackWidget.widget.attack_0.onRollOut = com.clubpenguin.util.Delegate.create(this, onAttackRollout, 0);
            _attackWidget.widget.attack_1.onRollOut = com.clubpenguin.util.Delegate.create(this, onAttackRollout, 1);
            _attackWidget.widget.attack_2.onRollOut = com.clubpenguin.util.Delegate.create(this, onAttackRollout, 2);
            _attackWidget.widget.attack_0.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, onAttackRollover, 0);
            _attackWidget.widget.attack_1.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, onAttackRollover, 1);
            _attackWidget.widget.attack_2.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, onAttackRollover, 2);
            _timerIntervalId = setInterval(com.clubpenguin.util.Delegate.create(this, onTimerInterval), 1000);
        }
        function onTimerInterval() {
            if (_attackWidget.timer._currentframe == _attackWidget.timer._totalFrames) {
                clearInterval(_timerIntervalId);
            } else {
                _attackWidget.timer.nextFrame();
            }
            com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playTimerTick(_shell.getMyPlayerId());
        }
        function onAttackSelected(attackId) {
            if ((attackId >= 0) && (attackId <= 2)) {
                _attackWidget.widget.attack_0.onRelease = null;
                _attackWidget.widget.attack_1.onRelease = null;
                _attackWidget.widget.attack_2.onRelease = null;
                _attackWidget.widget.attack_0.onRollOver = null;
                _attackWidget.widget.attack_1.onRollOver = null;
                _attackWidget.widget.attack_2.onRollOver = null;
                _attackWidget.widget.attack_0.onRollOut = null;
                _attackWidget.widget.attack_1.onRollOut = null;
                _attackWidget.widget.attack_2.onRollOut = null;
                _attackWidget.widget.attack_0.onReleaseOutside = null;
                _attackWidget.widget.attack_1.onReleaseOutside = null;
                _attackWidget.widget.attack_2.onReleaseOutside = null;
                _attackWidget.widget["attack_" + attackId].gotoAndStop("selected");
                _controller.service.sendAttackSelection(attackId, _battle.duelId);
            }
        }
        function onAttackRollover(attackId) {
            if ((attackId >= 0) && (attackId <= 2)) {
                _attackWidget.widget["attack_" + attackId].gotoAndStop("selected");
            }
        }
        function onAttackRollout(attackId) {
            if ((attackId >= 0) && (attackId <= 2)) {
                _attackWidget.widget["attack_" + attackId].gotoAndStop(1);
            }
        }
        function destroy() {
            com.clubpenguin.util.Log.debug("BATTLESTARTEDSTATE - destroy");
            _shell.removeListener(_shell.ROOM_DESTROYED, _destroyDelegate);
            onExitState();
        }
        static var HIT_ONE_FRAME = 8;
        static var HIT_TWO_FRAME = 18;
        static var HIT_THREE_FRAME = 31;
    }
