//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.GameEngine extends com.clubpenguin.util.StateMachine
    {
        static var root_mc, instance;
        var sequence, clock, battleController, powerController, clientProxy, dLearningManager, changeState, myPlayer, bGameOver, oGameAwardData, stampInfoAbort, endOfGameStampObject, mode, playerList, seatMap, opponent, bGameStarted, iRound, getCurrentState, iFirstRoundTweens, bHelpOn, oGameOverData, award, leave_room;
        function GameEngine (gameMovie) {
            super();
            root_mc = gameMovie;
            instance = this;
            sequence = new com.clubpenguin.util.Sequence();
            clock = new com.clubpenguin.games.card.Clock(root_mc.mc_clock);
            clock.addEventListener(com.clubpenguin.games.card.Clock.TIME_UP, com.clubpenguin.util.Delegate.create(this, onTimeOut));
            battleController = new com.clubpenguin.games.card.BattleController(root_mc);
            battleController.addEventListener(com.clubpenguin.games.card.BattleController.FILE_LOADED, com.clubpenguin.util.Delegate.create(this, onBattleLoaded));
            battleController.addEventListener(com.clubpenguin.games.card.BattleController.BATTLE_DONE, com.clubpenguin.util.Delegate.create(this, onBattleDone));
            powerController = new com.clubpenguin.games.card.PowerController(this, sequence, root_mc.pows_mc);
            clientProxy = new com.clubpenguin.games.card.ClientProxy(this);
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_GET_GAME, com.clubpenguin.util.Delegate.create(this, onGetGame));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_JOIN_GAME, com.clubpenguin.util.Delegate.create(this, onJoinGame));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_UPDATE_GAME, com.clubpenguin.util.Delegate.create(this, onUpdateGame));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_START_GAME, com.clubpenguin.util.Delegate.create(this, onStartGame));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_GAME_MOVE, com.clubpenguin.util.Delegate.create(this, onGameMove));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_CLOSE_GAME, com.clubpenguin.util.Delegate.create(this, onCloseGame));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_LEAVE_GAME, com.clubpenguin.util.Delegate.create(this, onLeaveGame));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_GAME_OVER, com.clubpenguin.util.Delegate.create(this, onGameOver));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_GAME_AWARD, com.clubpenguin.util.Delegate.create(this, onGameAward));
            clientProxy.addEventListener(com.clubpenguin.games.card.ClientProxy.MESSAGE_STAMP_INFO, com.clubpenguin.util.Delegate.create(this, onStampInfoRecieved));
            root_mc.mc_help.onRollOver = com.clubpenguin.util.Delegate.create(this, onHelp);
            root_mc.mc_help.onRollOut = (root_mc.mc_help.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, offHelp));
            root_mc.btn_close.onRelease = com.clubpenguin.util.Delegate.create(this, quitGame);
            dLearningManager = new com.disney.dlearning.games.cardjitsu.DLearning(SHELL.getMyPlayerId());
            setupGame();
            changeState("stateInit");
        }
        function onGetGame(o) {
            handleEvent("onGetGame", o);
        }
        function onJoinGame(o) {
            handleEvent("onJoinGame", o);
        }
        function onUpdateGame(o) {
            handleEvent("onUpdateGame", o);
        }
        function onStartGame(o) {
            showLoading(false);
            changeState("stateServe");
            handleEvent("onStartGame", o);
        }
        function onGameMove(o) {
            if ((o.instr == "deal") && (o.data[0] != myPlayer.seat)) {
                handleOpponentDeal(o.data);
            } else if ((o.instr == "pick") && (o.data[0] != myPlayer.seat)) {
                handleOpponentPick(o.data);
            } else {
                handleEvent("onGameMove", o);
            }
        }
        function onCloseGame(o) {
            bGameOver = true;
            if (!leaveGameCalled) {
                var _local_3 = _global.getCurrentShell().getLocalizedString("player_quit_prompt");
                _local_3 = _global.getCurrentShell().replace("%name%", o.nickname, _local_3);
                _global.getCurrentInterface().showPrompt("ok", _local_3);
            }
            leaveGame();
        }
        function onLeaveGame(o) {
            _root.closeGame();
        }
        function onGameOver(o) {
            handleEvent("onGameOver", o);
        }
        function onGameAward(o) {
            oGameAwardData = {rank:o.rank};
            addItem(AWARD_ITEM[o.rank]);
        }
        function onStampInfoRecieved(o) {
            _global.clearTimeout(stampInfoAbort);
            var _local_6 = o.stampInfo;
            endOfGameStampObject = new Object();
            endOfGameStampObject.isCardJitsu = true;
            endOfGameStampObject.is_table = false;
            endOfGameStampObject.numberOfGameStamps = parseInt(String(_local_6.pop()));
            endOfGameStampObject.totalNumberOfGameStampsEarned = parseInt(String(_local_6.pop()));
            var _local_5 = new Array();
            var _local_4 = String(_local_6[0]).split("|");
            while (_local_4.length > 0) {
                var _local_3 = parseInt(String(_local_4.pop()));
                if (_local_3 && (!isNaN(_local_3))) {
                    _local_5.push(_local_3);
                }
            }
            endOfGameStampObject.stampIds = _local_5;
            if (leaveGameCalled) {
                leaveGame();
            }
        }
        function onCardLoad(o) {
            handleEvent("onCardLoad", o);
        }
        function onCardTween(o) {
            handleEvent("onCardTween", o);
        }
        function onCardPick(o) {
            handleEvent("onCardPick", o);
        }
        function onCardFlip(o) {
            handleEvent("flip", o);
        }
        function onBattleLoaded(o) {
            handleEvent("onBattleLoaded", o);
        }
        function onBattleDone(o) {
            handleEvent("onBattleDone", o);
        }
        function onTimeOut(o) {
            handleEvent("onTimeOut", o);
        }
        function onHelp() {
            handleEvent("onHelp");
        }
        function offHelp() {
            handleEvent("offHelp");
        }
        function onAwardLoad() {
            handleEvent("onAwardLoad");
        }
        function onAwardMenuClick(o) {
            handleEvent("onAwardMenuClick");
        }
        function stateInit(sEvent, utEventData) {
            if (sEvent == "enter") {
            } else if (sEvent == "onBattleLoaded") {
                clientProxy.sendGetGameMessage(mode);
            } else if (sEvent == "onGetGame") {
                if (utEventData.numPlayers < utEventData.maxPlayers) {
                    clientProxy.sendJoinGameMessage();
                } else {
                    clientProxy.sendUpdateGameMessage();
                }
            } else if (sEvent == "onJoinGame") {
                var _local_3 = new com.clubpenguin.games.card.CardPlayer(utEventData.seatID, utEventData.nickname, SHELL.getPlayerHexFromId(utEventData["color"]), utEventData.rank);
                playerList.push(_local_3);
                seatMap[utEventData.seatID] = _local_3;
                myPlayer = _local_3;
            } else if (sEvent == "onUpdateGame") {
                while (utEventData.players.length > 0) {
                    var _local_7 = utEventData.players.shift();
                    var _local_2 = _local_7.split("|");
                    var _local_5 = _local_2[0];
                    var _local_4 = _local_2[1];
                    var _local_9 = _local_2[2];
                    var _local_8 = _local_2[3];
                    if (!isPlayerPresent(_local_4)) {
                        var _local_3 = new com.clubpenguin.games.card.CardPlayer(_local_5, _local_4, SHELL.getPlayerHexFromId(_local_9), _local_8);
                        playerList.push(_local_3);
                        seatMap[_local_5] = _local_3;
                        if (opponent == null) {
                            opponent = _local_3;
                        }
                    }
                }
                updatePlayerName();
            } else if (sEvent == "leave") {
            }
        }
        function stateServe(sEvent, utEventData) {
            if (sEvent == "enter") {
                bGameStarted = true;
                iRound++;
                if (iRound > 1) {
                    clientProxy.sendGameMoveDealMessage("deal", 1);
                }
            } else if (sEvent == "onStartGame") {
                ninjaAnimate("walk");
            } else if (sEvent == "onBattleDone") {
                ninjaAnimate("ambient");
                clientProxy.sendGameMoveDealMessage("deal", 5);
            } else if (sEvent == "onGameMove") {
                switch (utEventData.instr) {
                    case "deal" : 
                        var _local_8 = utEventData.data.shift();
                        var _local_2 = utEventData.data;
                        var _local_9 = 0;
                        while (_local_9 < _local_2.length) {
                            myPlayer.receiveCard(_local_2[_local_9]);
                            _local_9++;
                        }
                        _local_9 = 0;
                        while (_local_9 < _local_2.length) {
                            var _local_3 = _local_2[_local_9].substring(0, _local_2[_local_9].indexOf("|"));
                            var _local_6 = myPlayer.findCardByIdFrom(_local_3, myPlayer.dealts);
                            _local_6.createGraphic(root_mc.cards_mc, myPlayer.seat, true);
                            _local_6.addEventListener(com.clubpenguin.games.card.Card.CARD_LOADED, com.clubpenguin.util.Delegate.create(this, onCardLoad));
                            if ((com.clubpenguin.games.card.BattleController.POWER_ANIM["pow_" + _local_6.type] != null) && (com.clubpenguin.games.card.BattleController.POWER_ANIM["pow_" + _local_6.type].loaded == false)) {
                                battleController.loadPowerBattle(_local_6.type);
                            }
                            _local_9++;
                        }
                        if (!_local_2.length) {
                            changeState("stateInput");
                        }
                        break;
                    default : 
                        this.log(((("WARNING - Unhandeled onGameMove instruction: " + getCurrentState()) + "[") + utEventData.instr) + "]");
                        break;
                }
            } else if (sEvent == "onCardLoad") {
                var _local_6 = utEventData.target;
                sequence.addFunction({i:_local_6, f:"tweenToDealtSlots", p:[myPlayer.seat, myPlayer.dealtSlots, com.clubpenguin.games.card.Layout.POS_DEALTS[myPlayer.seat]]});
                _local_6.removeEventListener(com.clubpenguin.games.card.Card.CARD_LOADED, this);
                _local_6.addEventListener(com.clubpenguin.games.card.Card.CARD_TWEENED, com.clubpenguin.util.Delegate.create(this, onCardTween));
            } else if (sEvent == "onCardTween") {
                var _local_6 = utEventData.target;
                _local_6.removeEventListener(com.clubpenguin.games.card.Card.CARD_TWEENED, this);
                _local_6.addEventListener(com.clubpenguin.games.card.Card.CARD_PICKED, com.clubpenguin.util.Delegate.create(this, onCardPick));
                _local_6.addEventListener(com.clubpenguin.games.card.Card.CARD_FLIPPED, com.clubpenguin.util.Delegate.create(this, onCardFlip));
                if ((iRound == 1) && ((++iFirstRoundTweens) < 5)) {
                    return(undefined);
                }
                changeState("stateInput");
            } else if (sEvent == "leave") {
            }
        }
        function stateInput(sEvent, utEventData) {
            if (sEvent == "enter") {
                myPlayer.lockDealts(false);
                var _local_4 = powerController.queryD();
                if (_local_4.receiver == myPlayer.seat) {
                    if (_local_4.pow == 13) {
                        myPlayer.lockAtrCards("s");
                    } else if (_local_4.pow == 14) {
                        myPlayer.lockAtrCards("f");
                    } else if (_local_4.pow == 15) {
                        myPlayer.lockAtrCards("w");
                    }
                }
                startTimeOut();
            } else if (sEvent == "onCardPick") {
                clock.end();
                myPlayer.pickCard(utEventData.id);
                clientProxy.sendGameMovePickMessage("pick", utEventData.id);
            } else if (sEvent == "onTimeOut") {
                var _local_10 = 0;
                while (_local_10 < myPlayer.dealts.length) {
                    if (!myPlayer.dealts[_local_10].lock) {
                        myPlayer.dealts[_local_10].onPick();
                        return(undefined);
                    }
                    _local_10++;
                }
                this.log("[ERROR] - NO AVAILABLE CARDS FOR PICK UP - myPlayer.dealts: " + myPlayer.dealts);
                clientProxy.sendGameMovePickMessage("death", opponent.seat);
                changeState("stateJudge");
            } else if (sEvent == "onGameMove") {
                switch (utEventData.instr) {
                    case "pick" : 
                        var _local_5 = utEventData.data.shift();
                        var _local_7 = utEventData.data.shift();
                        if (myPlayer.seat == _local_5) {
                            myPlayer.pick.setState("front", com.clubpenguin.games.card.Layout.SCALE_CARD_FLIP);
                            myPlayer.pick.tweenTo(com.clubpenguin.games.card.Layout.POS_PICKS[_local_5].x, com.clubpenguin.games.card.Layout.POS_PICKS[_local_5].y, 0.5);
                            changeState("stateJudge");
                        }
                        break;
                    default : 
                        this.log(((("WARNING - Unhandeled onGameMove instruction: " + getCurrentState()) + "[") + utEventData.instr) + "]");
                        break;
                }
            } else if (sEvent == "onHelp") {
                if (bHelpOn === false) {
                    root_mc.mc_help.gotoAndPlay("down");
                    root_mc.mc_help.mc_menu.tf_help.text = com.clubpenguin.util.LocaleText.getText("help");
                    bHelpOn = undefined;
                    var _local_6 = new com.clubpenguin.util.Sequence();
                    _local_6.addDelay(500);
                    _local_6.addFunction({i:this, f:"setHelpStatus", p:[true]});
                }
            } else if (sEvent == "offHelp") {
                if (bHelpOn === true) {
                    root_mc.mc_help.gotoAndPlay("up");
                    bHelpOn = undefined;
                    var _local_6 = new com.clubpenguin.util.Sequence();
                    _local_6.addDelay(500);
                    _local_6.addFunction({i:this, f:"setHelpStatus", p:[false]});
                }
            } else if (sEvent == "onGameOver") {
                bGameOver = true;
                oGameOverData = {winseat:utEventData.winseat, ids:utEventData.ids};
                if (utEventData.ids.length == 0) {
                    sequence.addFunction({i:this, f:"changeState", p:["stateOver"]});
                }
            } else if (sEvent == "leave") {
                root_mc.mc_help.gotoAndPlay("zero");
                bHelpOn = false;
            }
        }
        function stateJudge(sEvent, utEventData) {
            if (sEvent == "enter") {
            } else if (sEvent == "onGameMove") {
                switch (utEventData.instr) {
                    case "judge" : 
                        var _local_3 = utEventData.data.shift();
                        var _local_12 = utEventData.data.shift();
                        var _local_5 = seatMap[_local_3].pick;
                        sequence.addDelay(1000);
                        sequence.addFunction({i:opponent.pick, f:"flip", p:[0.25]});
                        sequence.addDelay(500);
                        powerController.doPowPreJudge();
                        if (_local_3 == -1) {
                            sequence.addFunction({i:myPlayer, f:"cardLose", p:[""]});
                            sequence.addFunction({i:opponent, f:"cardLose", p:[""]});
                            powerController.doPowPostJudge();
                            sequence.addFunction({i:this, f:"ninjaBattle", p:[_local_5, _local_3]});
                            dLearningManager.playerLostRound();
                        } else if (_local_3 == myPlayer.seat) {
                            sequence.addFunction({i:myPlayer, f:"cardWin", p:[""]});
                            sequence.addFunction({i:opponent, f:"cardLose", p:[""]});
                            powerController.doPowPostJudge();
                            sequence.addFunction({i:myPlayer, f:"arrangeWinCards", p:[]});
                            sequence.addFunction({i:this, f:"ninjaBattle", p:[_local_5, _local_3]});
                            dLearningManager.playerWonRound();
                        } else {
                            sequence.addFunction({i:myPlayer, f:"cardLose", p:[""]});
                            sequence.addFunction({i:opponent, f:"cardWin", p:[""]});
                            powerController.doPowPostJudge();
                            sequence.addFunction({i:opponent, f:"arrangeWinCards", p:[]});
                            sequence.addFunction({i:this, f:"ninjaBattle", p:[_local_5, _local_3]});
                            dLearningManager.playerLostRound();
                        }
                        break;
                    case "power" : 
                        var _local_10 = Number(utEventData.data.shift());
                        var _local_15 = Number(utEventData.data.shift());
                        var _local_8 = Number(utEventData.data.shift());
                        var _local_7 = utEventData.data;
                        var _local_6;
                        switch (_local_8) {
                            case 1 : 
                            case 2 : 
                            case 3 : 
                                _local_6 = {owner:_local_10, receiver:_local_15, pow:_local_8, round:iRound + 1};
                                break;
                            case 4 : 
                            case 5 : 
                            case 6 : 
                            case 7 : 
                            case 8 : 
                            case 9 : 
                            case 10 : 
                            case 11 : 
                            case 12 : 
                            case 19 : 
                            case 20 : 
                            case 21 : 
                            case 22 : 
                            case 23 : 
                            case 24 : 
                                _local_6 = {owner:_local_10, receiver:_local_15, pow:_local_8, rems:_local_7, round:iRound};
                                break;
                            case 13 : 
                            case 14 : 
                            case 15 : 
                                _local_6 = {owner:_local_10, receiver:_local_15, pow:_local_8, round:iRound + 1};
                                break;
                            case 16 : 
                            case 17 : 
                            case 18 : 
                                _local_6 = {owner:_local_10, receiver:_local_15, pow:_local_8, round:iRound};
                                break;
                            default : 
                                this.log("UNRECGONIZED POWER CARD - power: " + _local_8, "ERROR");
                        }
                        powerController.addPow(_local_6);
                        break;
                    case "power1" : 
                        _local_10 = Number(utEventData.data.shift());
                        _local_15 = Number(utEventData.data.shift());
                        _local_8 = Number(utEventData.data.shift());
                        _local_6 = {owner:_local_10, receiver:_local_15, pow:_local_8, round:iRound};
                        powerController.updatePostA(_local_6);
                        break;
                    default : 
                        this.log(((("WARNING - Unhandeled onGameMove instruction: " + getCurrentState()) + "[") + utEventData.instr) + "]");
                        break;
                }
            } else if (sEvent == "flip") {
            } else if (sEvent == "onBattleDone") {
                ninjaAnimate("ambient");
                if (oGameOverData != null) {
                    sequence.addFunction({i:this, f:"changeState", p:["stateOver"]});
                } else {
                    sequence.addFunction({i:this, f:"changeState", p:["stateServe"]});
                }
            } else if (sEvent == "onGameOver") {
                bGameOver = true;
                oGameOverData = {winseat:utEventData.winseat, ids:utEventData.ids};
                if (utEventData.ids.length == 0) {
                    sequence.addFunction({i:this, f:"changeState", p:["stateOver"]});
                }
            } else if (sEvent == "leave") {
            }
        }
        function stateOver(sEvent, utEventData) {
            if (sEvent == "enter") {
                SHELL.stopGameMusic();
                root_mc.createEmptyMovieClip("soundInstance", root_mc.getNextHighestDepth());
                var _local_3 = new Sound(root_mc.soundInstance);
                _local_3.attachSound("end_sfx");
                _local_3.start();
                if (oGameOverData.ids.length != 0) {
                    sequence.addFunction({i:seatMap[oGameOverData.winseat], f:"showWinCards", p:[oGameOverData.winseat, oGameOverData.ids]});
                    sequence.addDelay(1000);
                } else {
                    ((oGameOverData.winseat == myPlayer.seat) ? (myPlayer.pick.terminate()) : (opponent.pick.terminate()));
                }
                sequence.addFunction({i:this, f:"ninjaAnimate", p:["tie", null, true]});
                sequence.addDelay(2500);
                var _local_2 = opponent.nickname;
                if (_local_2 == "Sensei") {
                    _local_2 = String(com.clubpenguin.util.LocaleText.getText("sensei_label"));
                }
                if (oGameOverData.ids.length != 0) {
                    var _local_4 = (((oGameOverData.winseat == myPlayer.seat) ? (myPlayer.nickname) : (_local_2)) + " ") + com.clubpenguin.util.LocaleText.getText("win");
                } else {
                    var _local_4 = (((com.clubpenguin.util.LocaleText.getTextReplaced("sudden_death", [((oGameOverData.winseat == myPlayer.seat) ? (_local_2) : (myPlayer.nickname))]) + ", \n") + ((oGameOverData.winseat == myPlayer.seat) ? (myPlayer.nickname) : (_local_2))) + " ") + com.clubpenguin.util.LocaleText.getText("win");
                }
                sequence.addFunction({i:INTERFACE, f:"showPrompt", p:["ok", _local_4, undefined, com.clubpenguin.util.Delegate.create(this, leaveGame)]});
                dLearningManager.sendScore();
            } else if (sEvent == "leave") {
            }
        }
        function stateAward(sEvent, utEventData) {
            if (sEvent == "enter") {
                showLoading(true);
                var _local_5 = root_mc.createEmptyMovieClip("mc_award", root_mc.getNextHighestDepth());
                var _local_2 = new MovieClipLoader();
                var _local_3 = new Object();
                _local_3.onLoadInit = com.clubpenguin.util.Delegate.create(this, onAwardLoad);
                _local_2.addListener(_local_3);
                _local_2.loadClip(AWARD_FILE, _local_5);
            } else if (sEvent == "onAwardLoad") {
                showLoading(false);
                award = new com.clubpenguin.games.card.AwardMenu(this, root_mc.mc_award.menus);
                if (oGameAwardData.rank < 10) {
                    award.beltID = com.clubpenguin.games.card.AwardMenu.BELTS[oGameAwardData.rank];
                    award.loadMenu(com.clubpenguin.games.card.AwardMenu.MENU_BELT_AWARD);
                } else if (oGameAwardData.rank == 10) {
                    award.loadMenu(com.clubpenguin.games.card.AwardMenu.MENU_FINAL_WELLDONE);
				} else if (oGameAwardData.rank == 11) {
                    award.loadMenu(com.clubpenguin.games.card.AwardMenu.MENU_SHOES_EARNED);
				} else if (oGameAwardData.rank == 12) {
                    award.loadMenu(com.clubpenguin.games.card.AwardMenu.MENU_SUIT_EARNED);
				} else if (oGameAwardData.rank == 13) {
                    award.loadMenu(com.clubpenguin.games.card.AwardMenu.MENU_MASK_EARNED);
				} else if (oGameAwardData.rank == 14) {
                    award.loadMenu(com.clubpenguin.games.card.AwardMenu.MENU_HELMET_EARNED);
                } else {
                    com.clubpenguin.util.Debug.log("Wrong Award Data - rank: " + oGameAwardData.rank, "ERROR");
                }
            } else if (sEvent == "onAwardMenuClick") {
                award.handleClick(utEventData.click);
            } else if (sEvent == "leave") {
            }
        }
        function handleEvent(sEvent, utEventData) {
            this[getCurrentState()](sEvent, utEventData);
        }
        function handleOpponentDeal(o) {
            var _local_9 = o.shift();
            var _local_3 = o;
            var _local_6 = 0;
            while (_local_6 < _local_3.length) {
                opponent.receiveCard(_local_3[_local_6]);
                _local_6++;
            }
            _local_6 = 0;
            while (_local_6 < _local_3.length) {
                var _local_4 = _local_3[_local_6].substring(0, _local_3[_local_6].indexOf("|"));
                var _local_2 = opponent.findCardByIdFrom(_local_4, opponent.dealts);
                _local_2.createGraphic(root_mc.cards_mc, opponent.seat, false);
                sequence.addFunction({i:_local_2, f:"tweenToDealtSlots", p:[opponent.seat, opponent.dealtSlots, com.clubpenguin.games.card.Layout.POS_DEALTS[opponent.seat]]});
                _local_2.addEventListener(com.clubpenguin.games.card.Card.CARD_FLIPPED, com.clubpenguin.util.Delegate.create(this, onCardFlip));
                if ((com.clubpenguin.games.card.BattleController.POWER_ANIM["pow_" + _local_2.type] != null) && (com.clubpenguin.games.card.BattleController.POWER_ANIM["pow_" + _local_2.type].loaded == false)) {
                    battleController.loadPowerBattle(_local_2.type);
                }
                _local_6++;
            }
        }
        function handleOpponentPick(o) {
            var _local_2 = o.shift();
            var _local_3 = o.shift();
            opponent.pickCard(_local_3);
            opponent.pick.setState("back", com.clubpenguin.games.card.Layout.SCALE_CARD_FLIP);
            opponent.pick.tweenTo(com.clubpenguin.games.card.Layout.POS_PICKS[_local_2].x, com.clubpenguin.games.card.Layout.POS_PICKS[_local_2].y, 0.5);
            opponent.pick.addEventListener(com.clubpenguin.games.card.Card.CARD_FLIPPED, com.clubpenguin.util.Delegate.create(this, onCardFlip));
        }
        function ninjaAnimate(name, seat, noTieSfx) {
            battleController.animate(seat, name, noTieSfx);
            battleController.setColor(myPlayer);
            battleController.setBeltColor(myPlayer);
            battleController.setColor(opponent);
            battleController.setBeltColor(opponent);
        }
        function ninjaBattle(win, seat) {
            if (win == undefined) {
                ninjaAnimate("tie");
            } else if (win.pow != 0) {
                ninjaAnimate("pow_" + win.type, seat);
            } else if (win.pow == 0) {
                ninjaAnimate(win.atr, seat);
            } else {
                com.clubpenguin.util.Debug.log("Unknown Ninja Battle", "ERROR");
            }
        }
        function startTimeOut() {
            clock.start();
        }
        function setupGame() {
            playerList = new Array();
            seatMap = new Array();
            myPlayer = null;
            opponent = null;
            iRound = 0;
            iFirstRoundTweens = 0;
            bGameStarted = false;
            bGameOver = false;
            bHelpOn = false;
            oGameOverData = null;
            oGameAwardData = null;
            mode = SHELL.getCookie(SHELL.GAME_COOKIE, "game_ninja").mode;
            dLearningManager.setMode(mode);
            leave_room = SHELL.getCookie(SHELL.GAME_COOKIE, "game_ninja").room;
        }
        function quitGame() {
            trace("Cadjitsu GameEngine.quitGame bGameStarted" + bGameStarted);
            if (!bGameStarted) {
                leaveGame();
            } else {
                var _local_3 = _global.getCurrentShell().getLocalizedString("quit_game_prompt");
                _global.getCurrentInterface().showPrompt("question", _local_3, undefined, com.clubpenguin.util.Delegate.create(this, leaveGame));
            }
        }
        function leaveGame() {
            trace((((((("leaveGame: bGameOver=" + bGameOver) + " endOfGameStampObject=") + endOfGameStampObject) + " oGameAwardData=") + oGameAwardData) + " leaveGameCalled=") + leaveGameCalled);
            if (endOfGameStampObject) {
                clientProxy.removeAirtowerListeners();
            }
            clock.terminate();
            if ((oGameAwardData != null) && (!leaveGameCalled)) {
                changeState("stateAward");
            } else if (endOfGameStampObject) {
                sequence.cancel();
                var _local_3 = SHELL.joinGameFromIglooStatus;
                trace("GameEngine endOfGameStampObject.stampIds.length:" + endOfGameStampObject.stampIds.length);
                if (endOfGameStampObject.stampIds.length > 0) {
                    if (_local_3) {
                        trace("Joined from igloo, send player to igloo room " + SHELL.idOfIglooRoomToJoin);
                        SHELL.sendJoinPlayerIgloo(SHELL.idOfIglooRoomToJoin);
                        SHELL.setJoinGameFromIgloo(false, "");
                    }
                    INTERFACE.showEndGameScreen(endOfGameStampObject, null, leave_room, true);
                } else {
                    trace("FROM IGLOO STATUS " + _local_3);
                    if (_local_3) {
                        trace("Joined from igloo, send player to igloo room " + SHELL.idOfIglooRoomToJoin);
                        SHELL.sendJoinPlayerIgloo(SHELL.idOfIglooRoomToJoin);
                        SHELL.setJoinGameFromIgloo(false, "");
                    } else {
                        trace("ELSE CALLED SHELL.sendJoinRoom leave_room:" + leave_room);
                        SHELL.sendJoinRoom(leave_room, 0, 0);
                    }
                }
            } else {
                trace("ELSE. send a leave game message to request the stamp object");
                stampInfoAbort = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, abortStampInfoRequest), 1000);
                clientProxy.sendLeaveGameMessage();
            }
            leaveGameCalled = true;
            dLearningManager.quitGame();
        }
        function abortStampInfoRequest() {
            trace("aborting stamp info request");
            endOfGameStampObject = new Object();
            endOfGameStampObject.stampIds = new Array();
            leaveGame();
        }
        function isPlayerPresent(nickname) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                if (playerList[_local_2].nickname == nickname) {
                    this.log(nickname + " is already presented...");
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function updatePlayerName() {
            var _local_2 = 0;
            while (_local_2 < seatMap.length) {
                var _local_3 = seatMap[_local_2].nickname.toUpperCase();
                if (seatMap[_local_2].nickname.toUpperCase() == "SENSEI") {
                    _local_3 = String(com.clubpenguin.util.LocaleText.getText("sensei_label")).toUpperCase();
                }
                root_mc["tf_name" + _local_2].text = _local_3;
                _local_2++;
            }
        }
        function updateMessage(msg) {
            root_mc.tf_msg.text = msg;
        }
        function setHelpStatus(status) {
            bHelpOn = status;
        }
        function addItem(item_id) {
            var _local_2 = SHELL.getInventoryObjectById(item_id);
            var _local_1 = SHELL.getMyInventoryArray();
            if (!SHELL.isItemInMyInventory(item_id)) {
                _local_1.push(_local_2);
            }
        }
        function showLoading(show) {
            root_mc.loading_mc._visible = (show ? true : false);
        }
        function log(msg) {
            com.clubpenguin.util.Debug.log(msg, myPlayer.nickname);
        }
        function debugGame() {
            this.log("##########################DEBUG GAME##########################");
            this.log("Player List:");
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                this.log("--->" + playerList[_local_2]);
                _local_2++;
            }
            this.log("Seat Map:");
            _local_2 = 0;
            while (_local_2 < seatMap.length) {
                this.log((_local_2 + "--->") + seatMap[_local_2]);
                _local_2++;
            }
            this.log("myPlayer: " + myPlayer);
            this.log("opponent: " + opponent);
            this.log("###############################################################");
        }
        static var CLASS_PACKAGE = "com.clubpenguin.games.card";
        static var CLASS_NAME = "GameEngine";
        static var AIRTOWER = _global.getCurrentAirtower();
        static var INTERFACE = _global.getCurrentInterface();
        static var ENGINE = _global.getCurrentEngine();
        static var SHELL = _global.getCurrentShell();
        static var MODE_FRD = 1;
        static var MODE_EXP = 2;
        static var MODE_SEN = 3;
        static var AWARD_FILE = _global.getCurrentShell().getGameContentPath() + "/card/award/award.swf";
        static var AWARD_ITEM = [null, 4025, 4026, 4027, 4028, 4029, 4030, 4031, 4032, 4033, 104, 6077, 4380, 2033, 1271];
        var __classPackage = CLASS_PACKAGE;
        var __className = CLASS_NAME;
        var leaveGameCalled = false;
    }
