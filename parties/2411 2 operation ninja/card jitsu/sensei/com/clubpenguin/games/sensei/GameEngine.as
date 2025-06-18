//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.sensei.GameEngine
    {
        static var instance;
        var movie, dLearningManager, menu_paused, mouse_disabled, roomId, menuSystem, widget_mc;
        function GameEngine (movieClip) {
            movie = movieClip;
            if (!instance) {
                instance = this;
            }
            var listener = new Object();
            listener.onLoadComplete = function () {
                com.clubpenguin.util.Loader.removeEventListener(listener);
                com.clubpenguin.games.sensei.GameEngine.instance.init();
            };
            com.clubpenguin.util.Loader.addEventListener(listener);
            dLearningManager = new com.disney.dlearning.games.cardjitsu.DLearning(SHELL.getMyPlayerId());
        }
        function init() {
            menu_paused = undefined;
            mouse_disabled = false;
            roomId = SHELL.getCurrentServerRoomId();
            addAirtowerListeners();
            movie.closeBtn.onRelease = com.clubpenguin.util.Delegate.create(this, closeGame);
            menuSystem = new com.clubpenguin.games.sensei.MenuSystem(this, movie[MENUS_MOVIECLIP]);
        }
        function closeGame() {
            terminate();
            var _local_3 = _global.getCurrentShell();
            _local_3.sendJoinLastRoom();
        }
        function terminate() {
            removeAirtowerListeners();
            showWidget(false);
        }
        function handleButtonClick($menuOption) {
            menuSystem.handleClick($menuOption);
        }
        function handleMouseOver($menuOption) {
            if (!mouse_disabled) {
                menuSystem.handleMouseOver($menuOption);
            }
        }
        function loadMenu($menu) {
            menuSystem.loadMenu($menu);
        }
        function pauseMenu(menu) {
            com.clubpenguin.util.Debug.log("[pauseMenu]");
            menu_paused = menu;
            mouse_disabled = true;
            menuSystem.hideSpeechBubble();
            menuSystem.hideMenuOptions();
            menuSystem.hideAnimation();
            movie[MENUS_MOVIECLIP].sensei.gotoAndStop("wait");
        }
        function resumeMenu() {
            com.clubpenguin.util.Debug.log("[resumeMenu]");
            menuSystem.loadMenu(menu_paused);
            menu_paused = undefined;
            mouse_disabled = false;
        }
        function showWidget(show) {
            if (show) {
                if (!widget_mc) {
                    widget_mc = movie.attachMovie("widget", "widget_mc", movie.getNextHighestDepth(), {_x:400, _y:125});
                }
                initWidget();
            } else {
                widget_mc.removeMovieClip();
                widget_mc = undefined;
            }
        }
        function initWidget() {
            widget_mc.close_btn.onRelease = com.clubpenguin.util.Delegate.create(this, closeWidget);
            widget_mc.background_mc.onPress = function () {
                this._parent.startDrag();
            };
            widget_mc.background_mc.onRelease = function () {
                this._parent.stopDrag();
            };
            widget_mc.background_mc.useHandCursor = false;
            widget_mc.time_txt.text = "";
            widget_mc.loading_mc._visible = false;
            widget_mc.message_txt.text = "";
            widget_mc.item0_mc.name_text.text = "";
            widget_mc.item1_mc.name_text.text = "";
            widget_mc.item0_mc.icon_mc.gotoAndStop("Wait");
            widget_mc.item1_mc.icon_mc.gotoAndStop("Wait");
        }
        function closeWidget() {
            com.clubpenguin.util.Debug.log("[closeWidget]");
            resumeMenu();
            sendLeaveMatchMaking();
        }
        function updateWidget(timer, player0, player1, msg) {
            com.clubpenguin.util.Debug.log((((((("updateWidget - timer: " + timer) + " | player0: ") + player0) + " | player1: ") + player1) + " | msg: ") + msg);
            if (timer >= 0) {
                widget_mc.time_txt.text = timer;
                widget_mc.loading_mc._visible = true;
            } else {
                widget_mc.time_txt.text = "";
                widget_mc.loading_mc._visible = false;
            }
            if (player0) {
                if ((widget_mc.item0_mc.name_txt.text == "") || (widget_mc.item0_mc.name_txt.text == player0)) {
                    widget_mc.item0_mc.name_txt.text = player0;
                    widget_mc.item0_mc.icon_mc.gotoAndStop("Player");
                } else {
                    widget_mc.item1_mc.name_txt.text = player0;
                    widget_mc.item1_mc.icon_mc.gotoAndStop("Player");
                }
            }
            if (player1) {
                if ((widget_mc.item1_mc.name_txt.text == "") || (widget_mc.item1_mc.name_txt.text == player1)) {
                    widget_mc.item1_mc.name_txt.text = player1;
                    widget_mc.item1_mc.icon_mc.gotoAndStop("Player");
                } else {
                    widget_mc.item0_mc.name_txt.text = player1;
                    widget_mc.item0_mc.icon_mc.gotoAndStop("Player");
                }
            }
            if (msg) {
                widget_mc.message_txt.text = msg;
            } else {
                widget_mc.message_txt.text = "";
            }
        }
        function sendJoinSensei() {
            com.clubpenguin.util.Debug.log("sendJoinSensei");
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_JOIN_SEN, [], SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function sendJoinMatchMaking() {
            com.clubpenguin.util.Debug.log("sendJoinMatchMaking");
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_JOIN_MM, [], SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function sendLeaveMatchMaking() {
            com.clubpenguin.util.Debug.log("sendLeaveMatchMaking");
            showWidget(false);
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_LEAVE_MM, [], SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function handleJoinMatchMaking(resObj) {
            com.clubpenguin.util.Debug.log("handleJoinMatchMaking - resObj: " + resObj);
            resObj.shift();
            var _local_3 = resObj.shift();
            showWidget(true);
            updateWidget(-1, _local_3, null, com.clubpenguin.util.LocaleText.getText("widget_wait"));
        }
        function handleTickMatchMaking(resObj) {
            com.clubpenguin.util.Debug.log("handleTickMatchMaking - resObj: " + resObj);
            resObj.shift();
            var _local_3 = resObj.shift();
            if (_local_3 == -1) {
                var _local_5 = resObj.shift();
                var _local_4 = resObj.shift();
            }
            if ((_local_3 == -1) && (!_local_4)) {
                var _local_6 = com.clubpenguin.util.LocaleText.getText("widget_wait");
            }
            updateWidget(_local_3, _local_5, _local_4, _local_6);
        }
        function handleLeaveMatchMaking(resObj) {
        }
        function handleStartCard(resObj) {
            resObj.push("1");
            var _local_4 = Array(resObj);
            trace("TEMP OBJ IS " + _local_4);
            var _local_2 = new com.clubpenguin.util.Sequence();
            _local_2.addDelay(250);
            _local_2.addFunction({i:this, f:"terminate", p:[]});
            _local_2.addFunction({i:SHELL, f:"startWaddle", p:[resObj]});
        }
        function addAirtowerListeners() {
            AIRTOWER.addListener(MESSAGE_JOIN_MM, handleJoinMatchMaking, this);
            AIRTOWER.addListener(MESSAGE_TICK_MM, handleTickMatchMaking, this);
            AIRTOWER.addListener(MESSAGE_LEAVE_MM, handleLeaveMatchMaking, this);
            AIRTOWER.addListener(MESSAGE_START_CARD, handleStartCard, this);
        }
        function removeAirtowerListeners() {
            AIRTOWER.removeListener(MESSAGE_JOIN_MM, handleJoinMatchMaking, this);
            AIRTOWER.removeListener(MESSAGE_TICK_MM, handleTickMatchMaking, this);
            AIRTOWER.removeListener(MESSAGE_LEAVE_MM, handleLeaveMatchMaking, this);
            AIRTOWER.removeListener(MESSAGE_START_CARD, handleStartCard, this);
        }
        static var AIRTOWER = _global.getCurrentAirtower();
        static var INTERFACE = _global.getCurrentInterface();
        static var ENGINE = _global.getCurrentEngine();
        static var SHELL = _global.getCurrentShell();
        static var SERVER_SIDE_EXTENSION_NAME = "z";
        static var SERVER_SIDE_MESSAGE_TYPE = "str";
        static var MESSAGE_JOIN_SEN = "jsen";
        static var MESSAGE_JOIN_MM = "jmm";
        static var MESSAGE_TICK_MM = "tmm";
        static var MESSAGE_LEAVE_MM = "lmm";
        static var MESSAGE_START_CARD = "scard";
        static var MENUS_MOVIECLIP = "menus";
    }
