//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.states.PerformNormalState extends com.clubpenguin.world.rooms2014.muppets.performance.states.BasePerformanceState
    {
        var _active, _shell, _interface, _engine, _party, _performance, _controller, performanceCallbackDelegate, performanceAnimation;
        function PerformNormalState (manager, controller, performance) {
            super("PerformNormalState", manager, controller, performance);
            _active = false;
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
        }
        function onEnterState() {
            _active = true;
            var _local_7 = _engine.getPlayerMovieClip(_performance.hostId);
            var _local_8 = _engine.getNicknameMovieClip(_performance.hostId);
            var _local_2 = _shell.getPlayerObjectById(_performance.hostId);
            if (_local_2 != undefined) {
                _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE, _local_2);
            }
            var _local_6 = _engine.getPlayerMovieClip(_performance.participant);
            var _local_5 = _engine.getNicknameMovieClip(_performance.participant);
            var _local_4 = _shell.getPlayerObjectById(_performance.participant);
            if (_local_4 != undefined) {
                _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE, _local_4);
            }
            _local_7._visible = false;
            _local_6._visible = false;
            _local_8._visible = false;
            _local_5._visible = false;
            if (_controller.isLocalPlayerPerformance) {
                _engine.disableMouseMovement();
                com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.playPoofIn();
                _party.MuppetsParty.logMuppetDanceJoinEvent(_performance.hostId);
            }
            var _local_3 = "muppets_" + _party.MuppetsParty.getMuppetByInteractiveItem(_local_2.hand);
            performanceCallbackDelegate = com.clubpenguin.util.Delegate.create(this, onExitState);
            if (_local_3 != undefined) {
                performanceAnimation = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceAnimation(_local_3, _performance.hostId, _performance.participant, performanceCallbackDelegate);
                if (_controller.isLocalPlayerPerformance) {
                    com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.playMuppetAnimationSoundByItem(_local_2.hand);
                }
            }
        }
        function onExitState() {
            com.clubpenguin.util.Log.info(("----------- PerformNormalState onExitState" + _shell.getMyPlayerId()) + "---------------");
            _active = false;
            performanceAnimation.clean(_performance.hostId);
            var _local_3 = _engine.getPlayerMovieClip(_performance.hostId);
            var _local_8 = _engine.getNicknameMovieClip(_performance.hostId);
            var _local_5 = _shell.getPlayerObjectById(_performance.hostId);
            if (_local_3._visible == false) {
                if (_local_5 != undefined) {
                    _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE, _local_5);
                }
                var _local_7 = _engine.getPlayerMovieClip(_performance.participant);
                var _local_6 = _engine.getNicknameMovieClip(_performance.participant);
                var _local_4 = _performance.participant;
                if (_local_4 != undefined) {
                    _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE, _shell.getPlayerObjectById(_local_4));
                }
            }
            _local_3._visible = true;
            _local_7._visible = true;
            _local_8._visible = true;
            _local_6._visible = true;
            if (_controller.isLocalPlayerPerformance) {
                com.clubpenguin.util.Log.info("PerformNormalState This is a local player performance " + _shell.getMyPlayerId());
                _engine.enableMouseMovement();
                _party.MuppetsParty.checkForFirstTimePerformance(_performance.hostId);
                com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.playPoofOut();
            }
            _global.getCurrentRoom().performanceManager.onPerformanceRemoved(_performance);
        }
    }
