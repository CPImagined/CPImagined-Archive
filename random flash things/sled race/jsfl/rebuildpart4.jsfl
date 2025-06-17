var doc=fl.getDocumentDOM();
var tl=doc.getTimeline();
var lib=doc.library;
var newSel=new Array();
var si,li,ci,pi,tx,r0,nr,cx,cy,el,sm;

//create main timeline
tl=doc.getTimeline();
tl.setSelectedLayers(0);
tl.insertFrames(1);
tl.layers[0].name="L1";
lib.addItemToDocument({x:0, y:0},"Symbol_84");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.selectNone();
tl.convertToBlankKeyframes(1);
tl.layers[0].locked=true;
tl.addNewLayer();
tl.setSelectedFrames([0,1,1],true);
tl.layers[0].name="L2";
lib.addItemToDocument({x:0, y:0},"Symbol_231");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.moveSelectionBy({x:80, y:40});
newSel[0].name="game";
doc.selectNone();
tl.convertToBlankKeyframes(1);
tl.layers[0].locked=true;
tl.addNewLayer();
tl.setSelectedFrames([0,1,1],true);
tl.layers[0].name="L3";
lib.addItemToDocument({x:0, y:0},"Symbol_249");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.moveSelectionBy({x:380, y:301});
newSel[0].name="messages_mc";
doc.selectNone();
tl.convertToBlankKeyframes(1);
tl.layers[0].locked=true;
tl.addNewLayer();
tl.setSelectedFrames([0,1,1],true);
tl.layers[0].name="L4";
lib.addItemToDocument({x:0, y:0},"Symbol_257");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.moveSelectionBy({x:393.15, y:25.95});
newSel[0].name="progress_mc";
doc.selectNone();
tl.convertToBlankKeyframes(1);
tl.layers[0].locked=true;
tl.addNewLayer();
tl.setSelectedFrames([0,1,1],true);
tl.layers[0].name="L5";
lib.addItemToDocument({x:0, y:0},"Symbol_261");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
newSel[0].buttonTracking="button";
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
newSel[0].actionScript=
"on (release) {\n"+
"    exitGame();\n"+
"}\n";
doc.moveSelectionBy({x:729, y:26});
doc.selectNone();
tl.convertToBlankKeyframes(1);
tl.layers[0].locked=false;
tl.layers[1].locked=false;
tl.layers[2].locked=false;
tl.layers[3].locked=false;
tl.layers[4].locked=false;
tl.addNewLayer();
tl.layers[0].name="actions";
tl.setSelectedFrames([0,0,0],true);
tl.layers[0].frames[0].actionScript=
"    function addListeners() {\n"+
"        AIRTOWER.addListener(\"uz\", handleUpdateGame);\n"+
"        AIRTOWER.addListener(\"zm\", handleSendMove);\n"+
"        trace(\"added listeners\");\n"+
"    }\n"+
"    function removeListeners() {\n"+
"        AIRTOWER.removeListener(\"uz\", handleUpdateGame);\n"+
"        AIRTOWER.removeListener(\"zm\", handleSendMove);\n"+
"    }\n"+
"    function startGame() {\n"+
"        trace(\"SLED:startGame\");\n"+
"        LAST_ROOM_ID = SHELL.getLastRoomId();\n"+
"        messages_mc.gotoAndStop(\"Wait\");\n"+
"        speed = 0;\n"+
"        maxSpeed = 20;\n"+
"        boostSpeed = 60;\n"+
"        turnSpeed = 20;\n"+
"        gravity = 2;\n"+
"        decay = 0.95;\n"+
"        crashDecay = 0.9;\n"+
"        finishDecay = 0.75;\n"+
"        currentx = 0;\n"+
"        hazardCounter = 0;\n"+
"        currentTime = 0;\n"+
"        startTime = 0;\n"+
"        gameTime = 0;\n"+
"        isLobby = true;\n"+
"        isGameOver = false;\n"+
"        hillMax = 18000;\n"+
"        mySpeed = new Array();\n"+
"        var speed = boostSpeed;\n"+
"        var _local_1 = 0;\n"+
"        while (_local_1 < boostSpeed) {\n"+
"            speed = speed * decay;\n"+
"            mySpeed.push(speed);\n"+
"            _local_1++;\n"+
"        }\n"+
"        myGame = new Object();\n"+
"        myGame.playerId = undefined;\n"+
"        myGame.gameMaster = undefined;\n"+
"        myGame.maxPlayers = MAX_PLAYERS;\n"+
"        myGame.numPlayers = 0;\n"+
"        myGame.mode = \"wait\";\n"+
"        myGame.isReady = false;\n"+
"        myGame.playerlist = new Array();\n"+
"        _local_1 = 0;\n"+
"        while (_local_1 < myGame.maxPlayers) {\n"+
"            myGame.playerlist[_local_1] = new Object();\n"+
"            myGame.playerlist[_local_1].name = undefined;\n"+
"            myGame.playerlist[_local_1].colour = 0;\n"+
"            myGame.playerlist[_local_1].sled = 1;\n"+
"            myGame.playerlist[_local_1].isReady = false;\n"+
"            myGame.playerlist[_local_1].isFinished = false;\n"+
"            myGame.playerlist[_local_1].isStopped = false;\n"+
"            myGame.playerlist[_local_1].isCrashed = false;\n"+
"            myGame.playerlist[_local_1].isJumping = false;\n"+
"            myGame.playerlist[_local_1].s = 0;\n"+
"            myGame.playerlist[_local_1].h = 0;\n"+
"            myGame.playerlist[_local_1].m = 0;\n"+
"            myGame.playerlist[_local_1].x = 0;\n"+
"            myGame.playerlist[_local_1].x2 = 0;\n"+
"            myGame.playerlist[_local_1].y = 0;\n"+
"            _local_1++;\n"+
"        }\n"+
"        myGame.playerlist[0].x = 160;\n"+
"        myGame.playerlist[1].x = 120;\n"+
"        myGame.playerlist[2].x = 80;\n"+
"        myGame.playerlist[3].x = 40;\n"+
"        myGame.opponentlist = new Array();\n"+
"        myGame.finishlist = new Array();\n"+
"        _local_1 = 0;\n"+
"        while (_local_1 < 4) {\n"+
"            addTile(currentTile);\n"+
"            currentTile++;\n"+
"            _local_1++;\n"+
"        }\n"+
"        AIRTOWER.send(\"z\", \"jz\", \"\", \"str\", ROOM_ID);\n"+
"        SHELL.stopMusic();\n"+
"        SHELL.startMusicById(117);\n"+
"    }\n"+
"    function handleUpdateGame(ob) {\n"+
"        var _local_8 = Number(ob.shift());\n"+
"        myGame.maxPlayers = Number(ob.shift());\n"+
"        trace(\"myGame.maxPlayers:\" + myGame.maxPlayers);\n"+
"        myGame.numPlayers = 0;\n"+
"        for (var _local_7 in ob) {\n"+
"            var _local_1 = ob[_local_7].split(\"|\");\n"+
"            var _local_3 = _local_1[0];\n"+
"            var _local_5 = Number(_local_1[1]);\n"+
"            var _local_2;\n"+
"            var _local_4 = _local_1[3];\n"+
"            if (_local_1[2] == 5021) {\n"+
"                _local_2 = 2;\n"+
"            } else if (_local_1[2] == 5046) {\n"+
"                _local_2 = 3;\n"+
"            } else if (_local_1[2] == 5047) {\n"+
"                _local_2 = 4;\n"+
"            } else {\n"+
"                _local_2 = 1;\n"+
"            }\n"+
"            trace(((\"Adding nickname to \" + myGame.playerlist[_local_7]) + \" as \") + _local_3);\n"+
"            myGame.playerlist[_local_7].name = _local_3;\n"+
"            myGame.playerlist[_local_7].colour = _local_5;\n"+
"            myGame.playerlist[_local_7].sled = _local_2;\n"+
"            if (String(SHELL.getMyPlayerUsername()).toUpperCase() == String(_local_4).toUpperCase()) {\n"+
"                myGame.myPlayer = myGame.playerlist[_local_7];\n"+
"                myPlayer = myGame.myPlayer;\n"+
"                myGame.myPlayer.isReady = true;\n"+
"                myGame.playerId = _local_7;\n"+
"                myPlayer.playerID = _local_7;\n"+
"            }\n"+
"            myGame.numPlayers++;\n"+
"            trace(\"NUM PLAYERS PLUS PLUS  \" + myGame.numPlayers);\n"+
"        }\n"+
"        updatePlayerList();\n"+
"    }\n"+
"    function addTile(n) {\n"+
"        trace(\"addTile:\" + n);\n"+
"        var _local_2 = myHill[n];\n"+
"        game.hill.attachMovie(\"t\" + _local_2, \"tile\" + n, n + 1);\n"+
"        var _local_3 = game.hill[\"tile\" + n];\n"+
"        trace(\"mcTile:\" + _local_3);\n"+
"        _local_3._x = n * 200;\n"+
"        _local_3._y = (n * 200) * 0.6;\n"+
"        if (_local_2 == 99) {\n"+
"            game.hill.attachMovie(\"t100\", \"finish\", n + 2000);\n"+
"            _local_3 = game.hill.finish;\n"+
"            _local_3._x = n * 200;\n"+
"            _local_3._y = (n * 200) * 0.6;\n"+
"        }\n"+
"    }\n"+
"    function removeTile(n) {\n"+
"        var _local_1 = game.hill[\"tile\" + n];\n"+
"        _local_1.removeMovieClip();\n"+
"    }\n"+
"    function updatePlayerList() {\n"+
"        trace(\"Update Player List\");\n"+
"        updateArtwork();\n"+
"        if (!myGame.isReady) {\n"+
"            if (myGame.NumPlayers == myGame.MaxPlayers) {\n"+
"                trace(\"*** START OUR ENGINES ***\");\n"+
"                myGame.isReady = true;\n"+
"                messages_mc.gotoAndStop(1);\n"+
"                messages_mc.gotoAndPlay(\"Ready\");\n"+
"            } else {\n"+
"                trace(\"*** NEED MORE PLAYERS ***\");\n"+
"            }\n"+
"        }\n"+
"    }\n"+
"    function updateArtwork() {\n"+
"        trace(\"Update Artwork\");\n"+
"        for (var _local_3 in myGame.playerlist) {\n"+
"            trace(\"Update for player: \" + Number(_local_3));\n"+
"            var _local_3 = Number(_local_3);\n"+
"            var _local_1 = myGame.playerlist[_local_3];\n"+
"            if (_local_1.name != undefined) {\n"+
"                if (_local_1.y < 0) {\n"+
"                    _local_1.y = 0;\n"+
"                }\n"+
"                var _local_2 = game.hill[\"player\" + _local_3];\n"+
"                _local_2.gotoAndStop(_local_1.sled);\n"+
"                _local_2.art.name_txt.text = _local_1.name;\n"+
"                _local_2._x = _local_1.y + _local_1.x;\n"+
"                _local_2._y = (_local_1.y * 0.6) - (_local_1.x * 0.6);\n"+
"                _local_2.swapDepths(_local_3 + 1000);\n"+
"                updateColour(_local_2, _local_1.colour);\n"+
"                progress_mc[\"player\" + _local_3]._visible = true;\n"+
"                progress_mc[\"player\" + _local_3]._y = 0;\n"+
"                trace(((\"SSSSSPLAYER NAME IS: \" + _local_1.name) + \" \") + _local_3);\n"+
"                trace(((\"SSSSSmPlayer NAME IS: \" + myPlayer.name) + \" \") + _local_3);\n"+
"                if (_local_1.name == myPlayer.name) {\n"+
"                    trace(\"INSIDE IF STATEMENT FOR NAME TO STAR \" + _local_3);\n"+
"                    trace(((\"PLAYER NAME IS: \" + _local_1.name) + \" \") + _local_3);\n"+
"                    trace(((\"mPlayer NAME IS: \" + myPlayer.name) + \" \") + _local_3);\n"+
"                    trace(\"CHANGING TO STAR \" + _local_3);\n"+
"                    trace(\"MYGAME.PLAYER ID  = \" + myPlayer.playerID);\n"+
"                    if (_local_3 != myPlayer.playerID) {\n"+
"                        return(undefined);\n"+
"                    }\n"+
"                    progress_mc[\"player\" + _local_3].gotoAndStop(2);\n"+
"                    progress_mc[\"player\" + _local_3].swapDepths(100);\n"+
"                } else {\n"+
"                    trace(\"NOT SAME NAME, NO STAR\");\n"+
"                }\n"+
"            }\n"+
"        }\n"+
"    }\n"+
"    function updateColour(mc, colour) {\n"+
"        var _local_1 = new Color(mc.art.body);\n"+
"        _local_1.setRGB(SHELL.getPlayerHexFromId(colour));\n"+
"    }\n"+
"    function handleStartGame() {\n"+
"        trace(\"handleStartGame\");\n"+
"        myKey = new Object();\n"+
"        myKey.onKeyDown = function () {\n"+
"            if (!myPlayer.isCrashed) {\n"+
"                if (!myPlayer.isJumping) {\n"+
"                    if (Key.isDown(39)) {\n"+
"                        myPlayer.x = myPlayer.x + turnSpeed;\n"+
"                    } else if (Key.isDown(38)) {\n"+
"                        myPlayer.x = myPlayer.x + turnSpeed;\n"+
"                    } else if (Key.isDown(37)) {\n"+
"                        myPlayer.x = myPlayer.x - turnSpeed;\n"+
"                    } else if (Key.isDown(40)) {\n"+
"                        myPlayer.x = myPlayer.x - turnSpeed;\n"+
"                    }\n"+
"                    if (myPlayer.x > 180) {\n"+
"                        myPlayer.x = 180;\n"+
"                    } else if (myPlayer.x < 0) {\n"+
"                        myPlayer.x = 0;\n"+
"                    }\n"+
"                    if (currentx != myPlayer.x) {\n"+
"                        currentx = myPlayer.x;\n"+
"                        sendMove();\n"+
"                    }\n"+
"                }\n"+
"            }\n"+
"        };\n"+
"        Key.addListener(myKey);\n"+
"        startTime = getTimer();\n"+
"        lastTime = startTime;\n"+
"        game.onEnterFrame = function () {\n"+
"            currentTime = getTimer();\n"+
"            gameTime = currentTime - startTime;\n"+
"            for (var _local_1 in myGame.playerlist) {\n"+
"                movePlayer(_local_1);\n"+
"            }\n"+
"            game.hill._x = 100 - myPlayer.y;\n"+
"            game.hill._y = 200 - (myPlayer.y * 0.6);\n"+
"            game.background._x = (-myPlayer.y) / 25;\n"+
"            tiley = Math.round(myPlayer.y / 200);\n"+
"            trace(\"lastTiley:\" + lastTiley);\n"+
"            trace(\"tiley:\" + tiley);\n"+
"            if (lastTiley == undefined) {\n"+
"                lastTiley = 0;\n"+
"            }\n"+
"            if (lastTiley < tiley) {\n"+
"                lastTiley = tiley;\n"+
"                addTile(currentTile);\n"+
"                removeTile(currentTile - 6);\n"+
"                currentTile++;\n"+
"            }\n"+
"            lastTime = currentTime;\n"+
"            updateScore();\n"+
"        };\n"+
"    }\n"+
"    function movePlayer(n) {\n"+
"        trace(\"move player \" + n);\n"+
"        var _local_1 = myGame.playerlist[n];\n"+
"        var _local_3 = game.hill[\"player\" + n];\n"+
"        var _local_2 = _local_1.s;\n"+
"        if (_local_1.isFinished) {\n"+
"            _local_2 = _local_2 * finishDecay;\n"+
"            if (_local_2 < 1) {\n"+
"                if (myPlayer.name == _local_1.name) {\n"+
"                    if (!_local_1.isStopped) {\n"+
"                        gameOver();\n"+
"                    }\n"+
"                }\n"+
"                _local_1.isStopped = true;\n"+
"                _local_2 = 0;\n"+
"            }\n"+
"        } else if (_local_1.isCrashed) {\n"+
"            _local_2 = _local_2 * crashDecay;\n"+
"            if (_local_2 < 1) {\n"+
"                _local_1.isCrashed = false;\n"+
"                _local_3.art.gotoAndStop(1);\n"+
"                updateColour(_local_3, _local_1.colour);\n"+
"                _local_2 = 0;\n"+
"            }\n"+
"        } else if (_local_2 < maxSpeed) {\n"+
"            _local_2 = _local_2 + gravity;\n"+
"            if (_local_2 > maxSpeed) {\n"+
"                _local_2 = maxSpeed;\n"+
"            }\n"+
"        } else if (_local_2 > maxSpeed) {\n"+
"            _local_2 = _local_2 * decay;\n"+
"            if (_local_2 < maxSpeed) {\n"+
"                _local_2 = maxSpeed;\n"+
"            }\n"+
"        } else {\n"+
"            _local_2 = maxSpeed;\n"+
"        }\n"+
"        if (!_local_1.isStopped) {\n"+
"            move = ((currentTime - lastTime) / 40) * _local_2;\n"+
"            _local_1.s = _local_2;\n"+
"            _local_1.y = Math.round(_local_1.y + move);\n"+
"            var _local_9 = Math.round(_local_1.x / 20);\n"+
"            var _local_8 = Math.round(_local_1.y / 20);\n"+
"            var _local_4 = myMap[_local_8][_local_9] * 10;\n"+
"            var _local_5 = _local_1.h;\n"+
"            var _local_7 = _local_1.m;\n"+
"            if (_local_1.y > hillMax) {\n"+
"                trace(\"PLAYER HIT HILL MAX\");\n"+
"            }\n"+
"            trace(\"TH is: \" + _local_4);\n"+
"            if (_local_4 > 90) {\n"+
"                if (_local_4 == 100) {\n"+
"                    trace(\"**** FINISH LINE ****\");\n"+
"                    trace(_local_1.y);\n"+
"                    if (myPlayer.name == _local_1.name) {\n"+
"                        if (!_local_1.isFinished) {\n"+
"                            trace(\"Sending Finish......\");\n"+
"                            sendFinished();\n"+
"                        }\n"+
"                    }\n"+
"                    if (!_local_1.isFinished) {\n"+
"                        myGame.finishlist.push(_local_1.name);\n"+
"                        trace(\"IS FINISED IS TRUE 1\");\n"+
"                        _local_1.isFinished = true;\n"+
"                    }\n"+
"                } else if (_local_4 == 110) {\n"+
"                    if (myPlayer.name == _local_1.name) {\n"+
"                        if (!_local_1.isCrashed) {\n"+
"                            trace(\"**** CRASH ****\");\n"+
"                            _local_1.s = maxSpeed;\n"+
"                            _local_1.isCrashed = true;\n"+
"                            _local_3.art.gotoAndStop(5);\n"+
"                            updateColour(_local_3, _local_1.colour);\n"+
"                            sendCrash();\n"+
"                        }\n"+
"                    }\n"+
"                } else if (_local_4 == 120) {\n"+
"                    if (myPlayer.name == _local_1.name) {\n"+
"                        myPlayer.s = boostSpeed;\n"+
"                        sendSpeed();\n"+
"                    }\n"+
"                } else if (_local_4 == 130) {\n"+
"                    if (myPlayer.name == _local_1.name) {\n"+
"                        myPlayer.s = 10;\n"+
"                        sendSpeed();\n"+
"                        _local_5 = 10;\n"+
"                    }\n"+
"                }\n"+
"                _local_4 = _local_5;\n"+
"            } else if (_local_5 > _local_4) {\n"+
"                if (myPlayer.name == _local_1.name) {\n"+
"                    if (!_local_1.isJumping) {\n"+
"                        sendJump();\n"+
"                    }\n"+
"                }\n"+
"                _local_1.isJumping = true;\n"+
"                _local_7 = _local_7 + gravity;\n"+
"                _local_5 = _local_5 - _local_7;\n"+
"            } else {\n"+
"                _local_1.isJumping = false;\n"+
"                _local_7 = 0;\n"+
"                _local_5 = _local_4;\n"+
"            }\n"+
"            _local_1.h = _local_5;\n"+
"            _local_1.m = _local_7;\n"+
"            if (!_local_1.isCrashed) {\n"+
"                if (_local_1.x < _local_1.x2) {\n"+
"                    _local_3.art.gotoAndStop(3);\n"+
"                    updateColour(_local_3, _local_1.colour);\n"+
"                } else if (_local_1.x > _local_1.x2) {\n"+
"                    _local_3.art.gotoAndStop(2);\n"+
"                    updateColour(_local_3, _local_1.colour);\n"+
"                } else if (_local_1.isJumping) {\n"+
"                    _local_3.art.gotoAndStop(4);\n"+
"                    updateColour(_local_3, _local_1.colour);\n"+
"                } else {\n"+
"                    _local_3.art.gotoAndStop(1);\n"+
"                    updateColour(_local_3, _local_1.colour);\n"+
"                }\n"+
"            }\n"+
"            _local_1.x2 = _local_1.x;\n"+
"            _local_3._x = _local_1.y + _local_1.x;\n"+
"            _local_3._y = (_local_1.y * 0.6) - (_local_1.x * 0.6);\n"+
"            _local_3.art._y = -_local_5;\n"+
"            _local_3.shadow._y = -_local_4;\n"+
"            _local_3.swapDepths(((_local_8 * 10) + n) + 1000);\n"+
"            trace(\"SHELL LAST ROOM ID IS: \" + LAST_ROOM_ID);\n"+
"            if (LAST_ROOM_ID == PARTY_ROOM_ID) {\n"+
"                trace(\"HIULL LENGTH :  \" + myHill.length);\n"+
"                trace(\"Current tile :  \" + currentTile);\n"+
"                progress_mc[\"player\" + n]._x = (_local_1.y / 1500) * (myMap.length / 300);\n"+
"                trace(((\"Player \" + n) + \" PLAYER Y : \") + progress_mc[\"player\" + n]._x);\n"+
"                trace(\"MY MAP LENGTH : \" + (myMap.length / 300));\n"+
"                trace(\"Update progress bar: \" + progress_mc[\"player\" + n]._x);\n"+
"            } else {\n"+
"                progress_mc[\"player\" + n]._x = (_local_1.y / 180) * (myMap.length / 300);\n"+
"            }\n"+
"        }\n"+
"    }\n"+
"    function gameOver() {\n"+
"        closeGame();\n"+
"        var _local_1 = 0;\n"+
"        while (_local_1 < myGame.finishlist.length) {\n"+
"            trace(\"FINISHLIST\" + myGame.finishlist[_local_1]);\n"+
"            if (myGame.finishlist[_local_1] == myPlayer.name) {\n"+
"                var _local_2 = _local_1;\n"+
"                break;\n"+
"            }\n"+
"            _local_1++;\n"+
"        }\n"+
"        trace(\"PLACE\" + myGame.finishlist[_local_1]);\n"+
"        if (_local_2 == 0) {\n"+
"            var _local_3 = 1;\n"+
"        } else if (_local_2 == 1) {\n"+
"            var _local_3 = 2;\n"+
"        } else if (_local_2 == 2) {\n"+
"            var _local_3 = 3;\n"+
"        } else if (_local_2 == 3) {\n"+
"            var _local_3 = 4;\n"+
"        }\n"+
"        if (LAST_ROOM_ID == PARTY_ROOM_ID) {\n"+
"            ENGINE.sendGameOver(_local_3, \"party1\");\n"+
"        } else {\n"+
"            SHELL.sendGameOver(_local_3);\n"+
"        }\n"+
"    }\n"+
"    function exitGame() {\n"+
"        var _local_1 = SHELL.getLocalizedString(\"quit_game_prompt\");\n"+
"        INTERFACE.showPrompt(\"question\", _local_1, undefined, confimExitGame);\n"+
"    }\n"+
"    function confimExitGame() {\n"+
"        closeGame();\n"+
"        SHELL.sendJoinLastRoom();\n"+
"    }\n"+
"    function closeGame() {\n"+
"        trace(\"closeGame\");\n"+
"        Key.removeListener(myKey);\n"+
"        removeListeners();\n"+
"    }\n"+
"    function sendMove() {\n"+
"        var _local_3 = myGame.playerId;\n"+
"        var _local_2 = myPlayer.x + 100;\n"+
"        var _local_4 = myPlayer.y;\n"+
"        var _local_1 = gameTime;\n"+
"        AIRTOWER.send(\"z\", \"zm\", [_local_3, _local_2, _local_4, _local_1], \"str\", ROOM_ID);\n"+
"    }\n"+
"    function sendSpeed() {\n"+
"        trace(\"sendSpeed()\");\n"+
"        var _local_3 = myGame.playerId;\n"+
"        var _local_2 = myPlayer.s + 400;\n"+
"        var _local_4 = myPlayer.y;\n"+
"        var _local_1 = gameTime;\n"+
"        AIRTOWER.send(\"z\", \"zm\", [_local_3, _local_2, _local_4, _local_1], \"str\", ROOM_ID);\n"+
"    }\n"+
"    function sendJump() {\n"+
"        var _local_3 = myGame.playerId;\n"+
"        var _local_2 = 2;\n"+
"        var _local_4 = myPlayer.y;\n"+
"        var _local_1 = gameTime;\n"+
"        AIRTOWER.send(\"z\", \"zm\", [_local_3, _local_2, _local_4, _local_1], \"str\", ROOM_ID);\n"+
"    }\n"+
"    function sendCrash() {\n"+
"        var _local_3 = myGame.playerId;\n"+
"        var _local_2 = 1;\n"+
"        var _local_4 = myPlayer.y;\n"+
"        var _local_1 = gameTime;\n"+
"        AIRTOWER.send(\"z\", \"zm\", [_local_3, _local_2, _local_4, _local_1], \"str\", ROOM_ID);\n"+
"    }\n"+
"    function sendFinished() {\n"+
"        var _local_3 = myGame.playerId;\n"+
"        var _local_2 = 0;\n"+
"        var _local_4 = myPlayer.y;\n"+
"        var _local_1 = gameTime;\n"+
"        AIRTOWER.send(\"z\", \"zm\", [_local_3, _local_2, _local_4, _local_1], \"str\", ROOM_ID);\n"+
"    }\n"+
"    function handleSendMove(ob) {\n"+
"        var _local_9 = Number(ob[0]);\n"+
"        var _local_5 = Number(ob[1]);\n"+
"        var _local_3 = Number(ob[2]);\n"+
"        var _local_2 = Number(ob[3]);\n"+
"        var _local_8 = Number(ob[4]);\n"+
"        if (_local_5 != myGame.playerId) {\n"+
"            currentTime = getTimer();\n"+
"            var _local_1 = myGame.playerlist[_local_5];\n"+
"            var _local_7 = (gameTime - _local_8) * 0.024;\n"+
"            _local_2 = _local_2 + (_local_7 * maxSpeed);\n"+
"            if (_local_3 == 0) {\n"+
"                if (!_local_1.isFinished) {\n"+
"                    myGame.finishlist.push(_local_1.name);\n"+
"                    trace(\"IS FINISED IS TRUE 2\");\n"+
"                    _local_1.isFinished = true;\n"+
"                    _local_1.y = _local_2;\n"+
"                }\n"+
"            } else if (_local_3 == 1) {\n"+
"                var _local_6 = game.hill[\"player\" + _local_5];\n"+
"                _local_1.s = maxSpeed;\n"+
"                _local_1.y = _local_2;\n"+
"                _local_1.isCrashed = true;\n"+
"                _local_6.art.gotoAndStop(5);\n"+
"                updateColour(_local_6, _local_1.colour);\n"+
"            } else if (_local_3 == 2) {\n"+
"                _local_1.y = _local_2;\n"+
"            } else if (_local_3 < 400) {\n"+
"                _local_1.x = _local_3 - 100;\n"+
"                _local_1.y = _local_2;\n"+
"            } else {\n"+
"                _local_1.s = mySpeed[_local_7];\n"+
"                _local_1.y = _local_2;\n"+
"            }\n"+
"        }\n"+
"    }\n"+
"    var SHELL = _global.getCurrentShell();\n"+
"    SHELL.hideLoading();\n"+
"    SHELL.startGameMusic();\n"+
"    var AIRTOWER = _global.getCurrentAirtower();\n"+
"    var INTERFACE = _global.getCurrentInterface();\n"+
"    var ENGINE = _global.getCurrentEngine();\n"+
"    var SHELL = _global.getCurrentShell();\n"+
"    trace(\"sled begins\");\n"+
"    trace(\"tiles begin\");\n"+
"    myHillTile = new Array();\n"+
"    myHillTile[0] = new Object();\n"+
"    myHillTile[0].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[1] = new Object();\n"+
"    myHillTile[1].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, -1, -1, -1, -1, -1, -1, -1], [0, 0, 0, -1, -2, -3, -3, -3, -3, -3], [0, 0, 0, -1, -2, -3, -3, -3, -3, -3], [0, 0, 0, -1, -2, -2, -2, -2, -2, -2], [0, 0, 0, -1, -1, -1, -1, -1, -1, -1], [0, 0, 0, -1, -1, -1, -1, -1, -1, -1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[2] = new Object();\n"+
"    myHillTile[2].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 4, 4, 4, 4, 4, 4, 4, 4], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[3] = new Object();\n"+
"    myHillTile[3].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 1, 1, 1, 1], [0, 0, 0, 0, 0, 2, 2, 2, 2, 2], [0, 0, 0, 0, 0, 3, 3, 3, 3, 3], [0, 0, 0, 0, 0, 4, 4, 4, 4, 4], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[4] = new Object();\n"+
"    myHillTile[4].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0], [2, 2, 2, 2, 2, 0, 0, 0, 0, 0], [3, 3, 3, 3, 3, 0, 0, 0, 0, 0], [4, 4, 4, 4, 4, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[5] = new Object();\n"+
"    myHillTile[5].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 1, 1, 1, 1, 1, 0, 0], [0, 0, 0, 2, 2, 2, 2, 2, 0, 0], [11, 11, 11, 3, 3, 3, 3, 3, 11, 11], [11, 11, 11, 4, 4, 4, 4, 4, 11, 11], [11, 11, 11, 0, 0, 0, 0, 0, 11, 11], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[6] = new Object();\n"+
"    myHillTile[6].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 1, 1, 1], [0, 0, 0, 0, 0, 0, 2, 2, 2, 2], [11, 11, 11, 11, 11, 11, 3, 3, 3, 3], [11, 11, 11, 11, 11, 11, 4, 4, 4, 4], [11, 11, 11, 11, 11, 11, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[7] = new Object();\n"+
"    myHillTile[7].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0], [2, 2, 2, 2, 2, 0, 0, 0, 0, 0], [3, 3, 3, 3, 3, 11, 11, 11, 11, 11], [4, 4, 4, 4, 4, 11, 11, 11, 11, 11], [0, 0, 0, 0, 0, 11, 11, 11, 11, 11], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[8] = new Object();\n"+
"    myHillTile[8].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[9] = new Object();\n"+
"    myHillTile[9].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[10] = new Object();\n"+
"    myHillTile[10].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[11] = new Object();\n"+
"    myHillTile[11].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 1, 1, 1, 1], [2, 2, 2, 2, 2, 0, 2, 2, 2, 2], [3, 3, 3, 3, 3, 11, 3, 3, 3, 3], [4, 4, 4, 4, 4, 11, 4, 4, 4, 4], [0, 0, 0, 0, 0, 11, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[12] = new Object();\n"+
"    myHillTile[12].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[13] = new Object();\n"+
"    myHillTile[13].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 11, 11, 0, 0, 0], [0, 0, 0, 0, 0, 11, 11, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[14] = new Object();\n"+
"    myHillTile[14].map = new Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 5, 5, 5, 5, 5, 5, 5, 5, 5], [6, 6, 6, 6, 6, 6, 6, 6, 6, 6], [7, 7, 7, 7, 7, 7, 7, 7, 7, 7], [8, 8, 8, 8, 8, 8, 8, 8, 8, 8], [9, 9, 9, 9, 9, 9, 9, 9, 9, 9]);\n"+
"    myHillTile[15] = new Object();\n"+
"    myHillTile[15].map = new Array([-8, -8, -8, -8, -8, -8, -8, -8, -8, -8], [-8, -8, -8, -8, -8, -8, -8, -8, -8, -8], [-7, -7, -7, -7, -7, -7, -7, -7, -7, -7], [-6, -6, -6, -6, -6, -6, -6, -6, -6, -6], [-5, -5, -5, -5, -5, -5, -5, -5, -5, -5], [-4, -4, -4, -4, -4, -4, -4, -4, -4, -4], [-3, -3, -3, -3, -3, -3, -3, -3, -3, -3], [-2, -2, -2, -2, -2, -2, -2, -2, -2, -2], [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[16] = new Object();\n"+
"    myHillTile[16].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[17] = new Object();\n"+
"    myHillTile[17].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 1, 1, 1, 0, 0], [0, 0, 0, 0, 1, 1, 1, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[18] = new Object();\n"+
"    myHillTile[18].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 1, 1, 1], [0, 0, 0, 0, 0, 0, 0, 1, 1, 1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[19] = new Object();\n"+
"    myHillTile[19].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[20] = new Object();\n"+
"    myHillTile[20].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[21] = new Object();\n"+
"    myHillTile[21].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[22] = new Object();\n"+
"    myHillTile[22].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 11, 11], [0, 0, 0, 0, 0, 0, 0, 0, 11, 11], [11, 11, 11, 0, 0, 0, 0, 0, 0, 0], [11, 11, 11, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[98] = new Object();\n"+
"    myHillTile[98].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[99] = new Object();\n"+
"    myHillTile[99].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]);\n"+
"    trace(\"ENGINE.getActiveWaddleId()\" + ENGINE.getActiveWaddleId());\n"+
"    if (ENGINE.getActiveWaddleId() == 100) {\n"+
"        myHill = new Array(98, 16, 14, 15, 12, 17, 1, 0, 7, 0, 2, 9, 13, 8, 2, 0, 10, 0, 17, 5, 12, 19, 0, 17, 9, 7, 0, 5, 22, 1, 0, 13, 19, 21, 18, 9, 13, 7, 12, 5, 0, 2, 8, 0, 7, 10, 21, 6, 0, 14, 15, 9, 10, 1, 22, 1, 12, 3, 8, 5, 9, 20, 4, 10, 3, 6, 0, 1, 11, 13, 8, 0, 9, 2, 8, 22, 19, 18, 8, 5, 21, 3, 9, 5, 8, 20, 14, 15, 0, 99);\n"+
"    } else if (ENGINE.getActiveWaddleId() == 101) {\n"+
"        myHill = new Array(98, 0, 0, 19, 18, 9, 11, 10, 2, 17, 16, 9, 22, 0, 0, 5, 0, 21, 0, 8, 2, 9, 6, 0, 4, 7, 0, 17, 5, 0, 8, 9, 10, 14, 15, 0, 2, 0, 4, 0, 5, 0, 19, 19, 18, 18, 6, 0, 13, 8, 1, 4, 8, 0, 0, 2, 0, 4, 18, 5, 8, 5, 0, 1, 10, 20, 16, 2, 5, 22, 0, 11, 9, 10, 1, 5, 17, 0, 8, 13, 2, 0, 22, 17, 0, 20, 9, 0, 0, 99);\n"+
"    } else if (ENGINE.getActiveWaddleId() == 102) {\n"+
"        myHill = new Array(98, 0, 8, 1, 1, 16, 6, 0, 3, 5, 10, 8, 0, 2, 8, 7, 0, 21, 2, 9, 10, 0, 13, 22, 10, 3, 11, 9, 0, 3, 6, 0, 4, 7, 9, 17, 19, 18, 8, 14, 15, 0, 22, 9, 10, 5, 8, 2, 9, 19, 20, 18, 0, 22, 10, 13, 11, 8, 1, 2, 0, 3, 8, 2, 9, 4, 16, 2, 0, 5, 8, 6, 9, 0, 8, 17, 0, 0, 2, 8, 13, 0, 4, 1, 7, 9, 6, 8, 0, 99);\n"+
"    } else if (ENGINE.getActiveWaddleId() == 104) {\n"+
"        myHill = new Array(98, 0, 8, 1, 1, 16, 6, 0, 3, 5, 10, 8, 0, 2, 8, 7, 0, 21, 2, 9, 10, 0, 13, 22, 10, 3, 11, 9, 0, 3, 6, 0, 4, 7, 9, 17, 19, 18, 8, 14, 15, 0, 22, 9, 10, 5, 8, 2, 9, 19, 20, 18, 0, 22, 10, 13, 11, 8, 1, 2, 0, 3, 8, 2, 9, 4, 16, 2, 0, 5, 8, 6, 9, 0, 8, 17, 0, 0, 2, 8, 13, 0, 4, 1, 7, 9, 6, 8, 0, 0, 8, 1, 1, 16, 6, 0, 3, 5, 10, 8, 0, 2, 8, 7, 0, 21, 2, 9, 10, 0, 13, 22, 10, 3, 11, 9, 0, 3, 6, 0, 4, 7, 9, 17, 19, 18, 8, 14, 15, 0, 22, 9, 10, 5, 8, 2, 9, 19, 20, 18, 0, 22, 10, 13, 11, 8, 1, 2, 0, 3, 8, 2, 9, 4, 16, 2, 0, 5, 8, 6, 9, 0, 8, 17, 0, 0, 2, 8, 13, 0, 4, 1, 7, 9, 6, 8, 13, 22, 10, 3, 11, 9, 0, 3, 6, 0, 4, 7, 9, 17, 19, 18, 8, 14, 15, 0, 22, 9, 10, 5, 8, 2, 9, 19, 20, 18, 0, 22, 10, 13, 11, 8, 1, 2, 0, 3, 8, 2, 9, 4, 16, 2, 0, 5, 8, 6, 9, 0, 8, 17, 0, 0, 2, 8, 13, 0, 4, 1, 7, 9, 6, 8, 0, 0, 8, 1, 1, 16, 6, 0, 3, 5, 10, 8, 0, 0, 99);\n"+
"    } else {\n"+
"        myHill = new Array(98, 12, 10, 9, 12, 17, 0, 4, 0, 4, 12, 8, 16, 9, 13, 0, 8, 0, 2, 2, 8, 0, 11, 8, 9, 12, 13, 0, 9, 8, 4, 11, 12, 8, 17, 18, 19, 18, 19, 12, 9, 16, 12, 5, 9, 8, 17, 16, 5, 9, 2, 2, 16, 9, 13, 7, 12, 8, 9, 21, 0, 2, 0, 0, 1, 0, 8, 6, 12, 9, 0, 8, 1, 9, 10, 5, 0, 17, 9, 1, 11, 0, 9, 16, 9, 17, 7, 0, 8, 99);\n"+
"    }\n"+
"    myMap = new Array();\n"+
"    var n = 0;\n"+
"    while (n < myHill.length) {\n"+
"        myMap = myMap.concat(myHillTile[myHill[n]].map);\n"+
"        n++;\n"+
"    }\n"+
"    trace(\"tiles end\");\n"+
"    var max_players_list = new Object();\n"+
"    max_players_list[100] = 4;\n"+
"    max_players_list[101] = 3;\n"+
"    max_players_list[102] = 2;\n"+
"    max_players_list[103] = 2;\n"+
"    max_players_list[104] = 4;\n"+
"    var MAX_PLAYERS = max_players_list[ENGINE.getActiveWaddleId()];\n"+
"    var ROOM_ID = SHELL.getCurrentServerRoomId();\n"+
"    var PARTY_ROOM_ID = 855;\n"+
"    var LAST_ROOM_ID;\n"+
"    addListeners();\n"+
"    var currentTile = 0;\n"+
"    startGame();\n"+
"    stop();\n";
doc.selectNone();
tl.setSelectedFrames([0,1,1],true);
tl.convertToBlankKeyframes(1);
tl.layers[0].frames[1].actionScript=
"    function moveDown() {\n"+
"        currentTile++;\n"+
"        hill._x = 100 - (currentTile * 200);\n"+
"        hill._y = 200 - ((currentTile * 200) * 0.6);\n"+
"    }\n"+
"    function moveUp() {\n"+
"        currentTile--;\n"+
"        hill._x = 100 - (currentTile * 200);\n"+
"        hill._y = 200 - ((currentTile * 200) * 0.6);\n"+
"    }\n"+
"    function changeTile() {\n"+
"        var _local_3 = hill[\"t\" + currentTile];\n"+
"        var _local_1 = _local_3.ob.id;\n"+
"        var _local_2 = _local_3.ob.link;\n"+
"        _local_2++;\n"+
"        if (_local_2 > maxTiles) {\n"+
"            _local_2 = 0;\n"+
"        }\n"+
"        var _local_4 = \"t\" + _local_2;\n"+
"        hill.attachMovie(_local_4, \"t\" + _local_1, _local_1);\n"+
"        _local_3 = hill[\"t\" + _local_1];\n"+
"        _local_3._x = _local_1 * 200;\n"+
"        _local_3._y = (_local_1 * 200) * 0.6;\n"+
"        _local_3.ob = new Object();\n"+
"        _local_3.ob.id = _local_1;\n"+
"        _local_3.ob.link = _local_2;\n"+
"        myHill[_local_1] = _local_2;\n"+
"    }\n"+
"    function saveHill() {\n"+
"        trace(myHill.join());\n"+
"    }\n"+
"    function addHazard() {\n"+
"        isAddOn = true;\n"+
"        hazardCounter++;\n"+
"        hill.attachMovie(\"h0\", \"h\" + hazardCounter, hazardCounter + 1000);\n"+
"        mcHazard = hill[\"h\" + hazardCounter];\n"+
"        mcHazard._x = currentTile * 200;\n"+
"        mcHazard._y = (currentTile * 200) * 0.6;\n"+
"        mcHazard.onPress = function () {\n"+
"            mcHazard.startDrag();\n"+
"        };\n"+
"        mcHazard.onRelease = function () {\n"+
"            mcHazard.stopDrag();\n"+
"        };\n"+
"        mcHazard.isHazard = true;\n"+
"    }\n"+
"    trace(\"tiles begin\");\n"+
"    myHillTile = new Array();\n"+
"    myHillTile[0] = new Object();\n"+
"    myHillTile[0].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[1] = new Object();\n"+
"    myHillTile[1].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, -1, -1, -1, -1, -1, -1, -1], [0, 0, 0, -1, -2, -3, -3, -3, -3, -3], [0, 0, 0, -1, -2, -3, -3, -3, -3, -3], [0, 0, 0, -1, -2, -2, -2, -2, -2, -2], [0, 0, 0, -1, -1, -1, -1, -1, -1, -1], [0, 0, 0, -1, -1, -1, -1, -1, -1, -1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[2] = new Object();\n"+
"    myHillTile[2].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 4, 4, 4, 4, 4, 4, 4, 4], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[3] = new Object();\n"+
"    myHillTile[3].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 1, 1, 1, 1], [0, 0, 0, 0, 0, 2, 2, 2, 2, 2], [0, 0, 0, 0, 0, 3, 3, 3, 3, 3], [0, 0, 0, 0, 0, 4, 4, 4, 4, 4], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[4] = new Object();\n"+
"    myHillTile[4].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0], [2, 2, 2, 2, 2, 0, 0, 0, 0, 0], [3, 3, 3, 3, 3, 0, 0, 0, 0, 0], [4, 4, 4, 4, 4, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[5] = new Object();\n"+
"    myHillTile[5].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 1, 1, 1, 1, 1, 0, 0], [0, 0, 0, 2, 2, 2, 2, 2, 0, 0], [11, 11, 11, 3, 3, 3, 3, 3, 11, 11], [11, 11, 11, 4, 4, 4, 4, 4, 11, 11], [11, 11, 11, 0, 0, 0, 0, 0, 11, 11], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[6] = new Object();\n"+
"    myHillTile[6].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 1, 1, 1], [0, 0, 0, 0, 0, 0, 2, 2, 2, 2], [11, 11, 11, 11, 11, 11, 3, 3, 3, 3], [11, 11, 11, 11, 11, 11, 4, 4, 4, 4], [11, 11, 11, 11, 11, 11, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[7] = new Object();\n"+
"    myHillTile[7].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0], [2, 2, 2, 2, 2, 0, 0, 0, 0, 0], [3, 3, 3, 3, 3, 11, 11, 11, 11, 11], [4, 4, 4, 4, 4, 11, 11, 11, 11, 11], [0, 0, 0, 0, 0, 11, 11, 11, 11, 11], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[8] = new Object();\n"+
"    myHillTile[8].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[9] = new Object();\n"+
"    myHillTile[9].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[10] = new Object();\n"+
"    myHillTile[10].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[11] = new Object();\n"+
"    myHillTile[11].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 1, 1, 1, 1], [2, 2, 2, 2, 2, 0, 2, 2, 2, 2], [3, 3, 3, 3, 3, 11, 3, 3, 3, 3], [4, 4, 4, 4, 4, 11, 4, 4, 4, 4], [0, 0, 0, 0, 0, 11, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[12] = new Object();\n"+
"    myHillTile[12].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[13] = new Object();\n"+
"    myHillTile[13].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 11, 11, 0, 0, 0], [0, 0, 0, 0, 0, 11, 11, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[14] = new Object();\n"+
"    myHillTile[14].map = new Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 5, 5, 5, 5, 5, 5, 5, 5, 5], [6, 6, 6, 6, 6, 6, 6, 6, 6, 6], [7, 7, 7, 7, 7, 7, 7, 7, 7, 7], [8, 8, 8, 8, 8, 8, 8, 8, 8, 8], [9, 9, 9, 9, 9, 9, 9, 9, 9, 9]);\n"+
"    myHillTile[15] = new Object();\n"+
"    myHillTile[15].map = new Array([-8, -8, -8, -8, -8, -8, -8, -8, -8, -8], [-8, -8, -8, -8, -8, -8, -8, -8, -8, -8], [-7, -7, -7, -7, -7, -7, -7, -7, -7, -7], [-6, -6, -6, -6, -6, -6, -6, -6, -6, -6], [-5, -5, -5, -5, -5, -5, -5, -5, -5, -5], [-4, -4, -4, -4, -4, -4, -4, -4, -4, -4], [-3, -3, -3, -3, -3, -3, -3, -3, -3, -3], [-2, -2, -2, -2, -2, -2, -2, -2, -2, -2], [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[16] = new Object();\n"+
"    myHillTile[16].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[17] = new Object();\n"+
"    myHillTile[17].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 1, 1, 1, 0, 0], [0, 0, 0, 0, 1, 1, 1, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[18] = new Object();\n"+
"    myHillTile[18].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 1, 1, 1], [0, 0, 0, 0, 0, 0, 0, 1, 1, 1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[19] = new Object();\n"+
"    myHillTile[19].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[20] = new Object();\n"+
"    myHillTile[20].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 12, 12, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[21] = new Object();\n"+
"    myHillTile[21].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 12, 12, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[22] = new Object();\n"+
"    myHillTile[22].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 11, 11], [0, 0, 0, 0, 0, 0, 0, 0, 11, 11], [11, 11, 11, 0, 0, 0, 0, 0, 0, 0], [11, 11, 11, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[98] = new Object();\n"+
"    myHillTile[98].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);\n"+
"    myHillTile[99] = new Object();\n"+
"    myHillTile[99].map = new Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10], [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]);\n"+
"    trace(\"ENGINE.getActiveWaddleId()\" + ENGINE.getActiveWaddleId());\n"+
"    if (ENGINE.getActiveWaddleId() == 100) {\n"+
"        myHill = new Array(98, 16, 14, 15, 12, 17, 1, 0, 7, 0, 2, 9, 13, 8, 2, 0, 10, 0, 17, 5, 12, 19, 0, 17, 9, 7, 0, 5, 22, 1, 0, 13, 19, 21, 18, 9, 13, 7, 12, 5, 0, 2, 8, 0, 7, 10, 21, 6, 0, 14, 15, 9, 10, 1, 22, 1, 12, 3, 8, 5, 9, 20, 4, 10, 3, 6, 0, 1, 11, 13, 8, 0, 9, 2, 8, 22, 19, 18, 8, 5, 21, 3, 9, 5, 8, 20, 14, 15, 0, 99);\n"+
"    } else if (ENGINE.getActiveWaddleId() == 101) {\n"+
"        myHill = new Array(98, 0, 0, 19, 18, 9, 11, 10, 2, 17, 16, 9, 22, 0, 0, 5, 0, 21, 0, 8, 2, 9, 6, 0, 4, 7, 0, 17, 5, 0, 8, 9, 10, 14, 15, 0, 2, 0, 4, 0, 5, 0, 19, 19, 18, 18, 6, 0, 13, 8, 1, 4, 8, 0, 0, 2, 0, 4, 18, 5, 8, 5, 0, 1, 10, 20, 16, 2, 5, 22, 0, 11, 9, 10, 1, 5, 17, 0, 8, 13, 2, 0, 22, 17, 0, 20, 9, 0, 0, 99);\n"+
"    } else if (ENGINE.getActiveWaddleId() == 102) {\n"+
"        myHill = new Array(98, 0, 8, 1, 1, 16, 6, 0, 3, 5, 10, 8, 0, 2, 8, 7, 0, 21, 2, 9, 10, 0, 13, 22, 10, 3, 11, 9, 0, 3, 6, 0, 4, 7, 9, 17, 19, 18, 8, 14, 15, 0, 22, 9, 10, 5, 8, 2, 9, 19, 20, 18, 0, 22, 10, 13, 11, 8, 1, 2, 0, 3, 8, 2, 9, 4, 16, 2, 0, 5, 8, 6, 9, 0, 8, 17, 0, 0, 2, 8, 13, 0, 4, 1, 7, 9, 6, 8, 0, 99);\n"+
"    } else if (ENGINE.getActiveWaddleId() == 104) {\n"+
"        myHill = new Array(98, 0, 8, 1, 1, 16, 6, 0, 3, 5, 10, 8, 0, 2, 8, 7, 0, 21, 2, 9, 10, 0, 13, 22, 10, 3, 11, 9, 0, 3, 6, 0, 4, 7, 9, 17, 19, 18, 8, 14, 15, 0, 22, 9, 10, 5, 8, 2, 9, 19, 20, 18, 0, 22, 10, 13, 11, 8, 1, 2, 0, 3, 8, 2, 9, 4, 16, 2, 0, 5, 8, 6, 9, 0, 8, 17, 0, 0, 2, 8, 13, 0, 4, 1, 7, 9, 6, 8, 0, 0, 8, 1, 1, 16, 6, 0, 3, 5, 10, 8, 0, 2, 8, 7, 0, 21, 2, 9, 10, 0, 13, 22, 10, 3, 11, 9, 0, 3, 6, 0, 4, 7, 9, 17, 19, 18, 8, 14, 15, 0, 22, 9, 10, 5, 8, 2, 9, 19, 20, 18, 0, 22, 10, 13, 11, 8, 1, 2, 0, 3, 8, 2, 9, 4, 16, 2, 0, 5, 8, 6, 9, 0, 8, 17, 0, 0, 2, 8, 13, 0, 4, 1, 7, 9, 6, 8, 13, 22, 10, 3, 11, 9, 0, 3, 6, 0, 4, 7, 9, 17, 19, 18, 8, 14, 15, 0, 22, 9, 10, 5, 8, 2, 9, 19, 20, 18, 0, 22, 10, 13, 11, 8, 1, 2, 0, 3, 8, 2, 9, 4, 16, 2, 0, 5, 8, 6, 9, 0, 8, 17, 0, 0, 2, 8, 13, 0, 4, 1, 7, 9, 6, 8, 0, 0, 8, 1, 1, 16, 6, 0, 3, 5, 10, 8, 0, 0, 99);\n"+
"    } else {\n"+
"        myHill = new Array(98, 12, 10, 9, 12, 17, 0, 4, 0, 4, 12, 8, 16, 9, 13, 0, 8, 0, 2, 2, 8, 0, 11, 8, 9, 12, 13, 0, 9, 8, 4, 11, 12, 8, 17, 18, 19, 18, 19, 12, 9, 16, 12, 5, 9, 8, 17, 16, 5, 9, 2, 2, 16, 9, 13, 7, 12, 8, 9, 21, 0, 2, 0, 0, 1, 0, 8, 6, 12, 9, 0, 8, 1, 9, 10, 5, 0, 17, 9, 1, 11, 0, 9, 16, 9, 17, 7, 0, 8, 99);\n"+
"    }\n"+
"    myMap = new Array();\n"+
"    var n = 0;\n"+
"    while (n < myHill.length) {\n"+
"        myMap = myMap.concat(myHillTile[myHill[n]].map);\n"+
"        n++;\n"+
"    }\n"+
"    trace(\"tiles end\");\n"+
"    var n = 0;\n"+
"    while (n < myHill.length) {\n"+
"        var tileLinkName = (\"t\" + myHill[n]);\n"+
"        hill.attachMovie(tileLinkName, \"t\" + n, n);\n"+
"        var mcTile = hill[\"t\" + n];\n"+
"        mcTile._x = n * 200;\n"+
"        mcTile._y = (n * 200) * 0.6;\n"+
"        mcTile.ob = new Object();\n"+
"        mcTile.ob.id = n;\n"+
"        mcTile.ob.link = Number(myHill[n]);\n"+
"        n++;\n"+
"    }\n"+
"    maxTiles = 22;\n"+
"    currentTile = 0;\n"+
"    currentTileLink = 0;\n"+
"    isAddOn = false;\n"+
"    hazardCounter = 0;\n"+
"    stop();\n";
doc.selectNone();
tl.setSelectedFrames([0,0,0],true);
tl.addNewLayer();
tl.layers[0].name="labels";
tl.setSelectedFrames([0,0,0],true);
tl.layers[0].frames[0].name="Game";
tl.layers[0].frames[0].labelType="name";
doc.selectNone();
//force all classes to be exported
tl.addNewLayer();
tl.layers[0].name="extra actions";
tl.setSelectedFrames([0,0,0],true);
tl.layers[0].frames[0].actionScript=
"//force all classes to be exported\n"+
"function _forceClassExport(){\n"+
"com.clubpenguin.util.LocaleText;\n"+
"mx.events.EventDispatcher;\n"+
"com.clubpenguin.util.Reporting;\n"+
"com.clubpenguin.util.Loader;\n"+
"com.clubpenguin.text.TextResize;\n"+
"}\n";
doc.selectNone();
