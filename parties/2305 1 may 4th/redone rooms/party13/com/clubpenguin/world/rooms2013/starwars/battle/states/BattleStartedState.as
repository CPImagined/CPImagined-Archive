//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.battle.states.BattleStartedState extends com.clubpenguin.world.rooms2013.starwars.battle.states.BaseBattleState
    {
        var _timeoutMilliseconds, _soundManager, _flipAttackWidget, _startTime, _numLoadedAvatars, _enterFrameMc, _engine, _battle, _controller, _timerIntervalId, _attackWidget, _creatorMc, _shell, _nextHitSound, _interface;
        function BattleStartedState (manager, controller, battle, timeoutSeconds) {
            super("BattleStartedState", manager, controller, battle);
            _timeoutMilliseconds = timeoutSeconds * 1000;
            _soundManager = com.clubpenguin.world.rooms.BaseRoom.current.soundManager;
            randomizeNextHitSound();
            _flipAttackWidget = false;
        }
        function onEnterState() {
            _startTime = getTimer();
            _numLoadedAvatars = 0;
            _enterFrameMc = _engine.createEmptyMovieClip("StarWarsBattleEnterFrame_" + _battle.creatorId, _engine.getNextHighestDepth());
            if (!com.clubpenguin.world.rooms2013.starwars.StarWarsParty.isPlayerABattleAvatar(_battle.creatorId)) {
                _controller.loadCreatorAvatar().addOnce(com.clubpenguin.util.Delegate.create(this, onAvatarLoaded, true), this);
            } else {
                _numLoadedAvatars = 1;
            }
            _controller.loadChallengerAvatar().addOnce(com.clubpenguin.util.Delegate.create(this, onAvatarLoaded, false), this);
        }
        function onExitState() {
            clearInterval(_timerIntervalId);
            _attackWidget.unloadMovie();
            _attackWidget.removeMovieClip();
            _enterFrameMc.removeMovieClip();
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
                _controller.moveChallengerToCreator(_battle.challengerId);
                _local_3.art_mc.gotoAndStop("pose");
                _controller.tintAvatar(_battle.challengerId);
            }
            if (_numLoadedAvatars == 2) {
                _local_2.art_mc.gotoAndStop("duel");
                _local_3.art_mc.gotoAndStop("duel");
                _controller.tintAvatar(_battle.creatorId);
                _controller.tintAvatar(_battle.challengerId);
                _enterFrameMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onEnterFrame);
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
                    _controller.createNavigationBlocker();
                }
            }
        }
        function onEnterFrame() {
            var _local_2 = _creatorMc.art_mc.lazer._currentframe;
            if (((_local_2 == HIT_ONE_FRAME) || (_local_2 == HIT_TWO_FRAME)) || (_local_2 == HIT_THREE_FRAME)) {
                _soundManager.playSound(getNextHitSound(), com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.LAYER_LIGHT_SABER);
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
                    _local_2 = com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.SFX_LIGHT_SABER_HIT_1;
                    break;
                case 2 : 
                    _local_2 = com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.SFX_LIGHT_SABER_HIT_2;
                    break;
                case 3 : 
                    _local_2 = com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.SFX_LIGHT_SABER_HIT_3;
                    break;
            }
            return(_local_2);
        }
        function randomizeNextHitSound() {
            _nextHitSound = 1 + Math.floor(Math.random() * 2);
        }
        function showAttackSelectionWidget() {
            var _local_3 = _shell.getPath(com.clubpenguin.world.rooms2013.starwars.StarWarsParty.JEDI_ATTACK_WIDGET_PATH);
            var _local_4 = com.clubpenguin.util.URLUtils.getCacheResetURL(_local_3);
            var _local_5 = "jedi_attack_selection_mc";
            _attackWidget = _interface.interface_mc.createEmptyMovieClip(_local_5, _interface.interface_mc.getNextHighestDepth());
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onAttackSelectionWidgetLoaded));
            _local_2.loadClip(_local_4, _attackWidget, "BattleStartedState showAttackSelectionWidget()");
        }
        function onAttackSelectionWidgetLoaded(event) {
            var _local_3 = _engine.getPlayerMovieClip(_battle.creatorId);
            var _local_5 = _engine.getPlayerMovieClip(_battle.challengerId);
            var _local_2 = 58;
            var _local_4 = _local_3._x + ((_local_5._x - _local_3._x) / 2);
            _attackWidget._x = _local_4;
            _attackWidget._y = (_local_3._y - _attackWidget._height) - 50;
            if (_flipAttackWidget) {
                _attackWidget._xscale = _attackWidget._xscale * -1;
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
            _timerIntervalId = setInterval(this, "onTimerInterval", 50);
        }
        function onTimerInterval() {
            var _local_3 = getTimer();
            var _local_4 = _local_3 - _startTime;
            var _local_2 = Math.ceil((_local_4 / _timeoutMilliseconds) * 100);
            if (_local_2 != _attackWidget.widget.timer._currentframe) {
                _attackWidget.widget.timer.gotoAndStop(_local_2);
            }
            if (_local_2 >= 100) {
                clearInterval(_timerIntervalId);
            }
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
                _controller.service.sendAttackSelection(attackId);
                _soundManager.playSound(com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.SFX_ATTACK_SELECT, null);
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
        static var HIT_ONE_FRAME = 8;
        static var HIT_TWO_FRAME = 18;
        static var HIT_THREE_FRAME = 31;
    }
