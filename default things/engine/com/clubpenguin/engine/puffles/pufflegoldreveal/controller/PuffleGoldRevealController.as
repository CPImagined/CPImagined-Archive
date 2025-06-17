//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.pufflegoldreveal.controller.PuffleGoldRevealController
    {
        var _SHELL, _ENGINE, _INTERFACE;
        function PuffleGoldRevealController (shellMC, engineMC, interfaceMC) {
            _SHELL = shellMC;
            _ENGINE = engineMC;
            _INTERFACE = interfaceMC;
        }
        function onGoldPuffleReveal(playerId) {
            var _local_2 = _SHELL.getPlayerObjectById(playerId);
            var _local_4 = _SHELL.isMyPlayer(playerId);
            if (_local_4 && (_SHELL.getCurrentRoomId() == CAVE_MINE_ID)) {
                _ENGINE.disableMouseMovement();
                if ((_goldRevealView != null) && (_showLocalPlayerAnimation == false)) {
                    _goldRevealView.stopAnimation();
                    _showLocalPlayerAnimation = true;
                } else {
                    startNewGoldRevealAnimation(playerId, _local_2);
                }
            } else if ((_goldRevealView == null) && (_SHELL.getCurrentRoomId() == CAVE_MINE_ID)) {
                startNewGoldRevealAnimation(playerId, _local_2);
            }
        }
        function startNewGoldRevealAnimation(playerId, playerVO) {
            _goldRevealView = new com.clubpenguin.engine.puffles.pufflegoldreveal.view.PuffleGoldRevealView(_SHELL, _ENGINE, playerId);
            var _local_2 = new Object();
            _local_2.playerId = playerVO.player_id;
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_2);
            _goldRevealView.onGoldRevealAnimationCompleteSignal.addOnce(onGoldRevealAnimationComplete, this);
            _goldRevealView.playGoldPuffleRevealAnimation();
        }
        function onGoldRevealAnimationComplete(playerVO) {
            _goldRevealView = null;
            var _local_2 = new Object();
            _local_2.playerId = playerVO.player_id;
            _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_2);
            if (_showLocalPlayerAnimation) {
                startNewGoldRevealAnimation(_SHELL.getMyPlayerObject().player_id, _SHELL.getMyPlayerObject());
                _showLocalPlayerAnimation = false;
            }
            var _local_3 = _SHELL.isMyPlayer(playerVO.player_id);
            if (_local_3) {
                _ENGINE.enableMouseMovement();
                _INTERFACE.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, undefined, {puffleAdoptionType:"gold"}, true);
            }
        }
        static var CAVE_MINE_ID = 813;
        var _goldRevealView = null;
        var _showLocalPlayerAnimation = false;
    }
