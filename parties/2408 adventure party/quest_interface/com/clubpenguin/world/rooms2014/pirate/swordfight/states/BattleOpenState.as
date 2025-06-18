//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleOpenState extends com.clubpenguin.world.rooms2014.pirate.swordfight.states.BaseBattleState
    {
        var _active, _battle, _controller, _joinButton, _engine, _shell, _playerMoveDelegate;
        function BattleOpenState (manager, controller, battle) {
            super("BattleOpenState", manager, controller, battle);
            _active = false;
        }
        function onEnterState() {
            com.clubpenguin.util.Log.debug("BattleOpenState.onEnterState()");
            _active = true;
            if (!com.clubpenguin.world.rooms2014.pirate.party.PirateParty.isPlayerABattleAvatar(_battle.creatorId)) {
                _controller.loadCreatorAvatar().addOnce(onAvatarLoaded, this);
            }
            showJoinButton();
        }
        function onExitState() {
            removeJoinButton();
            _active = false;
            com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.stopPenguinInvitation(_battle.creatorId);
        }
        function showJoinButton() {
            if ((_joinButton == undefined) && (com.clubpenguin.world.rooms2014.pirate.party.PirateParty.isSwordEquipped(_global.getCurrentShell().getMyPlayerId()))) {
                var _local_3 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_ICON;
                _engine = _global.getCurrentEngine();
                _joinButton = _engine.avatarManager.effectManager.playEffectForPlayer(_local_3, _shell.getPlayerObjectById(_battle.creatorId));
                _joinButton.btn.onRelease = com.clubpenguin.util.Delegate.create(this, onJoinButtonClicked);
                if (_controller.isLocalPlayerBattle) {
                    com.clubpenguin.world.rooms2014.pirate.party.PiratePartyQuestCommunicator.clearDuelPlayersTimeout();
                    com.clubpenguin.world.rooms2014.pirate.party.PirateParty.sendSwordFightInvitationBI();
                }
            }
        }
        function removeJoinButton() {
            _joinButton.btn.onRelease = null;
            _joinButton.removeMovieClip();
            _joinButton = null;
        }
        function onJoinButtonClicked() {
            com.clubpenguin.util.Log.debug("BattleOpenState] onJoinButtonClicked _controller.isLocalPlayerBattle " + _controller.isLocalPlayerBattle);
            if (!_controller.isLocalPlayerBattle) {
                var _local_2 = _engine.getPlayerMovieClip(_battle.creatorId);
                var _local_3 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
                if (_local_3.hitTest(_local_2._x - com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController.CHALLENGER_X_OFFSET, _local_2._y, true) || (_local_3.hitTest(_local_2._x + com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController.CHALLENGER_X_OFFSET, _local_2._y, true))) {
                    _controller.service.sendJoinBattle(_battle.creatorId);
                } else {
                    _controller.moveChallengerToCreator(_shell.getMyPlayerId());
                    _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveDone);
                    _shell.addListener(_shell.PLAYER_MOVE_DONE, _playerMoveDelegate);
                }
            }
        }
        function handlePlayerMoveDone() {
            com.clubpenguin.util.Log.debug("BattleOpenState] handlePlayerMoveDone");
            _shell.removeListener(_shell.PLAYER_MOVE_DONE, _playerMoveDelegate);
            var _local_3 = _engine.getPlayerMovieClip(_battle.creatorId);
            var _local_2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
            _controller.service.sendJoinBattle(_battle.creatorId);
        }
        function onAvatarLoaded(player, newAvatar) {
            if (!_active) {
                return(undefined);
            }
            var _local_2 = _engine.getPlayerMovieClip(_battle.creatorId);
            _local_2.art_mc.gotoAndStop("pose");
            com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinInvitation(_battle.creatorId);
            _controller.tintAvatar(_battle.creatorId);
        }
    }
