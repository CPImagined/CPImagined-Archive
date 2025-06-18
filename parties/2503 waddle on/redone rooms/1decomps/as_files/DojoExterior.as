    class as_files.DojoExterior extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, wem, now, _currentParty, _checkTaskAvailableIntervalID, _secondCheckIntervalID, _checkTargetDelegate, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, showContent, questionNumber, actualAnswer, acceptUserInput, playerAnswer, _roomUpdateInterval, _handlePlayerFrameDelegate;
        function DojoExterior (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 390;
            _stage.start_y = 365;
            if (!_SHELL) {
                init();
                showCards();
            }
            localize([_stage.backwall_mc.TriviaScreen.TriviaQuestions, _stage.backwall_mc.comeBackText]);
            _stage.TriviaButtonA_btn.useHandCursor = false;
            _stage.TriviaButtonB_btn.useHandCursor = false;
            _stage.TriviaButtonC_btn.useHandCursor = false;
            _stage.TriviaButtonA_target._visible = false;
            _stage.TriviaButtonB_target._visible = false;
            _stage.TriviaButtonC_target._visible = false;
        }
        function showCards() {
            _stage.interface_mc.cardIcon_btn._visible = true;
        }
        function hideCards() {
            _stage.interface_mc.cardIcon_btn._visible = false;
        }
        function initFunctionality() {
            _global.getCurrentInterface().enableInterface();
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            if ((((!_SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID_VANILLA)) || (!_SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID_FIRE))) || (!_SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID_WATER))) || (!_SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID_SNOW))) {
                _global.getCurrentInterface().disableInterface();
                hideCards();
                newplayerexperiencecomplete();
            } else {
                _global.getCurrentInterface().enableInterface();
            }
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(60);
            wem.setupRainAnimationHeight(85);
            wem.setupSnowAnimationHeight(85);
            wem.setupRainAnimationSpeed(0.5);
            wem.setupSnowAnimationSpeed(1);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            if (_SHELL.getPenguinStandardTime != undefined) {
                now = _SHELL.getPenguinStandardTime();
            } else {
                now = new Date();
            }
            _stage.TriviaButtonA_btn.onRelease = com.clubpenguin.util.Delegate.create(this, TriviaButtonA_onRelease);
            _stage.TriviaButtonB_btn.onRelease = com.clubpenguin.util.Delegate.create(this, TriviaButtonB_onRelease);
            _stage.TriviaButtonC_btn.onRelease = com.clubpenguin.util.Delegate.create(this, TriviaButtonC_onRelease);
            blockUserInput();
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _checkTaskAvailableIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, checkTaskAvailable), 500);
        }
        function checkTaskAvailable() {
            clearInterval(_checkTaskAvailableIntervalID);
            if (_currentParty.isTaskAvailable(START_TASK_ID)) {
                clearInterval(_secondCheckIntervalID);
                _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateClock), ONE_SECOND);
                _checkTargetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
                _SHELL.addListener(_SHELL.BALL_LAND, _checkTargetDelegate);
                initialTimeCheck();
            } else {
                _stage.backwall_mc.gotoAndStop("off");
            }
        }
        function configureTriggers() {
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.dojoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojo", 380, 355);
            _stage.triggers_mc.exitTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 375, 215);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.dojo_btn, 388, 290)]);
        }
        function configureRoomElements() {
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cardIcon_btn, true, NINJA_PROGRESS_UI, "", {playerHasTuskCape:_SHELL.isItemInMyInventory(TUSK_CAPE_ITEM)})]);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom(roomName, x, y);
            }
        }
        function updateClock() {
            now.setTime(now.getTime() + 1000);
            var _local_3 = now.getMinutes() % 6;
            var _local_2 = now.getSeconds();
            trace((_local_3 + ":") + _local_2);
            if (_local_2 == 0) {
                if (_local_3 == 0) {
                    setupQuestion1();
                } else if (_local_3 == 1) {
                    setupQuestion4();
                } else if (_local_3 == 2) {
                    setupQuestion7();
                } else if (_local_3 == 3) {
                    setupQuestion10();
                } else if (_local_3 == 4) {
                    setupQuestion13();
                } else {
                    setupQuestion16();
                }
                showNextQuestion();
            } else if (_local_2 == 20) {
                if (_local_3 == 0) {
                    setupQuestion2();
                } else if (_local_3 == 1) {
                    setupQuestion5();
                } else if (_local_3 == 2) {
                    setupQuestion8();
                } else if (_local_3 == 3) {
                    setupQuestion11();
                } else if (_local_3 == 4) {
                    setupQuestion14();
                } else {
                    setupQuestion17();
                }
                showNextQuestion();
            } else if (_local_2 == 40) {
                if (_local_3 == 0) {
                    setupQuestion3();
                } else if (_local_3 == 1) {
                    setupQuestion6();
                } else if (_local_3 == 2) {
                    setupQuestion9();
                } else if (_local_3 == 3) {
                    setupQuestion12();
                } else if (_local_3 == 4) {
                    setupQuestion15();
                } else {
                    setupQuestion18();
                }
                showNextQuestion();
            } else if (((_local_2 == 15) || (_local_2 == 35)) || (_local_2 == 55)) {
                checkAnswer();
            } else if (((_local_2 == 19) || (_local_2 == 39)) || (_local_2 == 59)) {
                clearCurrentQuestion();
            }
            var _local_4;
            if (_local_2 <= 19) {
            } else if ((_local_2 >= 20) && (_local_2 <= 39)) {
                _local_2 = _local_2 - 20;
            } else {
                _local_2 = _local_2 - 40;
            }
            _local_4 = (_local_2 * 24) + 1;
            _stage.backwall_mc.TriviaScreen.TimerCircle.RealTimer.gotoAndPlay(_local_4);
        }
        function initialTimeCheck() {
            now.setTime(now.getTime() + 1000);
            var _local_5 = now.getHours();
            var _local_3 = now.getMinutes() % 6;
            var _local_2 = now.getSeconds();
            trace(((("+++++++++ FUNCTION initialTimeCheck fired! Time = " + _local_3) + ":") + _local_2) + " +++++++++");
            if ((_local_2 >= 0) && (_local_2 <= 14)) {
                trace("SECONDS IS BETWEEN 00 & 14");
                if (_local_3 == 0) {
                    setupQuestion1();
                } else if (_local_3 == 1) {
                    setupQuestion4();
                } else if (_local_3 == 2) {
                    setupQuestion7();
                } else if (_local_3 == 3) {
                    setupQuestion10();
                } else if (_local_3 == 4) {
                    setupQuestion13();
                } else {
                    setupQuestion16();
                }
                showNextQuestion();
            } else if ((_local_2 >= 20) && (_local_2 <= 34)) {
                trace("SECONDS IS BETWEEN 20 & 34");
                if (_local_3 == 0) {
                    setupQuestion2();
                } else if (_local_3 == 1) {
                    setupQuestion5();
                } else if (_local_3 == 2) {
                    setupQuestion8();
                } else if (_local_3 == 3) {
                    setupQuestion11();
                } else if (_local_3 == 4) {
                    setupQuestion14();
                } else {
                    setupQuestion17();
                }
                showNextQuestion();
            } else if ((_local_2 >= 40) && (_local_2 <= 54)) {
                trace("SECONDS IS BETWEEN 40 & 54");
                if (_local_3 == 0) {
                    setupQuestion3();
                } else if (_local_3 == 1) {
                    setupQuestion6();
                } else if (_local_3 == 2) {
                    setupQuestion9();
                } else if (_local_3 == 3) {
                    setupQuestion12();
                } else if (_local_3 == 4) {
                    setupQuestion15();
                } else {
                    setupQuestion18();
                }
                showNextQuestion();
            }
            var _local_4;
            trace(("---------- REAL TIMER: seconds = " + _local_2) + "----------");
            if (_local_2 <= 19) {
                trace("++++++++++++++++ TRIGGERED 1st CONDITION +++++++++++++++++");
                trace("++++++++++++++++ Do nothing!!!!!!!!!!!!! +++++++++++++++++");
            } else if ((_local_2 >= 20) && (_local_2 <= 39)) {
                trace("++++++++++++++++ TRIGGERED 2nd CONDITION +++++++++++++++++");
                trace("++++++++++++++++ Subtract 20 from seconds ++++++++++++++++");
                _local_2 = _local_2 - 20;
            } else {
                trace("++++++++++++++++ TRIGGERED 3rd CONDITION +++++++++++++++++");
                trace("++++++++++++++++ Subtract 20 from seconds ++++++++++++++++");
                _local_2 = _local_2 - 40;
            }
            trace(("---------- REAL TIMER AFTER MATHS: seconds = " + _local_2) + "----------");
            _local_4 = (_local_2 * 24) + 1;
            _stage.backwall_mc.TriviaScreen.TimerCircle.RealTimer.gotoAndPlay(_local_4);
        }
        function showNextQuestion() {
            allowUserInput();
            _stage.backwall_mc.TriviaScreen.TriviaQuestions.questionText.gotoAndStop(questionNumber);
            _stage.backwall_mc.TriviaScreen.gotoAndPlay("Show");
            _stage.backwall_mc.TriviaScreen.TimerCircle.gotoAndStop("CountDownOn");
        }
        function clearCurrentQuestion() {
            if (((actualAnswer == "A") || (actualAnswer == "B")) || (actualAnswer == "C")) {
                _stage.backwall_mc.TriviaScreen.gotoAndPlay("Hide");
                _stage.backwall_mc.targetA.states.Light.gotoAndStop("off");
                _stage.backwall_mc.targetB.states.Light.gotoAndStop("off");
                _stage.backwall_mc.targetC.states.Light.gotoAndStop("off");
                blockUserInput();
            }
        }
        function blockUserInputNoArtChange() {
            acceptUserInput = false;
        }
        function blockUserInput() {
            acceptUserInput = false;
            _stage.backwall_mc.targetA.states.Target.gotoAndStop("off");
            _stage.backwall_mc.targetB.states.Target.gotoAndStop("off");
            _stage.backwall_mc.targetC.states.Target.gotoAndStop("off");
        }
        function allowUserInput() {
            acceptUserInput = true;
            _stage.backwall_mc.TriviaScreen.AnswerSelectA.states.gotoAndStop("off");
            _stage.backwall_mc.TriviaScreen.AnswerSelectB.states.gotoAndStop("off");
            _stage.backwall_mc.TriviaScreen.AnswerSelectC.states.gotoAndStop("off");
            _stage.backwall_mc.targetA.states.Light.gotoAndStop("off");
            _stage.backwall_mc.targetB.states.Light.gotoAndStop("off");
            _stage.backwall_mc.targetC.states.Light.gotoAndStop("off");
            _stage.backwall_mc.targetA.states.Target.gotoAndStop("on");
            _stage.backwall_mc.targetB.states.Target.gotoAndStop("on");
            _stage.backwall_mc.targetC.states.Target.gotoAndStop("on");
            _stage.backwall_mc.TriviaScreen.AnswerSelectA.gotoAndStop("default");
            _stage.backwall_mc.TriviaScreen.AnswerSelectB.gotoAndStop("default");
            _stage.backwall_mc.TriviaScreen.AnswerSelectC.gotoAndStop("default");
            playerAnswer = "NOANSWER";
        }
        function TriviaButtonA_onRelease() {
            if (acceptUserInput == true) {
                blockUserInput();
                playerAnswer = "A";
                _stage.backwall_mc.TriviaScreen.AnswerSelectA.states.gotoAndStop("on");
                _stage.backwall_mc.targetA.gotoAndPlay("PushIn");
                _stage.backwall_mc.targetA.states.Light.gotoAndStop("picked");
                _stage.backwall_mc.targetA.states.Target.gotoAndStop("picked");
            } else {
                trace("USER INPUT IS BLOCKED");
            }
        }
        function TriviaButtonB_onRelease() {
            if (acceptUserInput == true) {
                blockUserInput();
                playerAnswer = "B";
                _stage.backwall_mc.TriviaScreen.AnswerSelectB.states.gotoAndStop("on");
                _stage.backwall_mc.targetB.gotoAndPlay("PushIn");
                _stage.backwall_mc.targetB.states.Light.gotoAndStop("picked");
                _stage.backwall_mc.targetB.states.Target.gotoAndStop("picked");
            } else {
                trace("USER INPUT IS BLOCKED");
            }
        }
        function TriviaButtonC_onRelease() {
            if (acceptUserInput == true) {
                blockUserInput();
                playerAnswer = "C";
                _stage.backwall_mc.TriviaScreen.AnswerSelectC.states.gotoAndStop("on");
                _stage.backwall_mc.targetC.gotoAndPlay("PushIn");
                _stage.backwall_mc.targetC.states.Light.gotoAndStop("picked");
                _stage.backwall_mc.targetC.states.Target.gotoAndStop("picked");
            } else {
                trace("USER INPUT IS BLOCKED");
            }
        }
        function checkAnswer() {
            blockUserInputNoArtChange();
            if (actualAnswer == "A") {
                _stage.backwall_mc.TriviaScreen.AnswerSelectA.gotoAndStop("right");
                _stage.backwall_mc.TriviaScreen.AnswerSelectB.gotoAndStop("wrong");
                _stage.backwall_mc.TriviaScreen.AnswerSelectC.gotoAndStop("wrong");
                _stage.backwall_mc.targetA.states.Light.gotoAndStop("right");
                _stage.backwall_mc.targetB.states.Light.gotoAndStop("wrong");
                _stage.backwall_mc.targetC.states.Light.gotoAndStop("wrong");
                _stage.backwall_mc.targetA.states.Target.gotoAndStop("right");
                _stage.backwall_mc.targetB.states.Target.gotoAndStop("wrong");
                _stage.backwall_mc.targetC.states.Target.gotoAndStop("wrong");
                if (playerAnswer == "A") {
                    _stage.backwall_mc.targetA.states.Target.gotoAndStop("pickedRight");
                    playerPickedCorrectAnswer();
                } else if (playerAnswer == "B") {
                    _stage.backwall_mc.targetB.states.Target.gotoAndStop("pickedWrong");
                    playerPickedWrongAnswer();
                } else if (playerAnswer == "C") {
                    _stage.backwall_mc.targetC.states.Target.gotoAndStop("pickedWrong");
                    playerPickedWrongAnswer();
                }
            } else if (actualAnswer == "B") {
                _stage.backwall_mc.TriviaScreen.AnswerSelectA.gotoAndStop("wrong");
                _stage.backwall_mc.TriviaScreen.AnswerSelectB.gotoAndStop("right");
                _stage.backwall_mc.TriviaScreen.AnswerSelectC.gotoAndStop("wrong");
                _stage.backwall_mc.targetA.states.Light.gotoAndStop("wrong");
                _stage.backwall_mc.targetB.states.Light.gotoAndStop("right");
                _stage.backwall_mc.targetC.states.Light.gotoAndStop("wrong");
                _stage.backwall_mc.targetA.states.Target.gotoAndStop("wrong");
                _stage.backwall_mc.targetB.states.Target.gotoAndStop("right");
                _stage.backwall_mc.targetC.states.Target.gotoAndStop("wrong");
                if (playerAnswer == "B") {
                    _stage.backwall_mc.targetB.states.Target.gotoAndStop("pickedRight");
                    playerPickedCorrectAnswer();
                } else if (playerAnswer == "A") {
                    _stage.backwall_mc.targetA.states.Target.gotoAndStop("pickedWrong");
                    playerPickedWrongAnswer();
                } else if (playerAnswer == "C") {
                    _stage.backwall_mc.targetC.states.Target.gotoAndStop("pickedWrong");
                    playerPickedWrongAnswer();
                }
            } else if (actualAnswer == "C") {
                _stage.backwall_mc.TriviaScreen.AnswerSelectA.gotoAndStop("wrong");
                _stage.backwall_mc.TriviaScreen.AnswerSelectB.gotoAndStop("wrong");
                _stage.backwall_mc.TriviaScreen.AnswerSelectC.gotoAndStop("right");
                _stage.backwall_mc.targetA.states.Light.gotoAndStop("wrong");
                _stage.backwall_mc.targetB.states.Light.gotoAndStop("wrong");
                _stage.backwall_mc.targetC.states.Light.gotoAndStop("right");
                _stage.backwall_mc.targetA.states.Target.gotoAndStop("wrong");
                _stage.backwall_mc.targetB.states.Target.gotoAndStop("wrong");
                _stage.backwall_mc.targetC.states.Target.gotoAndStop("right");
                if (playerAnswer == "C") {
                    _stage.backwall_mc.targetC.states.Target.gotoAndStop("pickedRight");
                    playerPickedCorrectAnswer();
                } else if (playerAnswer == "A") {
                    _stage.backwall_mc.targetA.states.Target.gotoAndStop("pickedWrong");
                    playerPickedWrongAnswer();
                } else if (playerAnswer == "B") {
                    _stage.backwall_mc.targetB.states.Target.gotoAndStop("pickedWrong");
                    playerPickedWrongAnswer();
                }
            } else {
                trace("ERROR! ERROR! ERROR! actualAnswer is not A, B, or C. actualAnswer = " + actualAnswer);
            }
        }
        function playerPickedCorrectAnswer() {
            _stage.backwall_mc.TriviaScreen.states.gotoAndStop("win");
            _stage.backwall_mc.TriviaScreen.TimerCircle.gotoAndStop("CorrectFace");
            earnCoins();
            var _local_2 = START_TASK_ID;
            while (_local_2 < (START_TASK_ID + 3)) {
                if (!_currentParty.isQuestTaskComplete(_local_2)) {
                    _currentParty.taskComplete(_local_2);
                    break;
                }
                _local_2++;
            }
        }
        function playerPickedWrongAnswer() {
            _stage.backwall_mc.TriviaScreen.states.gotoAndStop("lose");
            _stage.backwall_mc.TriviaScreen.TimerCircle.gotoAndStop("WrongFace");
        }
        function startTimerOnCorrectFrame() {
            trace("++++++++++++++++ startTimerOnCorrectFrame ++++++++++++++++");
            now.setTime(now.getTime() + 1000);
            var _local_3 = now.getHours();
            var _local_4 = now.getMinutes() % 6;
            var _local_2 = now.getSeconds();
            trace(("++++++++++++++++ seconds = " + _local_2) + " ++++++++++++++++");
            if (_local_2 <= 19) {
                trace("++++++++++++++++ TRIGGERED 1st CONDITION ++++++++++++++++");
            } else if ((_local_2 >= 20) && (_local_2 <= 39)) {
                trace("++++++++++++++++ TRIGGERED 2nd CONDITION ++++++++++++++++");
            } else {
                trace("++++++++++++++++ TRIGGERED 3rd CONDITION ++++++++++++++++");
            }
        }
        function setupQuestion1() {
            questionNumber = 1;
            actualAnswer = "A";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion2() {
            questionNumber = 2;
            actualAnswer = "B";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion3() {
            questionNumber = 3;
            actualAnswer = "B";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion4() {
            questionNumber = 4;
            actualAnswer = "C";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion5() {
            questionNumber = 5;
            actualAnswer = "A";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion6() {
            questionNumber = 6;
            actualAnswer = "C";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion7() {
            questionNumber = 7;
            actualAnswer = "A";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion8() {
            questionNumber = 8;
            actualAnswer = "C";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion9() {
            questionNumber = 9;
            actualAnswer = "B";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion10() {
            questionNumber = 10;
            actualAnswer = "A";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion11() {
            questionNumber = 11;
            actualAnswer = "B";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion12() {
            questionNumber = 12;
            actualAnswer = "C";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion13() {
            questionNumber = 13;
            actualAnswer = "A";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion14() {
            questionNumber = 14;
            actualAnswer = "C";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion15() {
            questionNumber = 15;
            actualAnswer = "C";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion16() {
            questionNumber = 16;
            actualAnswer = "A";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion17() {
            questionNumber = 17;
            actualAnswer = "B";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function setupQuestion18() {
            questionNumber = 18;
            actualAnswer = "C";
            trace(("!!! questionNumber: " + questionNumber) + " !!!");
        }
        function onSnowballLand(snowballInfo) {
            var _local_4 = [_stage.TriviaButtonA_target, _stage.TriviaButtonB_target, _stage.TriviaButtonC_target];
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                if (_local_4[_local_2].hitTest(snowballInfo.x, snowballInfo.y, true)) {
                    if (snowballInfo.player_id == _SHELL.getMyPlayerId()) {
                        if (_local_2 == 0) {
                            TriviaButtonA_onRelease();
                        } else if (_local_2 == 1) {
                            TriviaButtonB_onRelease();
                        } else if (_local_2 == 2) {
                            TriviaButtonC_onRelease();
                        }
                        break;
                    }
                }
                _local_2++;
            }
        }
        function earnCoins() {
            _global.getCurrentParty().BaseParty.CURRENT_PARTY.sendCoinsEarned(5);
            trace("_stage.coinanimation_mc : " + _stage.coinanimation_mc);
            if (_stage.coinanimation_mc) {
                _stage.coinanimation_mc.removeMovieClip();
            }
            var _local_4 = _SHELL.getMyPlayerId();
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("CoinAnimation", "coinanimation_mc", _stage.getNextHighestDepth());
            _stage.coinanimation_mc._x = _local_3._x;
            _stage.coinanimation_mc._y = _local_3._y;
            _stage.coinanimation_mc._xscale = 70;
            _stage.coinanimation_mc._yscale = 70;
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkTargetDelegate);
            clearInterval(_secondCheckIntervalID);
        }
        function newplayerexperiencecomplete() {
            _SHELL.sendOpenAS3Module("courtyard_sensei", null, {modalBackgroundEnabled:false, hideLoadingDialog:true});
        }
        static var CLASS_NAME = "DojoExterior";
        static var FIRE = "fire";
        static var WATER = "water";
        static var SNOW = "snow";
        static var STARTER_DECK_ITEM_ID_VANILLA = 821;
        static var STARTER_DECK_ITEM_ID_FIRE = 8006;
        static var STARTER_DECK_ITEM_ID_WATER = 8010;
        static var STARTER_DECK_ITEM_ID_SNOW = 8011;
        static var TUSK_CAPE_ITEM = 3160;
        static var START_TASK_ID = 13;
        static var NINJA_PROGRESS_UI = "ninjaProgress";
        static var ONE_SECOND = 1000;
        var _TriviaBoardTurnedOn = true;
    }
