//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.battle.states.BattleEndingState extends com.clubpenguin.world.rooms2013.starwars.battle.states.BaseBattleState
    {
        var _result, _isDraw, _reactionFrameCount, _attackFrameCount, _soundManager, _finalHitSfxPlayed, _enterFrameMc, _engine, _battle, _creatorMc, _challengerMc, _controller, _shell;
        function BattleEndingState (manager, controller, battle, result) {
            super("BattleEndingState", manager, controller, battle);
            _result = result;
            _isDraw = result.resultForCreator == 2;
            _reactionFrameCount = 0;
            _attackFrameCount = 0;
            _soundManager = com.clubpenguin.world.rooms.BaseRoom.current.soundManager;
            _finalHitSfxPlayed = false;
        }
        function onEnterState() {
            _enterFrameMc = _engine.createEmptyMovieClip("StarWarsBattleEnterFrame_" + _battle.creatorId, _engine.getNextHighestDepth());
            _creatorMc = _engine.getPlayerMovieClip(_battle.creatorId);
            _challengerMc = _engine.getPlayerMovieClip(_battle.challengerId);
            playAttackAnimations();
        }
        function onExitState() {
            _enterFrameMc.removeMovieClip();
        }
        function playAttackAnimations() {
            _creatorMc.art_mc.gotoAndStop(getFrameForAttack(_result.creatorAttack));
            _challengerMc.art_mc.gotoAndStop(getFrameForAttack(_result.challengerAttack));
            _enterFrameMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onAttacksEnterFrame);
            _controller.tintAvatar(_battle.creatorId);
            _controller.tintAvatar(_battle.challengerId);
        }
        function playReactionAnimations() {
            _creatorMc.art_mc.gotoAndStop(getFrameForResult(_result.resultForCreator, true));
            _challengerMc.art_mc.gotoAndStop(getFrameForResult(_result.resultForCreator, false));
            _enterFrameMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onReactionsEnterFrame);
            _controller.tintAvatar(_battle.creatorId);
            _controller.tintAvatar(_battle.challengerId);
        }
        function onAttacksEnterFrame() {
            if (areCurrentAnimationsComplete() || (_attackFrameCount > 0)) {
                if (!_finalHitSfxPlayed) {
                    _soundManager.playSound(com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.SFX_LIGHT_SABER_FINAL_HIT, com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.LAYER_LIGHT_SABER);
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
                var _local_5 = _engine.avatarManager.effectManager;
                var _local_3;
                var _local_4;
                var _local_2 = false;
                if (_result.resultForCreator == com.clubpenguin.world.rooms2013.starwars.battle.BattleResultVO.RESULT_WIN) {
                    _local_3 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.STAR_WARS_BATTLE_POINTS_WIN;
                    _local_4 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.STAR_WARS_BATTLE_POINTS_LOSS;
                    if (_shell.isMyPlayer(_battle.creatorId)) {
                        _local_2 = true;
                    }
                } else if (_result.resultForCreator == com.clubpenguin.world.rooms2013.starwars.battle.BattleResultVO.RESULT_LOSS) {
                    _local_4 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.STAR_WARS_BATTLE_POINTS_WIN;
                    _local_3 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.STAR_WARS_BATTLE_POINTS_LOSS;
                    if (_shell.isMyPlayer(_battle.challengerId)) {
                        _local_2 = true;
                    }
                } else {
                    _local_4 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.STAR_WARS_BATTLE_POINTS_LOSS;
                    _local_3 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.STAR_WARS_BATTLE_POINTS_LOSS;
                }
                _local_5.playEffectForPlayer(_local_3, _shell.getPlayerObjectById(_battle.creatorId));
                _local_5.playEffectForPlayer(_local_4, _shell.getPlayerObjectById(_battle.challengerId));
                if (_shell.isMyPlayer(_battle.creatorId) || (_shell.isMyPlayer(_battle.challengerId))) {
                    _soundManager.playSound(com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.SFX_POINTS_AWARDED, com.clubpenguin.world.rooms2013.starwars.battle.BattleSoundManager.LAYER_POINTS_AWARDED);
                }
                if (_local_2 && (com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.numBattlesWon == 24)) {
                    com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.getOpcodeJournal().sendOpcode(com.clubpenguin.world.rooms2013.starwars.OpcodeJournal.WIN_25_JEDI_BATTLES);
                }
                com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("Jedi_Fight", (_local_2 ? "Win" : "Lose"));
            }
        }
        function areCurrentAnimationsComplete() {
            if (_creatorMc.art_mc.lazer._currentframe == _creatorMc.art_mc.lazer._totalframes) {
                return(true);
            }
            return(false);
        }
        function getFrameForAttack(attackId) {
            switch (attackId) {
                case 0 : 
                    return("high");
                case 1 : 
                    return("mid");
                case 2 : 
                    return("stab");
            }
            return("high");
        }
        function getFrameForResult(resultId, isCreator) {
            switch (resultId) {
                case com.clubpenguin.world.rooms2013.starwars.battle.BattleResultVO.RESULT_WIN : 
                    return((isCreator ? "win" : "lose"));
                case com.clubpenguin.world.rooms2013.starwars.battle.BattleResultVO.RESULT_LOSS : 
                    return((isCreator ? "lose" : "win"));
                case com.clubpenguin.world.rooms2013.starwars.battle.BattleResultVO.RESULT_DRAW : 
                    return("draw");
            }
            return("draw");
        }
        static var NUM_REACTION_FRAMES_FOR_DRAW = 65;
        static var NUM_REACTION_FRAMES_FOR_WIN = 35;
        static var REACTION_DELAY = 5;
    }
