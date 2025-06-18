//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.GameEngine extends MovieClip
    {
        var __mainTimeline, __gameEvent, __configXML, __gameSoundList, __loaderListener, __gameMode, __targetColor, __nonTargetColorDisplayList, __level, __score, __lives, __truckUnloadedTrigger, __truckClip, __penguinClip, __startBag, __livesToggle, __tryAgainToggle, __totalStacked, __totalWrongStacked, __totalRightStacked, __changingLevels, __sign, __xmlPath, __bagDropsLeft, __backIntoTruckBag, __bagStack, __wrongBagsList, __bagStackX, __bagStackY, __stackBagPool, __xmlNode_level, __xmlNode_gameDifficulty, __xmlNode_game_id, __levelType, __beanBagStackTimeline, __percentCorrectBags, __tryAgainClip, __scoreEvent, __scoreChangeValue;
        function GameEngine (game_timeline) {
            super();
            __mainTimeline = game_timeline;
            initDLS();
            __mainTimeline.onEnterFrame = com.clubpenguin.util.Delegate.create(this, update);
            __gameEvent = GAMEEVENT_BEANCOUNTERS_START;
            pushOpcode("start", "0");
            __gameEvent = GAMEEVENT_BEANCOUNTERS_SELECTED;
            pushOpcode("selected", "0");
            __configXML = new XML();
            __gameSoundList = new Array();
            __loaderListener = new Object();
            __loaderListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this, handleLoaderComplete);
            com.clubpenguin.util.Loader.addEventListener(__loaderListener);
        }
        function initDLS() {
            var _local_3 = _global.getCurrentShell();
            var _local_2 = _local_3.getMyPlayerId();
            if (_local_2 == undefined) {
                _local_2 = -1;
            }
            com.disney.dlearning.managers.DLSManager.init(String(_local_2), "bc.k.api.dlsnetwork.com");
        }
        function handleLoaderComplete() {
            com.clubpenguin.util.Loader.removeEventListener(__loaderListener);
            var _local_6 = _global.getCurrentShell();
            _root.gameDirectory = com.clubpenguin.util.LocaleText.getGameDirectory();
            var _local_5 = ("lang/" + com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.getLocaleID())) + "/";
            var _local_4 = new MovieClipLoader();
            _local_4.loadClip((_root.gameDirectory + _local_5) + "logo.swf", __mainTimeline.title_mc.logo_mc);
            __mainTimeline.title_norm_mc.ui_play.text = com.clubpenguin.util.LocaleText.getText("ui_play").toUpperCase();
            __mainTimeline.title_norm_mc.ui_instructions.text = com.clubpenguin.util.LocaleText.getText("ui_instructions").toUpperCase();
            __mainTimeline.title_adv_mc.ui_hard.text = com.clubpenguin.util.LocaleText.getText("ui_hard").toUpperCase();
            __mainTimeline.title_adv_mc.ui_expert.text = com.clubpenguin.util.LocaleText.getText("ui_expert").toUpperCase();
            __mainTimeline.title_adv_mc.ui_extreme.text = com.clubpenguin.util.LocaleText.getText("ui_extreme").toUpperCase();
        }
        function get gameMode() {
            return(__gameMode);
        }
        function get targetColor() {
            return(__targetColor);
        }
        function get nonTargetColorDisplayList() {
            return(__nonTargetColorDisplayList);
        }
        function get bagLauncher() {
            return(com.clubpenguin.games.beancounters.BagLauncher.getInstance);
        }
        function get mainTimeline() {
            return(__mainTimeline);
        }
        function get level() {
            return(__level);
        }
        function get score() {
            return(__score);
        }
        function set score(param) {
            __score = param;
            //return(score);
        }
        function get lives() {
            return(__lives);
        }
        function set lives(param) {
            __lives = param;
            //return(lives);
        }
        function get gameDifficulty() {
            return(__gameDifficulty);
        }
        function get truckUnloadedTrigger() {
            return(__truckUnloadedTrigger);
        }
        function set truckUnloadedTrigger(param) {
            __truckUnloadedTrigger = param;
            //return(truckUnloadedTrigger);
        }
        function get truckClip() {
            return(__truckClip);
        }
        function get penguinClip() {
            return(__penguinClip);
        }
        function get gameEvent() {
            return(__gameEvent);
        }
        function set gameEvent(param) {
            __gameEvent = param;
            //return(gameEvent);
        }
        function get isInvincibleShieldOn() {
            return(__isInvincibleShieldOn);
        }
        function initGame(mode) {
            __gameMode = mode;
            __mainTimeline.lives_label.text = com.clubpenguin.util.LocaleText.getText("score_lives");
            __mainTimeline.truck_label.text = com.clubpenguin.util.LocaleText.getText("score_truck");
            __mainTimeline.score_label.text = com.clubpenguin.util.LocaleText.getText("score_score");
            __mainTimeline.bagDropsLeft_label.text = com.clubpenguin.util.LocaleText.getText("score_bagdrops");
            __mainTimeline.hazardPoof._visible = false;
            __mainTimeline.matchColors._visible = false;
            __mainTimeline.levelUp._visible = false;
            __mainTimeline.tryAgain._visible = false;
            __mainTimeline.gameOver._visible = false;
            __mainTimeline.youWin.swapDepths(60000);
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.init(this);
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagCounter = 1;
            __startBag = 0;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = 0;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.maxAirborne = 1;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.oneUpToggle = true;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.invincibleShieldPowerUpToggle = true;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.anvilOut = false;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.fishOut = false;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.flowerOut = false;
            __score = 0;
            __lives = 3;
            __level = 1;
            __mainTimeline.livesBoard.text = __lives.toString();
            __mainTimeline.truckNumber.text = __level.toString();
            __livesToggle = false;
            __tryAgainToggle = false;
            __truckUnloadedTrigger = false;
            __totalStacked = 0;
            __totalWrongStacked = 0;
            __totalRightStacked = 0;
            __changingLevels = false;
            __sign = __mainTimeline.sign;
            __gameDifficulty = __mainTimeline.gameDifficulty;
            __configXML.ignoreWhite = true;
            var _local_3 = _global.getCurrentShell();
            __xmlPath = _local_3.getGamesPath().split("/").slice(0, -2).join("/") + "/games/beans/";
            __configXML.load(__xmlPath + "config.xml");
            __configXML.onLoad = com.clubpenguin.util.Delegate.create(this, function (loaded) {
                if (loaded) {
                    this.onXMLLoaded();
                } else {
                    this.__xmlPath = "./";
                    this.__configXML.load(this.__xmlPath + "config.xml");
                    this.__configXML.onLoad = com.clubpenguin.util.Delegate.create(this, function (loaded) {
                        if (loaded) {
                            this.onXMLLoaded();
                        }
                    });
                }
            });
            switch (__gameMode) {
                case 1 : 
                    __sign._visible = false;
                    __truckClip = __mainTimeline.truck;
                    __mainTimeline.candyTruck._visible = false;
                    __mainTimeline.bagDropsLeft_label._visible = false;
                    __mainTimeline.bagDropsLeftBoard._visible = false;
                    __mainTimeline.stack._visible = false;
                    __penguinClip = __mainTimeline.peng;
                    __mainTimeline.candyPeng._visible = false;
                    __gameEvent = GAMEEVENT_NORMAL_START;
                    pushOpcode("start", "0");
                    __gameEvent = GAMEEVENT_NORMAL_SELECTED;
                    pushOpcode("selected", "0");
                    break;
                case 2 : 
                    __sign._visible = true;
                    __truckClip = __mainTimeline.candyTruck;
                    __mainTimeline.truck._visible = false;
                    if (__gameDifficulty != 3) {
                        __mainTimeline.bagDropsLeft_label._visible = false;
                        __mainTimeline.bagDropsLeftBoard._visible = false;
                    }
                    __bagDropsLeft = __maxBagDrops;
                    __mainTimeline.bagDropsLeftBoard.text = __bagDropsLeft.toString();
                    __backIntoTruckBag = __mainTimeline.back_into_truck;
                    __bagStack = new Array();
                    __wrongBagsList = new Array();
                    __bagStackX = 0;
                    __bagStackY = 0;
                    __mainTimeline.stack1._visible = false;
                    __stackBagPool = new Array();
                    __penguinClip = __mainTimeline.candyPeng;
                    __mainTimeline.peng._visible = false;
                    __gameEvent = GAMEEVENT_COLOR_START;
                    pushOpcode("start", "0");
                    __gameEvent = GAMEEVENT_COLOR_SELECTED;
                    pushOpcode("selected", "0");
                    __gameEvent = GAMEEVENT_COLOR_DIFFICULTYLEVEL_SELECTED;
                    pushOpcode("selected", "0");
                    break;
            }
        }
        function onXMLLoaded() {
            if (__gameMode == 1) {
                __xmlNode_level = __configXML.childNodes[0].childNodes[0].childNodes[__level - 1];
                __gameEvent = GAMEEVENT_NORMAL_LEVEL_START;
                pushOpcode("start", "0");
                __gameEvent = GAMEEVENT_NORMAL_LEVEL_SELECTED;
                pushOpcode("selected", "0");
                __gameLoaded = true;
            } else if (__gameMode == 2) {
                __xmlNode_gameDifficulty = __configXML.childNodes[0].childNodes[1].childNodes[__gameDifficulty - 1];
                __xmlNode_level = __xmlNode_gameDifficulty.childNodes[__level - 1];
                var _local_2 = __xmlNode_level.childNodes[0].attributes.id;
                __xmlNode_game_id = _local_2;
                loadGame(__xmlNode_game_id);
            }
            __penguinClip.init(com.clubpenguin.games.beancounters.BagLauncher.getInstance);
            __truckClip.swapDepths(50000);
            __currentTime = new Date().getTime();
        }
        function loadGame(xml_gameId) {
            __gameLoaded = true;
            __targetColor = new Array();
            __mainTimeline.matchColors._visible = true;
            __mainTimeline.matchColors.gotoAndPlay(2);
            __mainTimeline.matchColors.msg_matchcolors.text = com.clubpenguin.util.LocaleText.getText("msg_matchcolors").toUpperCase();
            switch (xml_gameId) {
                case "monochrome" : 
                    var _local_5 = Math.ceil(Math.random() * 11);
                    __targetColor.push(__sign.colorList[_local_5]);
                    __levelType = "monochrome";
                    break;
                case "complementary" : 
                    var _local_3 = Math.ceil(Math.random() * 5);
                    var _local_2 = 0;
                    while (_local_2 < __sign.complementaryColorList[0].length) {
                        __targetColor.push(__sign.complementaryColorList[_local_3][_local_2]);
                        _local_2++;
                    }
                    __levelType = "complementary";
                    break;
                case "analogous" : 
                    var _local_4 = Math.ceil(Math.random() * 5);
                    _local_2 = 0;
                    while (_local_2 < __sign.analogousColorList[0].length) {
                        __targetColor.push(__sign.analogousColorList[_local_4][_local_2]);
                        _local_2++;
                    }
                    __levelType = "analogous";
                    break;
                case "warm" : 
                    _local_2 = 0;
                    while (_local_2 < __sign.warmColorList.length) {
                        __targetColor.push(__sign.warmColorList[_local_2]);
                        _local_2++;
                    }
                    __levelType = "warm";
                    break;
                case "cool" : 
                    _local_2 = 0;
                    while (_local_2 < __sign.coolColorList.length) {
                        __targetColor.push(__sign.coolColorList[_local_2]);
                        _local_2++;
                    }
                    __levelType = "cool";
                    break;
                case "primary" : 
                    _local_2 = 0;
                    while (_local_2 < __sign.primaryColorList.length) {
                        __targetColor.push(__sign.primaryColorList[_local_2]);
                        _local_2++;
                    }
                    __levelType = "primary";
                    break;
                case "secondary" : 
                    _local_2 = 0;
                    while (_local_2 < __sign.secondaryColorList.length) {
                        __targetColor.push(__sign.secondaryColorList[_local_2]);
                        _local_2++;
                    }
                    __levelType = "secondary";
                    break;
                case "tertiary" : 
                    _local_2 = 0;
                    while (_local_2 < __sign.tertiaryColorList.length) {
                        __targetColor.push(__sign.tertiaryColorList[_local_2]);
                        _local_2++;
                    }
                    __levelType = "tertiary";
                    break;
            }
            generateBagColor();
            updateColorSign();
            __gameEvent = GAMEEVENT_COLOR_LEVEL_START;
            pushOpcode("start", "0");
        }
        function updateColorSign() {
            var _local_3 = new Array();
            var _local_2 = 0;
            while (_local_2 < __sign.colorSignMcList.length) {
                var _local_4 = 0;
                while (_local_4 < __targetColor.length) {
                    if (__targetColor[_local_4] == __sign.colorList[_local_2]) {
                        _local_3.push(_local_2);
                    }
                    _local_4++;
                }
                __sign.colorSignMcList[_local_2]._visible = false;
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < _local_3.length) {
                var _local_4 = _local_3[_local_2];
                __sign.colorSignMcList[_local_4]._visible = true;
                _local_2++;
            }
            _local_3 = null;
        }
        function initBagStack() {
            var _local_3;
            var _local_4 = 0;
            var _local_2 = 0;
            while (_local_2 < 60) {
                _local_3 = __mainTimeline.snowDriftandPlatform.attachMovie("StackBag", "newStackBag" + _local_2, __mainTimeline.snowDriftandPlatform.getNextHighestDepth());
                _local_3._y = _local_4 - 15;
                _local_4 = _local_3._y;
                __stackBagPool.push(__mainTimeline.snowDriftandPlatform["newStackBag" + _local_2]);
                _local_2++;
            }
        }
        function nextLevel() {
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagCounter = 1;
            __startBag = 0;
            if (com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagActivity > 1) {
                com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagActivity = com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagActivity - 3;
            }
            if (((__gameDifficulty != 1) && (__level != 2)) || ((__gameDifficulty == 1) && (__level > 2))) {
                com.clubpenguin.games.beancounters.BagLauncher.getInstance.maxAirborne = (com.clubpenguin.games.beancounters.BagLauncher.getInstance.maxAirborne+1);
            }
            __level++;
            __mainTimeline.truckNumber.text = __level.toString();
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = 0;
            __totalStacked = 0;
            __totalWrongStacked = 0;
            __totalRightStacked = 0;
            __mainTimeline.stack.gotoAndStop(1);
            __penguinClip.gotoAndStop(1);
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.oneUpToggle = true;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.invincibleShieldPowerUpToggle = true;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.invincibleShieldPowerUpCounter = 0;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.fishCounter = 0;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.fishMax = com.clubpenguin.games.beancounters.BagLauncher.getInstance.fishMax + 4;
            __maxBagDrops = __maxBagDrops + 10;
            __bagDropsLeft = __maxBagDrops;
            __mainTimeline.bagDropsLeftBoard.text = __bagDropsLeft.toString();
            __truckUnloadedTrigger = false;
            __changingLevels = false;
            __targetColor = null;
            __targetColor = new Array();
            __penguinClip.reset();
            if (__gameMode == 1) {
                __xmlNode_level = __configXML.childNodes[0].childNodes[0].childNodes[__level - 1];
                __beanBagStackTimeline.gotoAndStop(1);
                __gameEvent = GAMEEVENT_NORMAL_LEVEL_START;
                pushOpcode("start", "0");
                __gameEvent = GAMEEVENT_NORMAL_LEVEL_SELECTED;
                pushOpcode("selected", "0");
            } else if (__gameMode == 2) {
                __xmlNode_level = __xmlNode_gameDifficulty.childNodes[__level - 1];
                __xmlNode_game_id = __xmlNode_level.childNodes[0].attributes.id;
                loadGame(__xmlNode_game_id);
                com.clubpenguin.games.beancounters.BagLauncher.getInstance.invincibleShieldPowerUpMax = __xmlNode_level.childNodes[3].attributes.frequency;
                unstackBags();
            }
        }
        function triggerLevel() {
            var _local_2 = false;
            var _local_3 = Number(__xmlNode_level.childNodes[__gameMode].childNodes[0].attributes.val);
            if (__totalRightStacked == _local_3) {
                _local_2 = true;
            }
            return(_local_2);
        }
        function continueLevel() {
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagCounter = 1;
            __startBag = 0;
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = 0;
            __penguinClip.gotoAndStop(1);
            __tryAgainToggle = false;
            __livesToggle = false;
            __mainTimeline.bagDropsLeftBoard.text = __bagDropsLeft.toString();
            __penguinClip.reset();
        }
        function endLevel() {
            __percentCorrectBags = (__totalRightStacked / __totalStacked) * 100;
            if (__gameMode == 1) {
                __gameEvent = GAMEEVENT_NORMAL_LEVEL_STOP;
                pushOpcode("stop", "0");
            } else if (__gameMode == 2) {
                __gameEvent = GAMEEVENT_COLOR_LEVEL_STOP;
                pushOpcode("stop", "0");
                __gameEvent = GAMEEVENT_COLOR_LEVEL_LEARNERSCORE;
                pushOpcode("learnerscore", String(__percentCorrectBags));
            }
        }
        function endGame() {
            __mainTimeline.youWin.nextFrame();
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = 1000;
        }
        function getCoins(bonus, event) {
            var _local_4 = __score;
            if (__gameMode != 0) {
                endLevel();
                if (__gameMode == 1) {
                    __gameEvent = GAMEEVENT_NORMAL_STOP;
                } else if (__gameMode == 2) {
                    __gameEvent = GAMEEVENT_COLOR_STOP;
                }
                pushOpcode("stop", "0");
                if (__gameMode == 1) {
                    __gameEvent = GAMEEVENT_NORMAL_GAMESCORE;
                } else if (__gameMode == 2) {
                    __gameEvent = GAMEEVENT_COLOR_GAMESCORE;
                }
                __mainTimeline.levelUp.stop();
                __mainTimeline.levelUp._visible = false;
                delete __configXML;
                __configXML = null;
            }
            __gameEvent = GAMEEVENT_BEANCOUNTERS_STOP;
            pushOpcode("stop", "0");
            if (_local_4 == undefined) {
                _local_4 = 0;
            }
            if (bonus == undefined) {
                bonus = 0;
            }
            var _local_3 = new Object();
            _local_3.score = _local_4 + (bonus * 10);
            _local_3.coins = Math.floor(_local_3.score / 10);
            pushOpcode("gamescore", _local_3.score, event, _local_3.coins);
            _root.showWindow("Game Over", _local_3);
        }
        function initTryAgain() {
            __tryAgainClip = __mainTimeline.tryAgain;
        }
        function tryAgainLoop() {
            if (((__penguinClip._currentframe >= 7) and (__lives < 0)) and (!__mainTimeline.gameOver._visible)) {
                __lives = 0;
                __mainTimeline.livesBoard.text = __lives.toString();
                __mainTimeline.gameOver._visible = true;
                getCoins(0, "lose");
            } else if ((__penguinClip._currentframe >= 7) and (__lives > 0)) {
                __tryAgainClip._visible = true;
                if (__tryAgainToggle == false) {
                    __tryAgainClip.play();
                    __tryAgainToggle = true;
                    __mainTimeline.livesBoard.text = __lives.toString();
                }
            }
            if (__tryAgainClip._visible == true) {
                com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = 1000;
            }
        }
        function generateBagColor() {
            var _local_5 = new Array();
            __nonTargetColorDisplayList = new Array();
            var _local_4 = 0;
            while (_local_4 < __sign.colorList.length) {
                var _local_3;
                var _local_2 = 0;
                while (_local_2 < __targetColor.length) {
                    if (__sign.colorList[_local_4] == __targetColor[_local_2]) {
                        _local_3 = 99;
                        break;
                    } else {
                        _local_3 = _local_4;
                    }
                    _local_2++;
                }
                if (_local_3 != 99) {
                    _local_5.push(__sign.colorList[_local_3]);
                }
                _local_4++;
            }
            _local_4 = 0;
            while (_local_4 < __targetColor.length) {
                var _local_6 = Math.floor(Math.random() * _local_5.length);
                __nonTargetColorDisplayList.push(_local_5.splice(_local_6, 1).pop());
                colorBeansOnTruck();
                _local_4++;
            }
            _local_5 = null;
        }
        function colorBeansOnTruck() {
            var _local_4 = 0;
            while (_local_4 < __truckClip.colorBeanList.length) {
                var _local_2 = 0;
                while (_local_2 < __nonTargetColorDisplayList.length) {
                    var _local_3 = new Color(__truckClip.colorBeanList[_local_2 + _local_4]);
                    _local_3.setRGB(__nonTargetColorDisplayList[_local_2]);
                    _local_3 = null;
                    _local_2++;
                }
                _local_4 = _local_4 + __nonTargetColorDisplayList.length;
            }
        }
        function unstackBags() {
            var _local_2 = 0;
            while (_local_2 < __bagStack.length) {
                __bagStack[_local_2].removeMovieClip();
                _local_2++;
            }
            __bagStack.splice(0, __bagStack.length);
            __bagStackX = 0;
            __bagStackY = 0;
        }
        function setJellyBeanColor(jellyBean, bag) {
            var _local_1 = new Color(jellyBean.bag_mc.bag_mc_fade.jellyBeans);
            _local_1.setRGB(bag["color"]);
            _local_1 = null;
        }
        function bagCrash(mc) {
            if ((__mainTimeline.levelUp._visible != true) and (com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne < 500)) {
                com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = (com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne-1);
                if (__gameMode == 2) {
                    __bagDropsLeft--;
                    __mainTimeline.bagDropsLeftBoard.text = __bagDropsLeft.toString();
                }
            }
            var _local_2 = 0;
            while (_local_2 < com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagList.length) {
                if (mc._parent == com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagList[_local_2]) {
                    setJellyBeanColor(mc, com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagList[_local_2]);
                }
                _local_2++;
            }
            if (__gameMode == 2) {
                if ((__bagDropsLeft == 0) and (__gameDifficulty == 3)) {
                    __bagDropsLeft = __maxBagDrops;
                    __truckClip.truckSym.beanDropSign_tooManyBagsDropped._visible = true;
                    __truckClip.truckSym.beanDropSign_tooManyBagsDropped.gotoAndPlay(2);
                    if (__lives > 0) {
                        __tryAgainClip._visible = true;
                        __tryAgainClip.play();
                        __tryAgainToggle = true;
                    }
                    __lives--;
                    if (__lives < 0) {
                        __lives = 0;
                        __mainTimeline.gameOver._visible = true;
                        getCoins(0, "lose");
                    }
                    __mainTimeline.livesBoard.text = __lives.toString();
                } else if (((__bagDropsLeft == (__maxBagDrops - 1)) || ((__bagDropsLeft % 10) == 0)) && (!__truckClip.truckSym.beanDropSign_throwBackWrongBag._visible)) {
                    __truckClip.truckSym.beanDropSign_doNotDropBags._visible = true;
                    __truckClip.truckSym.beanDropSign_doNotDropBags.gotoAndPlay(2);
                }
            }
        }
        function onBagStack(timeline, gamemode) {
            if (gamemode == __gameMode) {
                var _local_3 = __penguinClip;
                var _local_2;
                if ((((_local_3._x <= 230) and (_local_3._currentframe >= 2)) and (_local_3._currentframe <= 6)) and (__mainTimeline.youWin._currentframe != 2)) {
                    timeline._visible = true;
                    __penguinClip.prevFrame();
                    addSound("sound_beanbagPlace", 25);
                    if (__gameMode == 1) {
                        __beanBagStackTimeline = timeline;
                        __beanBagStackTimeline.nextFrame();
                        __totalRightStacked++;
                        __scoreEvent = SCOREEVENT_PLACE_RIGHTBAG;
                        var _local_5 = __xmlNode_level.childNodes[0].childNodes[__scoreEvent - 1].childNodes[0].attributes.val;
                        __scoreChangeValue = Number(_local_5);
                        __score = __score + Math.ceil(__scoreChangeValue);
                        if (__mainTimeline.levelUp._visible == true) {
                            __score = __score + (__level * 25);
                        }
                        if (triggerLevel()) {
                            __truckUnloadedTrigger = true;
                        }
                    } else if (__gameMode == 2) {
                        var _local_4 = __penguinClip.updateBagColorOnPop();
                        if (__isInvincibleShieldOn) {
                            __penguinClip.glowPenguinShield();
                        }
                        _local_2 = __mainTimeline.snowDriftandPlatform.attachMovie("StackBag", "newStackBag" + __bagStack.length, __mainTimeline.snowDriftandPlatform.getNextHighestDepth());
                        _local_2._x = __bagStackX;
                        _local_2._y = (-__bagStackY) * 15;
                        __bagStackY++;
                        __bagStack.push(_local_2);
                        _local_2["color"] = _local_4;
                        if (matchColor(_local_4) == true) {
                            __scoreEvent = SCOREEVENT_PLACE_RIGHTBAG;
                            var _local_5 = __xmlNode_level.childNodes[1].childNodes[__scoreEvent - 1].childNodes[0].attributes.val;
                            __scoreChangeValue = Number(_local_5);
                            if (!__mainTimeline.gameOver._visible) {
                                __score = __score + Math.ceil(__scoreChangeValue);
                            }
                            __totalRightStacked++;
                            if (((__totalRightStacked % 25) == 0) && (__totalRightStacked > 0)) {
                                __bagStackX = __bagStackX + 20;
                                __bagStackY = 0;
                            }
                            if (triggerLevel()) {
                                __truckUnloadedTrigger = true;
                            }
                        } else {
                            __scoreEvent = SCOREEVENT_PLACE_WRONGBAG;
                            var _local_5 = __xmlNode_level.childNodes[1].childNodes[__scoreEvent - 1].childNodes[0].attributes.val;
                            __scoreChangeValue = Number(_local_5);
                            __scoreChangeValue = __scoreChangeValue + (Math.floor(__totalWrongStacked / 3) * __scoreChangeValue);
                            if (!__mainTimeline.gameOver._visible) {
                                __score = __score + Math.ceil(__scoreChangeValue);
                            }
                            __totalWrongStacked++;
                            _local_2.floatingScore.scoreLabel.text = Math.ceil(__scoreChangeValue);
                            _local_2.floatingScore._visible = true;
                            _local_2.tweenMe();
                            __wrongBagsList.push(_local_2);
                            __bagStackY--;
                            var fadeTween = (new mx.transitions.Tween(_local_2, "_alpha", mx.transitions.easing.Strong.easeOut, 100, 0, 2, true));
                            fadeTween.onMotionFinished = com.clubpenguin.util.Delegate.create(this, function () {
                                this.__bagStack.splice(this.__bagStack.getIndex(this.__wrongBagsList.shift()), 1);
                                delete fadeTween;
                                fadeTween = null;
                            });
                            if (((__totalWrongStacked == 1) || ((__totalWrongStacked % 10) == 0)) && (!__truckClip.truckSym.beanDropSign_doNotDropBags._visible)) {
                                __truckClip.truckSym.beanDropSign_throwBackWrongBag._visible = true;
                                __truckClip.truckSym.beanDropSign_throwBackWrongBag.gotoAndPlay(2);
                            }
                            if (__score < 0) {
                                __score = 0;
                            }
                        }
                    }
                    __mainTimeline.scoreBoard.text = __score.toString();
                    __totalStacked++;
                }
                if (((((_local_3._x > 400) and (_local_3._x <= 570)) and (__penguinClip._currentframe > 1)) and (__penguinClip._currentframe <= 6)) and (__gameMode != 1)) {
                    __penguinClip.prevFrame();
                    addSound("sound_beanbagPlace", 25);
                    if (__gameMode == 2) {
                        var _local_4 = __penguinClip.updateBagColorOnPop();
                        if (__isInvincibleShieldOn) {
                            __penguinClip.glowPenguinShield();
                        }
                        if (matchColor(_local_4) == false) {
                            __scoreEvent = SCOREEVENT_RETURN_WRONGBAG;
                            var _local_5 = __xmlNode_level.childNodes[1].childNodes[__scoreEvent - 1].childNodes[0].attributes.val;
                            __scoreChangeValue = Number(_local_5);
                            __score = __score + Math.ceil(__scoreChangeValue);
                            __mainTimeline.scoreBoard.text = __score.toString();
                        }
                        __backIntoTruckBag.setColor(_local_4);
                    }
                    __backIntoTruckBag.startAnimation();
                }
            }
        }
        function matchColor(beanBagColor) {
            var _local_3 = 0;
            var _local_2 = 0;
            while (_local_2 < __targetColor.length) {
                if (beanBagColor == __targetColor[_local_2]) {
                    _local_3 = 1;
                }
                _local_2++;
            }
            if (_local_3 == 1) {
                return(true);
            } else {
                return(false);
            }
        }
        function update() {
            if (__gameLoaded) {
                com.clubpenguin.games.beancounters.BagLauncher.getInstance.update();
            }
            __previousTime = __currentTime;
            __currentTime = new Date().getTime();
            __elapsed = (__elapsedTime = __currentTime - __previousTime);
            __totalElapsedTime = __totalElapsedTime + (__elapsedTime / 1000);
            if (__isInvincibleShieldOn == true) {
                var _local_5 = __totalBeanTime - Math.ceil(__totalElapsedTime);
                if (((_local_5 <= 0) or (__mainTimeline.tryAgain._visible == true)) or (__mainTimeline.levelUp._visible == true)) {
                    __isInvincibleShieldOn = false;
                    __penguinClip.clearPenguinShield();
                } else if (_local_5 <= 5) {
                    if ((__totalElapsedTime % Math.floor(__totalElapsedTime)) < 0.5) {
                        __penguinClip.glowPenguinShield();
                    } else {
                        __penguinClip.clearPenguinShield();
                    }
                }
            }
            if (((__penguinClip._currentframe <= 6) and (!__mainTimeline.levelUp._visible)) and (__mainTimeline.youWin._currentframe != 2)) {
                __penguinClip._x = __mainTimeline._xmouse;
                if (__mainTimeline._xmouse < 190) {
                    __penguinClip._x = 190;
                }
                if (__mainTimeline._xmouse > 555) {
                    __penguinClip._x = 555;
                }
            }
            if ((__penguinClip._currentframe >= 7) and (__livesToggle == false)) {
                if (__penguinClip._currentframe == 7) {
                    addSound("sound_toonhit");
                }
                __lives--;
                __livesToggle = true;
                __mainTimeline.livesBoard.text = __lives.toString();
            }
            if (com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagCounter > 10) {
                __startBag = com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagCounter - 10;
            }
            var _local_4 = 0;
            while (_local_4 < com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagCircularList.length) {
                var _local_3 = com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagCircularList[_local_4].bag;
                if (((((__penguinClip.hitTest(_local_3) and (_local_3._currentframe < _local_3.throwLength)) and (__penguinClip._currentframe <= 6)) and (_local_3._currentframe > 6)) and (__mainTimeline.levelUp._visible != true)) and (__mainTimeline.youWin._currentframe != 2)) {
                    onBagCatch(_local_3, _local_4);
                }
                _local_4++;
            }
            var _local_2 = __startBag;
            while (_local_2 < com.clubpenguin.games.beancounters.BagLauncher.getInstance.bagCounter) {
                var _local_3 = __mainTimeline["oneup" + _local_2].item;
                if ((((__penguinClip.hitTest(_local_3) and (_local_3._currentframe < _local_3.throwLength)) and (__penguinClip._currentframe <= 6)) and (_local_3._currentframe > 6)) and (__mainTimeline.levelUp._visible != true)) {
                    __lives++;
                    __mainTimeline.livesBoard.text = __lives.toString();
                    _local_3.gotoAndStop(1);
                    __mainTimeline["oneup" + _local_2].removeMovieClip();
                    com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = (com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne-1);
                    addSound("sound_boing");
                    __mainTimeline.oneUpNotify._x = __penguinClip._x;
                    __mainTimeline.oneUpNotify.play();
                }
                _local_3 = __mainTimeline["invincibleShieldPowerUp" + _local_2].item;
                if ((((__penguinClip.hitTest(_local_3) and (_local_3._currentframe < _local_3.throwLength)) and (__penguinClip._currentframe <= 6)) and (_local_3._currentframe > 6)) and (__mainTimeline.levelUp._visible != true)) {
                    _local_3.gotoAndStop(1);
                    __mainTimeline["invincibleShieldPowerUp" + _local_2].removeMovieClip();
                    com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = (com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne-1);
                    addSound("sound_powerUpPickUp");
                    __totalElapsedTime = 0;
                    __isInvincibleShieldOn = true;
                    __penguinClip.glowPenguinShield();
                }
                hazardHit("anvil", 8, _local_2);
                hazardHit("fish", 9, _local_2);
                hazardHit("flower", 10, _local_2);
                _local_2++;
            }
        }
        function hazardHit(hazardName, pengFrame, bagNumber) {
            var _local_3 = __mainTimeline[hazardName + bagNumber].hazard;
            if ((__penguinClip.hitTest(_local_3.collider) and (__mainTimeline.levelUp._visible != true)) and (__mainTimeline.youWin._currentframe != 2)) {
                if (!__isInvincibleShieldOn) {
                    __penguinClip.gotoAndStop(pengFrame);
                    if (pengFrame == 8) {
                        addSound("sound_anvil");
                    }
                    if (pengFrame == 9) {
                        addSound("sound_fish");
                    }
                    if (pengFrame == 10) {
                        addSound("sound_vase");
                    }
                    __mainTimeline.crash_mc._x = __penguinClip._x;
                    __mainTimeline.crash_mc.gotoAndPlay(2);
                } else {
                    __mainTimeline.hazardPoof._visible = true;
                    __mainTimeline.hazardPoof._x = __penguinClip._x;
                    __mainTimeline.hazardPoof._y = __penguinClip._y - (__penguinClip._height / 2);
                    __mainTimeline.hazardPoof.gotoAndPlay(2);
                    if (hazardName == "anvil") {
                        com.clubpenguin.games.beancounters.BagLauncher.getInstance.anvilOut = false;
                    }
                    if (hazardName == "fish") {
                        com.clubpenguin.games.beancounters.BagLauncher.getInstance.fishOut = false;
                    }
                    if (hazardName == "flower") {
                        com.clubpenguin.games.beancounters.BagLauncher.getInstance.flowerOut = false;
                    }
                    addSound("sound_poof");
                }
                _local_3.gotoAndStop(1);
                __mainTimeline[hazardName + bagNumber].removeMovieClip();
                com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = (com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne-1);
                __mainTimeline[hazardName + "Out"] = false;
            }
        }
        function onBagCatch(bagMc, bagNumber) {
            var _local_2;
            __penguinClip.nextFrame();
            addSound("sound_beanbagLand", 30);
            __scoreEvent = SCOREEVENT_CATCH_RIGHTBAG;
            if (__gameMode == 1) {
                _local_2 = __xmlNode_level.childNodes[0].childNodes[__scoreEvent - 1].childNodes[0].attributes.val;
            } else if (__gameMode == 2) {
                __penguinClip.updateBagColorOnPush(bagMc._parent.bagColor);
                if (__isInvincibleShieldOn) {
                    __penguinClip.glowPenguinShield();
                }
                _local_2 = __xmlNode_level.childNodes[1].childNodes[__scoreEvent - 1].childNodes[0].attributes.val;
            }
            __scoreChangeValue = Number(_local_2);
            __score = __score + Math.ceil(__scoreChangeValue);
            __mainTimeline.scoreBoard.text = __score.toString();
            bagMc._parent._visible = false;
            bagMc._parent.gotoAndStop(1);
            com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne = (com.clubpenguin.games.beancounters.BagLauncher.getInstance.airborne-1);
        }
        function addSound(clip, volume, loops) {
            if (volume == undefined) {
                volume = 100;
            }
            if (loops == undefined) {
                loops = 1;
            }
            var _local_4 = __mainTimeline.createEmptyMovieClip("soundClip" + __gameSoundList.length, __mainTimeline.getNextHighestDepth());
            var _local_2 = new Sound(_local_4);
            _local_2.setVolume(volume);
            _local_2.attachSound(clip);
            _local_2.start(0, loops);
            __gameSoundList.push(_local_2);
        }
        function pushOpcode(opcode, register1, register2, register3) {
            var _local_2 = assessmentGuidLookup();
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode(opcode, _local_2, dlsmcallback, register1, register2, register3);
        }
        function assessmentGuidLookup() {
            switch (__gameEvent) {
                case GAMEEVENT_BEANCOUNTERS_START : 
                case GAMEEVENT_BEANCOUNTERS_STOP : 
                case GAMEEVENT_BEANCOUNTERS_SELECTED : 
                    return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS);
                    break;
                case GAMEEVENT_NORMAL_START : 
                case GAMEEVENT_NORMAL_STOP : 
                case GAMEEVENT_NORMAL_SELECTED : 
                    return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS_NORMAL);
                    break;
                case GAMEEVENT_NORMAL_LEVEL_START : 
                case GAMEEVENT_NORMAL_LEVEL_STOP : 
                case GAMEEVENT_NORMAL_LEVEL_SELECTED : 
                    switch (__level) {
                        case 1 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS_LEVEL1);
                            break;
                        case 2 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS_LEVEL2);
                            break;
                        case 3 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS_LEVEL3);
                            break;
                        case 4 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS_LEVEL4);
                            break;
                        case 5 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS_LEVEL5);
                            break;
                    }
                    break;
                case GAMEEVENT_NORMAL_GAMESCORE : 
                    return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS_NORMAL_GAMESCORE);
                    break;
                case GAMEEVENT_COLOR_START : 
                case GAMEEVENT_COLOR_STOP : 
                case GAMEEVENT_COLOR_SELECTED : 
                    return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BEANCOUNTERS_COLORS);
                    break;
                case GAMEEVENT_COLOR_DIFFICULTYLEVEL_SELECTED : 
                    switch (__gameDifficulty) {
                        case 1 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_LEARNINGMODE_EASY);
                            break;
                        case 2 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_LEARNINGMODE_MEDIUM);
                            break;
                        case 3 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_LEARNINGMODE_HARD);
                            break;
                    }
                    break;
                case GAMEEVENT_COLOR_LEVEL_START : 
                case GAMEEVENT_COLOR_LEVEL_STOP : 
                case GAMEEVENT_COLOR_LEVEL_LEARNERSCORE : 
                    switch (__levelType) {
                        case "monochrome" : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_MONOCHROME);
                            break;
                        case "complementary" : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_COMPLIMENTARY_COLORS);
                            break;
                        case "analogous" : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_ANALOGOUS_COLORS);
                            break;
                        case "warm" : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_WARM_COLORS);
                            break;
                        case "cool" : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_COOL_COLORS);
                            break;
                        case "primary" : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_PRIMARY_COLORS);
                            break;
                        case "secondary" : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_SECONDARY_COLORS);
                            break;
                        case "tertiary" : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_TERTIARY_COLORS);
                            break;
                    }
                    break;
                case GAMEEVENT_COLOR_GAMESCORE : 
                    switch (__gameDifficulty) {
                        case 1 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_EASY_GAMESCORE);
                            break;
                        case 2 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_MEDIUM_GAMESCORE);
                            break;
                        case 3 : 
                            return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_HARD_GAMESCORE);
                    }
                    break;
                case GAMEEVENT_COLOR_INSTRUCTIONS_PAGE1 : 
                    return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_INSTRUCTIONS_PAGE1);
                    break;
                case GAMEEVENT_COLOR_INSTRUCTIONS_PAGE_HARD : 
                    return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_INSTRUCTIONS_PAGE_HARD);
                    break;
                case GAMEEVENT_COLOR_INSTRUCTIONS_PAGE_EXPERT : 
                    return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_INSTRUCTIONS_PAGE_EXPERT);
                    break;
                case GAMEEVENT_COLOR_INSTRUCTIONS_PAGE_EXTREME : 
                    return(com.clubpenguin.games.beancounters.OpcodeLibrary.GUID_BC_C_INSTRUCTIONS_PAGE_EXTREME);
                    break;
            }
        }
        function dlsmcallback(str) {
        }
        var __gameDifficulty = 0;
        var __correctBags = 0;
        static var GAMEEVENT_BEANCOUNTERS_START = 1;
        static var GAMEEVENT_BEANCOUNTERS_STOP = 2;
        static var GAMEEVENT_BEANCOUNTERS_SELECTED = 3;
        static var GAMEEVENT_NORMAL_START = 4;
        static var GAMEEVENT_NORMAL_STOP = 5;
        static var GAMEEVENT_NORMAL_SELECTED = 6;
        static var GAMEEVENT_NORMAL_LEVEL_START = 7;
        static var GAMEEVENT_NORMAL_LEVEL_STOP = 8;
        static var GAMEEVENT_NORMAL_LEVEL_SELECTED = 9;
        static var GAMEEVENT_NORMAL_GAMESCORE = 10;
        static var GAMEEVENT_COLOR_START = 11;
        static var GAMEEVENT_COLOR_STOP = 12;
        static var GAMEEVENT_COLOR_SELECTED = 13;
        var GAMEEVENT_COLOR_INSTRUCTIONS_PAGE1 = 14;
        var GAMEEVENT_COLOR_INSTRUCTIONS_PAGE_HARD = 15;
        var GAMEEVENT_COLOR_INSTRUCTIONS_PAGE_EXPERT = 16;
        var GAMEEVENT_COLOR_INSTRUCTIONS_PAGE_EXTREME = 17;
        static var GAMEEVENT_COLOR_DIFFICULTYLEVEL_SELECTED = 18;
        static var GAMEEVENT_COLOR_LEVEL_START = 19;
        static var GAMEEVENT_COLOR_LEVEL_STOP = 20;
        static var GAMEEVENT_COLOR_LEVEL_LEARNERSCORE = 21;
        var GAMEEVENT_COLOR_GAMESCORE = 22;
        static var SCOREEVENT_CATCH_RIGHTBAG = 1;
        static var SCOREEVENT_PLACE_RIGHTBAG = 2;
        static var SCOREEVENT_RETURN_WRONGBAG = 3;
        static var SCOREEVENT_PLACE_WRONGBAG = 4;
        var __isXMLLoaded = false;
        var __maxBagDrops = 10;
        var __elapsed = 40;
        var __currentTime = 0;
        var __previousTime = 0;
        var __elapsedTime = 0;
        var __totalBeanTime = 15;
        var __totalElapsedTime = 0;
        var __isInvincibleShieldOn = false;
        var __gameLoaded = false;
    }
