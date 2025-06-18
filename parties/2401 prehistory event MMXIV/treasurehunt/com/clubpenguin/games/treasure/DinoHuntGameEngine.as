//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.treasure.DinoHuntGameEngine
    {
        var stage, netClient, INTERFACE, ENGINE, SHELL, hackyHack, hackyHackNames, hackyHackDirections, hackyHackNumbers, superRareGemFound, eggsFound, treasureMap, gemLocations, playerDigMap;
        function DinoHuntGameEngine (gameMovie) {
            stage = gameMovie;
            stage.blocker.onRelease = function () {
            };
            stage.blocker.mouseEnabled = false;
            stage.alert_blocker_mc.onRelease = function () {
            };
            stage.alert_blocker_mc.mouseEnabled = false;
            init();
            netClient = new com.clubpenguin.games.treasure.net.DinoHuntClient(this);
            netClient.init();
            netClient.sendJoinGameMessage();
            INTERFACE = _global.getCurrentInterface();
            ENGINE = _global.getCurrentEngine();
            SHELL = _global.getCurrentShell();
        }
        function updatePlayerSeatID(seatID) {
            netPlayerID = seatID;
        }
        function updatePlayerNames(seatID, nickname) {
            if (seatID == PLAYER_1) {
                player1Name = nickname;
            } else if (seatID == PLAYER_2) {
                player2Name = nickname;
            }
            refreshPlayerNames();
        }
        function spectateGame(multiplayerInfo) {
            initMultiplayer(multiplayerInfo);
            updatePlayerNames(PLAYER_1, multiplayerInfo.player1Name);
            updatePlayerNames(PLAYER_2, multiplayerInfo.player2Name);
            netPlayerID = SPECTATOR;
            hackyHack = 0;
            hackyHackNames = multiplayerInfo.digRecordNames.split(",");
            hackyHackDirections = multiplayerInfo.digRecordDirections.split(",");
            hackyHackNumbers = multiplayerInfo.digRecordNumbers.split(",");
            executeCallback();
            if (multiplayerInfo.digRecordNumbers.length > 0) {
                for (var _local_3 in hackyHackNames) {
                    onDigButtonClick(hackyHackNames[_local_3], hackyHackDirections[_local_3], parseInt(hackyHackNumbers[_local_3]), true);
                }
            } else {
                currentPlayer = 0;
                refreshPlayerNames();
            }
            totalGemsFound = parseInt(multiplayerInfo.totalGemsFound);
            totalCoinsFound = parseInt(multiplayerInfo.totalCoinsFound);
            superRareGemFound = multiplayerInfo.superRareGemFound == "true";
            var _local_4 = (totalGemsFound * GEM_VALUE) + (totalCoinsFound * COIN_VALUE);
            if (superRareGemFound) {
                _local_4 = _local_4 + (GEM_VALUE * 3);
            }
            stage.coinsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_coins", ["" + totalCoinsFound]);
            stage.gemsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_gems", ["" + totalGemsFound]);
            stage.totalFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_total", ["" + _local_4]);
        }
        function initMultiplayer(multiplayerInfo) {
            eggsFound = [];
            MAP_WIDTH = multiplayerInfo.MAP_WIDTH;
            MAP_HEIGHT = multiplayerInfo.MAP_HEIGHT;
            COIN_NUM_HIDDEN = multiplayerInfo.COIN_NUM_HIDDEN;
            GEM_NUM_HIDDEN = multiplayerInfo.GEM_NUM_HIDDEN;
            NUM_TURNS = multiplayerInfo.NUM_TURNS;
            GEM_VALUE = parseInt(multiplayerInfo.GEM_VALUE);
            COIN_VALUE = parseInt(multiplayerInfo.COIN_VALUE);
            var _local_6 = multiplayerInfo.treasureMap.split(",");
            var _local_5 = multiplayerInfo.gemLocations.split(",");
            var _local_4;
            _local_4 = 0;
            treasureMap = new Array();
            var _local_3 = 0;
            while (_local_3 < MAP_HEIGHT) {
                treasureMap[_local_3] = new Array();
                var _local_2 = 0;
                while (_local_2 < MAP_WIDTH) {
                    treasureMap[_local_3][_local_2] = parseInt(_local_6[_local_4]);
                    _local_4++;
                    _local_2++;
                }
                _local_3++;
            }
            _local_4 = 0;
            gemLocations = new Array();
            _local_3 = 0;
            while (_local_3 < GEM_NUM_HIDDEN) {
                gemLocations[_local_3] = new Array();
                gemLocations[_local_3][0] = parseInt(_local_5[_local_4++]);
                gemLocations[_local_3][1] = parseInt(_local_5[_local_4++]);
                _local_3++;
            }
            init();
        }
        function init() {
            stage.player0_mc.anim.name_txt.text = com.clubpenguin.util.LocaleText.getText("ingame_waiting");
            stage.player1_mc.anim.name_txt.text = com.clubpenguin.util.LocaleText.getText("ingame_waiting");
            superRareGemFound = false;
            totalCoinsFound = 0;
            totalGemsFound = 0;
            currentPlayer = 0;
            currentTurn = 0;
            stage.coinsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_coins", ["" + totalCoinsFound]);
            stage.gemsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_gems", ["" + totalGemsFound]);
            stage.totalFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_total", ["0"]);
            createBG();
            renderTiles();
            createPlayerMap();
            createDigButtons();
            createButtonCovers();
            createDigButtonClickHandlers();
            updateDigButtonStatus();
            stage.close_btn.onRelease = com.clubpenguin.util.Delegate.create(this, abortGame);
        }
        function update() {
        }
        function createBG() {
            var _local_3 = 0;
            while (_local_3 < MAP_HEIGHT) {
                var _local_2 = 0;
                while (_local_2 < MAP_WIDTH) {
                    stage.placer.gems.attachMovie("mapsquare", (("mapsquare" + _local_3) + _local_2) + "_mc", ((_local_3 * 100) + (_local_2 * 10)) + 10);
                    var _local_4 = stage.placer.gems[(("mapsquare" + _local_3) + _local_2) + "_mc"];
                    _local_4._y = TILE_HEIGHT * _local_3;
                    _local_4._x = TILE_WIDTH * _local_2;
                    _local_2++;
                }
                _local_3++;
            }
        }
        function createBlankMap() {
            treasureMap = new Array();
            var _local_3 = 0;
            while (_local_3 < MAP_HEIGHT) {
                treasureMap[_local_3] = new Array();
                var _local_2 = 0;
                while (_local_2 < MAP_WIDTH) {
                    treasureMap[_local_3][_local_2] = TREASURE_NONE;
                    _local_2++;
                }
                _local_3++;
            }
        }
        function addMapGems() {
            gemLocations = new Array();
            var _local_3 = new Array();
            var _local_5 = 0;
            while (_local_5 < GEM_NUM_HIDDEN) {
                do {
                    var coordGood = true;
                    var _local_2 = [getRandom(MAP_HEIGHT - 1), getRandom(MAP_WIDTH - 1)];
                    var _local_4 = 0;
                    while (_local_4 < _local_3.length) {
                        if ((_local_2[0] == _local_3[_local_4][0]) && (_local_2[1] == _local_3[_local_4][1])) {
                            coordGood = false;
                        }
                        _local_4++;
                    }
                } while  (coordGood == false);
                gemLocations.push([_local_2[0], _local_2[1]]);
                _local_3.push([_local_2[0] - 1, _local_2[1] - 1]);
                _local_3.push([_local_2[0], _local_2[1] - 1]);
                _local_3.push([_local_2[0] + 1, _local_2[1] - 1]);
                _local_3.push([_local_2[0] - 1, _local_2[1]]);
                _local_3.push([_local_2[0], _local_2[1]]);
                _local_3.push([_local_2[0] + 1, _local_2[1]]);
                _local_3.push([_local_2[0] - 1, _local_2[1] + 1]);
                _local_3.push([_local_2[0], _local_2[1] + 1]);
                _local_3.push([_local_2[0] + 1, _local_2[1] + 1]);
                _local_5++;
            }
            _local_5 = 0;
            while (_local_5 < GEM_NUM_HIDDEN) {
                var _local_7 = gemLocations[_local_5][0];
                var _local_6 = gemLocations[_local_5][1];
                treasureMap[_local_7][_local_6] = TREASURE_GEM;
                treasureMap[_local_7][_local_6 + 1] = TREASURE_GEM_PIECE;
                treasureMap[_local_7 + 1][_local_6] = TREASURE_GEM_PIECE;
                treasureMap[_local_7 + 1][_local_6 + 1] = TREASURE_GEM_PIECE;
                _local_5++;
            }
        }
        function addMapCoins() {
            var _local_4 = 0;
            while (_local_4 < COIN_NUM_HIDDEN) {
                var _local_2 = getRandom(MAP_HEIGHT);
                var _local_3 = getRandom(MAP_WIDTH);
                if (treasureMap[_local_2][_local_3] == TREASURE_NONE) {
                    treasureMap[_local_2][_local_3] = TREASURE_COIN;
                }
                _local_4++;
            }
        }
        function renderTiles() {
            var _local_4;
            var _local_3 = 0;
            while (_local_3 < MAP_HEIGHT) {
                var _local_2 = 0;
                while (_local_2 < MAP_WIDTH) {
                    _local_4 = stage.placer.gems[(("mapsquare" + _local_3) + _local_2) + "_mc"];
                    if (treasureMap[_local_3][_local_2] == TREASURE_COIN) {
                        _local_4.gotoAndStop("coin");
                    }
                    _local_2++;
                }
                _local_3++;
            }
        }
        function createPlayerMap() {
            playerDigMap = new Array();
            var _local_4;
            var _local_3 = 0;
            while (_local_3 < MAP_HEIGHT) {
                playerDigMap[_local_3] = new Array();
                var _local_2 = 0;
                while (_local_2 < MAP_WIDTH) {
                    playerDigMap[_local_3][_local_2] = 0;
                    stage.placer.attachMovie("dirtsquare", (("dirtsquare" + _local_3) + _local_2) + "_mc", 1000 + ((_local_3 * 100) + _local_2));
                    _local_4 = stage.placer[(("dirtsquare" + _local_3) + _local_2) + "_mc"];
                    _local_4._y = TILE_HEIGHT * _local_3;
                    _local_4._x = TILE_WIDTH * _local_2;
                    _local_2++;
                }
                _local_3++;
            }
        }
        function createDigButtons() {
            var _local_5;
            var _local_4;
            var _local_3 = 0;
            while (_local_3 < MAP_WIDTH) {
                stage.placer.attachMovie("downbutton", ("downbutton" + _local_3) + "_mc", 2000 + _local_3);
                _local_5 = stage.placer[("downbutton" + _local_3) + "_mc"];
                _local_5._x = TILE_WIDTH * _local_3;
                _local_5._y = _local_5._y - TILE_HEIGHT;
                _local_3++;
            }
            var _local_2 = 0;
            while (_local_2 < MAP_HEIGHT) {
                stage.placer.attachMovie("rightbutton", ("rightbutton" + _local_2) + "_mc", 2100 + _local_2);
                _local_4 = stage.placer[("rightbutton" + _local_2) + "_mc"];
                _local_4._x = _local_4._x - TILE_WIDTH;
                _local_4._y = TILE_HEIGHT * (_local_2 - 0.5);
                _local_2++;
            }
        }
        function createButtonCovers() {
            var _local_2 = 0;
            while (_local_2 < MAP_WIDTH) {
                stage.placer[("downbutton" + _local_2) + "_mc"]._visible = false;
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < MAP_HEIGHT) {
                stage.placer[("rightbutton" + _local_2) + "_mc"]._visible = false;
                _local_2++;
            }
        }
        function getRandom(maxValue) {
            return(Math.floor(Math.random() * maxValue));
        }
        function updateForNextTurn(buttonDir, buttonNum) {
            var _local_3 = "spade" + (Math.floor(currentTurn) + 1);
            stage[_local_3].gotoAndStop(2);
            currentTurn++;
            stage.turnNum.text = (currentTurn + "/") + NUM_TURNS;
            currentPlayer = ((currentPlayer == 0) ? 1 : 0);
            stage.playerNum.text = "Player " + currentPlayer;
            refreshPlayerNames();
            updateDigButtonStatus();
            updateGemStatus();
            var _local_2 = (totalGemsFound * GEM_VALUE) + (totalCoinsFound * COIN_VALUE);
            if (superRareGemFound) {
                _local_2 = _local_2 + (GEM_VALUE * 3);
            }
            stage.coinsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_coins", ["" + totalCoinsFound]);
            stage.gemsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_gems", ["" + totalGemsFound]);
            stage.totalFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_total", ["" + _local_2]);
        }
        function updateGemStatus() {
            totalGemsFound = 0;
            var _local_6 = 0;
            while (_local_6 < GEM_NUM_HIDDEN) {
                var _local_5 = gemLocations[_local_6][0];
                var _local_4 = gemLocations[_local_6][1];
                var _local_3;
                if ((((playerDigMap[_local_5][_local_4] == 2) || (playerDigMap[_local_5 + 1][_local_4] == 2)) || (playerDigMap[_local_5][_local_4 + 1] == 2)) || (playerDigMap[_local_5 + 1][_local_4 + 1] == 2)) {
                    var _local_2 = stage.placer.gems[(("mapsquare" + _local_5) + _local_4) + "_mc"];
                    switch (treasureMap[_local_5][_local_4]) {
                        case TREASURE_GEM : 
                            _local_2.gotoAndStop("gem");
                            break;
                        case TREASURE_GEM_PIECE :  
                            _local_2.gotoAndStop("gemspace");
                            break;
                        case TREASURE_GEM_RARE : 
                            _local_2.gotoAndStop("gemrare");
                            break;
                        case TREX_PINK_EGG : 
                            _local_2.gotoAndStop("trex_purple");
                            _local_3 = "trex_purple";
                            break;
                        case TREX_RED_EGG : 
                            _local_2.gotoAndStop("trex_red");
                            _local_3 = "trex_red";
                            break;
                        case TREX_TURQUOISE_EGG : 
                            _local_2.gotoAndStop("trex_green");
                            _local_3 = "trex_green";
                            break;
                        case TREX_YELLOW_EGG : 
                            _local_2.gotoAndStop("trex_yellow");
                            _local_3 = "trex_yellow";
                            break;
                        case TRICERATOPS_BROWN_EGG : 
                            _local_2.gotoAndStop("tri_black");
                            _local_3 = "tri_black";
                            break;
                        case TRICERATOPS_PURPLE_EGG : 
                            _local_2.gotoAndStop("tri_purple");
                            _local_3 = "tri_purple";
                            break;
                        case TRICERATOPS_TURQUOISE_EGG : 
                            _local_2.gotoAndStop("tri_green");
                            _local_3 = "tri_green";
                            break;
                        case TRICERATOPS_YELLOW_EGG : 
                            _local_2.gotoAndStop("tri_yellow");
                            _local_3 = "tri_yellow";
                            break;
                        case PTERANODON_BLUE_EGG : 
                            _local_2.gotoAndStop("pt_blue");
                            _local_3 = "pt_blue";
                            break;
                        case PTERANODON_GREEN_EGG : 
                            _local_2.gotoAndStop("pt_green");
                            _local_3 = "pt_green";
                            break;
                        case PTERANODON_ORANGE_EGG : 
                            _local_2.gotoAndStop("pt_orange");
                            _local_3 = "pt_orange";
                            break;
                        case PTERANODON_PINK_EGG : 
                            _local_2.gotoAndStop("pt_pink");
                            _local_3 = "pt_pink";
                            break;
						case STEGOSAURUS_BLUE_EGG : 
                            _local_2.gotoAndStop("st_blue");
                            _local_3 = "st_blue";
                            break;
						case STEGOSAURUS_GREEN_EGG : 
                            _local_2.gotoAndStop("st_green");
                            _local_3 = "st_green";
                            break;
						case STEGOSAURUS_PURPLE_EGG : 
                            _local_2.gotoAndStop("st_purple");
                            _local_3 = "st_purple";
                            break;
						case STEGOSAURUS_YELLOW_EGG : 
                            _local_2.gotoAndStop("st_yellow");
                            _local_3 = "st_yellow";
                            break;
						case RAPTOR_BLACK_EGG : 
                            _local_2.gotoAndStop("ra_black");
                            _local_3 = "ra_black";
                            break;
						case RAPTOR_GREEN_EGG : 
                            _local_2.gotoAndStop("ra_green");
                            _local_3 = "ra_green";
                            break;
						case RAPTOR_PINK_EGG : 
                            _local_2.gotoAndStop("ra_pink");
                            _local_3 = "ra_pink";
                            break;
						case RAPTOR_RED_EGG : 
                            _local_2.gotoAndStop("ra_red");
                            _local_3 = "ra_red";
                            break;
						case PUFFLE_TREX_BLACK_EGG : 
                            _local_2.gotoAndStop("puffle_trex_black");
                            _local_3 = "puffle_trex_black";
                            break;
						case PUFFLE_TREX_PURPLE_EGG : 
                            _local_2.gotoAndStop("puffle_trex_purple");
                            _local_3 = "puffle_trex_purple";
                            break;
						case PUFFLE_TRICERATOPS_BLUE_EGG : 
                            _local_2.gotoAndStop("puffle_tri_blue");
                            _local_3 = "puffle_tri_blue";
                            break;
						case PUFFLE_TRICERATOPS_RED_EGG : 
                            _local_2.gotoAndStop("puffle_tri_red");
                            _local_3 = "puffle_tri_red";
                            break;
						case PUFFLE_STEGOSAURUS_PINK_EGG : 
                            _local_2.gotoAndStop("puffle_st_pink");
                            _local_3 = "puffle_st_pink";
                            break;
						case PUFFLE_STEGOSAURUS_YELLOW_EGG : 
                            _local_2.gotoAndStop("puffle_st_yellow");
                            _local_3 = "puffle_st_yellow";
                            break;
                    }
                }
                if (playerDigMap[_local_5][_local_4] == 2) {
                    if (playerDigMap[_local_5 + 1][_local_4] == 2) {
                        if (playerDigMap[_local_5][_local_4 + 1] == 2) {
                            if (playerDigMap[_local_5 + 1][_local_4 + 1] == 2) {
                                totalGemsFound++;
                                if (_local_3) {
                                    eggsFound.push(_local_3);
                                }
                                if (!superRareGemFound) {
                                    if (treasureMap[_local_5][_local_4] == TREASURE_GEM_RARE) {
                                        superRareGemFound = true;
                                        stage.rareGemFound.gotoAndPlay(2);
                                    }
                                }
                            }
                        }
                    }
                }
                _local_6++;
            }
        }
        function updateDigButtonStatus() {
            var _local_2 = 0;
            while (_local_2 < MAP_WIDTH) {
                if ((stage.placer[("downbutton" + _local_2) + "_mc"].active == false) || (stage.placer[("downbutton" + _local_2) + "_mc"].active == undefined)) {
                    stage.placer[("downbutton" + _local_2) + "_mc"]._visible = true;
                }
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < MAP_HEIGHT) {
                if ((stage.placer[("rightbutton" + _local_2) + "_mc"].active == false) || (stage.placer[("rightbutton" + _local_2) + "_mc"].active == undefined)) {
                    stage.placer[("rightbutton" + _local_2) + "_mc"]._visible = true;
                }
                _local_2++;
            }
            if (((currentTurn % 2) == 0) || (currentTurn == 0)) {
                _local_2 = 0;
                while (_local_2 < MAP_WIDTH) {
                    stage.placer[("downbutton" + _local_2) + "_mc"]._visible = false;
                    _local_2++;
                }
            }
            if ((currentTurn % 2) != 0) {
                _local_2 = 0;
                while (_local_2 < MAP_HEIGHT) {
                    stage.placer[("rightbutton" + _local_2) + "_mc"]._visible = false;
                    _local_2++;
                }
            }
            if (currentTurn == NUM_TURNS) {
                _local_2 = 0;
                while (_local_2 < MAP_WIDTH) {
                    stage.placer[("downbutton" + _local_2) + "_mc"]._visible = false;
                    _local_2++;
                }
                _local_2 = 0;
                while (_local_2 < MAP_HEIGHT) {
                    stage.placer[("rightbutton" + _local_2) + "_mc"]._visible = false;
                    _local_2++;
                }
            }
        }
        function refreshPlayerNames() {
            if (player1Name == "") {
                stage.player0_mc.gotoAndStop(1);
            } else {
                if (currentPlayer == 0) {
                    stage.player0_mc.gotoAndStop("Turn");
                }
                if (currentPlayer == 1) {
                    stage.player0_mc.gotoAndStop("Wait");
                }
                stage.player0_mc.name1_txt.text = player1Name.toUpperCase();
                stage.player0_mc.name2_txt.text = player1Name.toUpperCase();
            }
            if (player2Name == "") {
                stage.player1_mc.gotoAndStop(1);
            } else {
                if (currentPlayer == 0) {
                    stage.player1_mc.gotoAndStop("Wait");
                }
                if (currentPlayer == 1) {
                    stage.player1_mc.gotoAndStop("Turn");
                }
                stage.player1_mc.name1_txt.text = player2Name.toUpperCase();
                stage.player1_mc.name2_txt.text = player2Name.toUpperCase();
            }
        }
        function createDigButtonClickHandlers() {
            var _local_2;
            var _local_3 = 0;
            while (_local_3 < MAP_HEIGHT) {
                _local_2 = ("rightbutton" + _local_3) + "_mc";
                stage.placer[_local_2].digbutton.onRelease = createContextSpecificFunction(this, onDigButtonClick, _local_2, "right", _local_3);
                _local_3++;
            }
            _local_3 = 0;
            while (_local_3 < MAP_WIDTH) {
                _local_2 = ("downbutton" + _local_3) + "_mc";
                stage.placer[_local_2].digbutton.onRelease = createContextSpecificFunction(this, onDigButtonClick, _local_2, "down", _local_3);
                _local_3++;
            }
        }
        function createContextSpecificFunction(objectContext, functionToCall) {
            var _local_2 = function () {
                var _local_2 = arguments.callee;
                var _local_3 = arguments.concat(_local_2.initArgs);
                return(_local_2.handler.apply(_local_2.target, _local_3));
            };
            _local_2.target = objectContext;
            _local_2.handler = functionToCall;
            _local_2.initArgs = arguments.slice(2);
            return(_local_2);
        }
        function onDigButtonClick(buttonName, buttonDir, buttonNum, autoFill) {
            if (autoFill == undefined) {
                autoFill = false;
            }
            if ((stage.placer[buttonName].active == false) || ((stage.placer[buttonName].active == undefined) && (currentTurn < NUM_TURNS))) {
                netClient.sendDigMessage(buttonName, buttonDir, buttonNum);
                if (!autoFill) {
                    stage.placer[(("pc" + buttonNum) + "_") + buttonDir].gotoAndPlay(2);
                }
                var _local_5;
                if (buttonDir == "down") {
                    if (!autoFill) {
                        _local_5 = stage.placer[("dirtsquare0" + buttonNum) + "_mc"];
                        stage.placer.attachMovie("sanddownanim", ("sanddownanim" + currentTurn) + "_mc", 4500 + currentTurn);
                        stage.placer[("sanddownanim" + currentTurn) + "_mc"]._x = _local_5._x;
                        stage.placer[("sanddownanim" + currentTurn) + "_mc"]._y = _local_5._y;
                    }
                    var _local_4 = 0;
                    while (_local_4 < MAP_HEIGHT) {
                        _local_5 = stage.placer[(("dirtsquare" + _local_4) + buttonNum) + "_mc"];
                        _local_5.nextFrame();
                        playerDigMap[_local_4][buttonNum]++;
                        if (treasureMap[_local_4][buttonNum] != TREASURE_NONE) {
                            stage.placer[(("dirtsquare" + _local_4) + buttonNum) + "_mc"].shine._visible = true;
                        } else {
                            stage.placer[(("dirtsquare" + _local_4) + buttonNum) + "_mc"].shine._visible = false;
                        }
                        if (treasureMap[_local_4][buttonNum] == TREASURE_COIN) {
                            if (playerDigMap[_local_4][buttonNum] == 2) {
                                totalCoinsFound++;
                            }
                        }
                        _local_4++;
                    }
                }
                if (buttonDir == "right") {
                    if (!autoFill) {
                        _local_5 = stage.placer[("dirtsquare" + buttonNum) + "0_mc"];
                        stage.placer.attachMovie("sandrightanim", ("sandrightanim" + currentTurn) + "_mc", 4500 + currentTurn);
                        stage.placer[("sandrightanim" + currentTurn) + "_mc"]._x = _local_5._x;
                        stage.placer[("sandrightanim" + currentTurn) + "_mc"]._y = _local_5._y;
                    }
                    var _local_3 = 0;
                    while (_local_3 < MAP_WIDTH) {
                        _local_5 = stage.placer[(("dirtsquare" + buttonNum) + _local_3) + "_mc"];
                        _local_5.nextFrame();
                        playerDigMap[buttonNum][_local_3]++;
                        if (treasureMap[buttonNum][_local_3] != TREASURE_NONE) {
                            stage.placer[(("dirtsquare" + buttonNum) + _local_3) + "_mc"].shine._visible = true;
                        } else {
                            stage.placer[(("dirtsquare" + buttonNum) + _local_3) + "_mc"].shine._visible = false;
                        }
                        if (treasureMap[buttonNum][_local_3] == TREASURE_COIN) {
                            if (playerDigMap[buttonNum][_local_3] == 2) {
                                totalCoinsFound++;
                            }
                        }
                        _local_3++;
                    }
                }
                stage.placer[buttonName].active = true;
                stage.placer[buttonName]._visible = false;
                updateForNextTurn(buttonDir, buttonNum);
            }
        }
        function executeCallback() {
            stage.placer[(("pc" + hackyHackNumbers[hackyHack]) + "_") + hackyHackDirections[hackyHack]].gotoAndPlay(2);
            var _local_2;
            if (hackyHackDirections[hackyHack] == "down") {
                _local_2 = stage.placer[("dirtsquare0" + hackyHackNumbers[hackyHack]) + "_mc"];
                stage.placer.attachMovie("sanddownanim", ("sanddownanim" + hackyHack) + "_mc", 4500 + hackyHack);
                stage.placer[("sanddownanim" + hackyHack) + "_mc"]._x = _local_2._x;
                stage.placer[("sanddownanim" + hackyHack) + "_mc"]._y = _local_2._y;
            }
            if (hackyHackDirections[hackyHack] == "right") {
                _local_2 = stage.placer[("dirtsquare" + hackyHackNumbers[hackyHack]) + "0_mc"];
                stage.placer.attachMovie("sandrightanim", ("sandrightanim" + hackyHack) + "_mc", 4500 + hackyHack);
                stage.placer[("sandrightanim" + hackyHack) + "_mc"]._x = _local_2._x;
                stage.placer[("sandrightanim" + hackyHack) + "_mc"]._y = _local_2._y;
            }
            hackyHack++;
        }
        function showGameAborted(nickname) {
            INTERFACE.showPrompt("ok", com.clubpenguin.util.LocaleText.getTextReplaced("id_quit_game", [nickname]));
            onConfirmGameOver();
        }
        function abortGame() {
            var _local_2 = com.clubpenguin.util.Delegate.create(this, onConfirmAbortGame);
            INTERFACE.showPrompt("question", SHELL.getLocalizedString("quit_game_prompt"), "", _local_2, null);
        }
        function onConfirmAbortGame() {
            netClient.sendAbortGame();
            SHELL.sendJoinLastRoom();
        }
        function showGameOver() {
            clearInterval(netClient.gameOverDelay);
            if (eggsFound.length > 0) {
                stage.gotoAndStop("game_over_eggs");
                stage.endGame.coinsFound.text = totalCoinsFound;
                stage.endGame.eggFound.gotoAndStop(eggsFound[0]);
                stage.endGame.ok_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onConfirmGameOver);
            } else {
                stage.gotoAndStop("game_over_no_eggs");
                stage.endGame.coinsFound.text = totalCoinsFound;
                stage.endGame.ok_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onConfirmGameOver);
            }
            var _local_2 = SHELL.getMyPlayerTotalCoins();
            SHELL.setMyPlayerTotalCoins(_local_2 + Number(totalCoinsFound));
        }
        function onConfirmGameOver() {
			if (eggsFound.length > 0) {
				if (eggsFound[0] < 20) {
					_global.getCurrentParty().PrehistoricParty.checkForGarugGameDialogue("puffle");
				} else {
					_global.getCurrentParty().PrehistoricParty.checkForGarugGameDialogue("transform");
				};
			};
            SHELL.sendJoinLastRoom();
        }
        static var TREASURE_NONE = 0;
        static var TREASURE_COIN = 1;
        static var TREASURE_GEM = 2;
        static var TREASURE_GEM_PIECE = 3;
        static var TREASURE_GEM_RARE = 4;
        static var TREX_PINK_EGG = 400;
        static var TREX_RED_EGG = 401;
        static var TREX_TURQUOISE_EGG = 402;
        static var TREX_YELLOW_EGG = 403;
        static var TRICERATOPS_BROWN_EGG = 404;
        static var TRICERATOPS_PURPLE_EGG = 405;
        static var TRICERATOPS_TURQUOISE_EGG = 406;
        static var TRICERATOPS_YELLOW_EGG = 407;
        static var PTERANODON_BLUE_EGG = 408;
        static var PTERANODON_GREEN_EGG = 409;
        static var PTERANODON_ORANGE_EGG = 410;
        static var PTERANODON_PINK_EGG = 411;
        static var STEGOSAURUS_BLUE_EGG = 412;
        static var STEGOSAURUS_GREEN_EGG = 413;
        static var STEGOSAURUS_PURPLE_EGG = 414;
        static var STEGOSAURUS_YELLOW_EGG = 415;
        static var RAPTOR_BLACK_EGG = 416;
        static var RAPTOR_GREEN_EGG = 417;
        static var RAPTOR_PINK_EGG = 418;
        static var RAPTOR_RED_EGG = 419;
        static var PUFFLE_TREX_BLACK_EGG = 11;
        static var PUFFLE_TREX_PURPLE_EGG = 14;
        static var PUFFLE_TRICERATOPS_BLUE_EGG = 10;
        static var PUFFLE_TRICERATOPS_RED_EGG = 13;
        static var PUFFLE_STEGOSAURUS_PINK_EGG = 12;
        static var PUFFLE_STEGOSAURUS_YELLOW_EGG = 15;
        static var SPECTATOR = -1;
        static var PLAYER_1 = 0;
        static var PLAYER_2 = 1;
        static var MAP_WIDTH = 10;
        static var MAP_HEIGHT = 10;
        static var TILE_WIDTH = 21;
        static var TILE_HEIGHT = 21;
        static var BORDER_SIZE = 10;
        static var COIN_NUM_HIDDEN = 34;
        static var GEM_NUM_HIDDEN = 3;
        static var GEM_VALUE = 25;
        static var COIN_VALUE = 1;
        static var NUM_TURNS = 12;
        var netPlayerID = SPECTATOR;
        var totalCoinsFound = 0;
        var totalGemsFound = 0;
        var currentPlayer = 0;
        var currentTurn = 0;
        var player1Name = "";
        var player2Name = "";
    }
