//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleEndingState extends com.clubpenguin.world.rooms2014.pirate.swordfight.states.BaseBattleState
    {
        var _result, _isDraw, _reactionFrameCount, _attackFrameCount, _finalHitSfxPlayed, _enterFrameMc, _engine, _battle, _creatorMc, _challengerMc, _controller, _destroyDelegate, _shell;
        function BattleEndingState (manager, controller, battle, result) {
            super("BattleEndingState", manager, controller, battle);
            _result = result;
            _isDraw = result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_DRAW;
            _reactionFrameCount = 0;
            _attackFrameCount = 0;
            _finalHitSfxPlayed = false;
        }
        function onEnterState() {
            _enterFrameMc = _engine.createEmptyMovieClip("SwordFightBattleEnterFrame_" + _battle.creatorId, _engine.getNextHighestDepth());
            _creatorMc = _engine.getPlayerMovieClip(_battle.creatorId);
            _challengerMc = _engine.getPlayerMovieClip(_battle.challengerId);
            playAttackAnimations();
            if (_controller.isLocalPlayerBattle) {
                _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
                _shell.addListener(_shell.ROOM_DESTROYED, _destroyDelegate);
                _engine.disableMouseMovement();
                removeAttackWidget();
            }
        }
        function onExitState() {
            _enterFrameMc.removeMovieClip();
            _engine.enableMouseMovement();
        }
        function removeAttackWidget() {
            var _local_2 = _engine.getRoomMovieClip();
            if ((_local_2[com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.attackWidgetHolderName] != undefined) || (_local_2[com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.attackWidgetHolderName] != null)) {
                _local_2[com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.attackWidgetHolderName].removeMovieClip();
            }
        }
        function playAttackAnimations() {
            _creatorMc.art_mc.gotoAndStop(getFrameForAttack(_result.creatorAttack, _result.challengerAttack, _result.resultForCreator, true));
            _challengerMc.art_mc.gotoAndStop(getFrameForAttack(_result.creatorAttack, _result.challengerAttack, _result.resultForCreator, false));
            var _local_3 = _shell.isMyPlayer(_battle.creatorId) || (_shell.isMyPlayer(_battle.challengerId));
            com.clubpenguin.util.Log.debug("_result.resultForCreator == BattleResultVO.RESULT_DRAW " + (_result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_DRAW));
            if (_local_3) {
                if ((_result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_WIN) || (_result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_DRAW)) {
                    if (_result.creatorAttack == 0) {
                        com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinHighHit(_battle.creatorId);
                    }
                    if (_result.creatorAttack == 1) {
                        com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinMidHit(_battle.creatorId);
                    }
                    if (_result.creatorAttack == 2) {
                        com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinLowHit(_battle.creatorId);
                    }
                } else if (_result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_LOSS) {
                    if (_result.creatorAttack == 0) {
                        com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinHighHit(_battle.challengerId);
                    }
                    if (_result.creatorAttack == 1) {
                        com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinMidHit(_battle.challengerId);
                    }
                    if (_result.creatorAttack == 2) {
                        com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinLowHit(_battle.challengerId);
                    }
                }
            }
            _enterFrameMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onAttacksEnterFrame);
            _controller.tintAvatar(_battle.creatorId);
            _controller.tintAvatar(_battle.challengerId);
            var _local_2 = _engine.avatarManager.effectManager.playEffectForPlayer(getAttackIconFromId(_result.creatorAttack), _shell.getPlayerObjectById(_battle.creatorId));
            var _local_4 = _engine.avatarManager.effectManager.playEffectForPlayer(getAttackIconFromId(_result.challengerAttack), _shell.getPlayerObjectById(_battle.challengerId));
            _local_2._xscale = _creatorMc._xscale;
            _local_4._xscale = _challengerMc._xscale;
        }
        function playReactionAnimations() {
            var _local_2 = _result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_WIN;
            _creatorMc.art_mc.gotoAndStop(getFrameForResult(_result.resultForCreator, true));
            _challengerMc.art_mc.gotoAndStop(getFrameForResult(_result.resultForCreator, false));
            _enterFrameMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onReactionsEnterFrame);
            _controller.tintAvatar(_battle.creatorId);
            _controller.tintAvatar(_battle.challengerId);
            if ((!_shell.isMyPlayer(_battle.creatorId)) && (!_shell.isMyPlayer(_battle.challengerId))) {
                return(undefined);
            }
            if (_result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_WIN) {
                if (_shell.isMyPlayer(_battle.creatorId)) {
                    com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinWin(_battle.creatorId);
                } else {
                    com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinLose(_battle.challengerId);
                }
            } else if (_result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_LOSS) {
                if (_shell.isMyPlayer(_battle.challengerId)) {
                    com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinWin(_battle.challengerId);
                } else {
                    com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinLose(_battle.creatorId);
                }
            } else {
                com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPenguinTie(_battle.creatorId);
            }
        }
        function onAttacksEnterFrame() {
            if (areCurrentAnimationsComplete() || (_attackFrameCount > 0)) {
                if (!_finalHitSfxPlayed) {
                    _finalHitSfxPlayed = true;
                }
                _attackFrameCount++;
                if ((_attackFrameCount > REACTION_DELAY) || (_result.resultForCreator == 2)) {
                    playReactionAnimations();
                }
            }
        }
        function onReactionsEnterFrame() {
            _reactionFrameCount++;
            if ((_isDraw && (_reactionFrameCount >= NUM_REACTION_FRAMES_FOR_DRAW)) || ((!_isDraw) && (_reactionFrameCount >= NUM_REACTION_FRAMES_FOR_WIN))) {
                _controller.completeBattle();
            } else if ((_isDraw && (_reactionFrameCount == (NUM_REACTION_FRAMES_FOR_DRAW - 25))) || ((!_isDraw) && (_reactionFrameCount == (NUM_REACTION_FRAMES_FOR_WIN - 25)))) {
                var _local_7 = _engine.avatarManager.effectManager;
                var _local_2;
                var _local_4;
                var _local_3 = false;
                var _local_6 = _shell.isMyPlayer(_battle.creatorId) || (_shell.isMyPlayer(_battle.challengerId));
                com.clubpenguin.util.Log.debug("localPlayerInvolved " + _local_6);
                if (_result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_WIN) {
                    _local_2 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_POINTS_WIN;
                    _local_4 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_POINTS_LOSS;
                    if (_shell.isMyPlayer(_battle.creatorId)) {
                        _local_3 = true;
                    }
                } else if (_result.resultForCreator == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_LOSS) {
                    _local_4 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_POINTS_WIN;
                    _local_2 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_POINTS_LOSS;
                    if (_shell.isMyPlayer(_battle.challengerId)) {
                        _local_3 = true;
                    }
                } else {
                    _local_4 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_POINTS_LOSS;
                    _local_2 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_POINTS_LOSS;
                }
                _local_7.playEffectForPlayer(_local_2, _shell.getPlayerObjectById(_battle.creatorId));
                _local_7.playEffectForPlayer(_local_4, _shell.getPlayerObjectById(_battle.challengerId));
                com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPointsSound(_battle.creatorId);
                com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playPointsSound(_battle.challengerId);
                if (_local_6) {
                    var _local_5;
                    if (_isDraw) {
                        _local_5 = "tie_10";
                    } else {
                        _local_5 = (_local_3 ? "win_20" : "lose_10");
                    }
                    var _local_8 = (_shell.isMyPlayer(_battle.creatorId) ? (_result.creatorAttack) : (_result.challengerAttack));
                    com.clubpenguin.world.rooms2014.pirate.party.PirateParty.sendSwordFightResultBI(_local_5, getNameForAttack(_local_8));
                    _engine.enableMouseMovement();
                }
            }
        }
        function areCurrentAnimationsComplete() {
            if (_creatorMc.art_mc.body._currentframe == _creatorMc.art_mc.body._totalframes) {
                return(true);
            }
            return(false);
        }
        function getFrameForAttack(creatorAttackId, challengerAttackId, creatorResult, isCreator) {
            var _local_3;
            if (((isCreator && (creatorResult == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_WIN)) || ((!isCreator) && (creatorResult == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_LOSS))) || (_isDraw)) {
                _local_3 = (isCreator ? (creatorAttackId) : (challengerAttackId));
                switch (_local_3) {
                    case 0 : 
                        return("high");
                    case 1 : 
                        return("mid");
                    case 2 : 
                        return("stab");
                }
                return("high");
            } else if ((isCreator && (creatorResult == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_LOSS)) || ((!isCreator) && (creatorResult == com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_WIN))) {
                _local_3 = (isCreator ? (challengerAttackId) : (creatorAttackId));
                switch (_local_3) {
                    case 0 : 
                        return("highreact");
                    case 1 : 
                        return("midreact");
                    case 2 : 
                        return("lowreact");
                }
                return("highreact");
            }
        }
        function getNameForAttack(attackId) {
            switch (attackId) {
                case 0 : 
                    return("high");
                case 1 : 
                    return("medium");
                case 2 : 
                    return("low");
            }
            return("high");
        }
        function getAttackIconFromId(attackId) {
            switch (attackId) {
                case 0 : 
                    return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_HIGH_ICON);
                case 1 : 
                    return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_MID_ICON);
                case 2 : 
                    return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_LOW_ICON);
            }
            return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PIRATE_BATTLE_HIGH_ICON);
        }
        function getFrameForResult(resultId, isCreator) {
            com.clubpenguin.util.Log.debug("getFrameForResult() resultId " + resultId);
            switch (resultId) {
                case com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_WIN : 
                    return((isCreator ? "win" : "lose"));
                case com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_LOSS : 
                    return((isCreator ? "lose" : "win"));
                case com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO.RESULT_DRAW : 
                    return("draw");
            }
            return("draw");
        }
        function destroy() {
            _shell.removeListener(_shell.ROOM_DESTROYED, _destroyDelegate);
            _engine.enableMouseMovement();
            removeAttackWidget();
        }
        static var NUM_REACTION_FRAMES_FOR_DRAW = 60;
        static var NUM_REACTION_FRAMES_FOR_WIN = 60;
        static var REACTION_DELAY = 5;
    }
