//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.PhoneMediator
    {
        var view, context, commandRoomTip, currentRoomService, epfService, layoutChanged, roomCrumbs, closeTweenCompleteDelegate, appMenuMediator, agentStatusMediator, teleportMediator, gadgetsMediator, missionMediator, puffleMediator, recruitMediator, communicationMediator, currentApp, openedToCatalog, missionState, _layout, _state;
        function PhoneMediator (view, context) {
            this.view = view;
            this.view.body.onPress = null;
            this.view.body.useHandCursor = false;
            this.context = context;
            commandRoomTip = context.languageCrumbs.agentcom;
            currentRoomService = context.currentRoomService;
            currentRoomService.roomJoined.add(closePhone, this);
            epfService = context.epfService;
            epfService.missionStateUpdated.add(onMissionStateUpdated, this);
            onMissionStateUpdated();
            layoutChanged = context.layoutChanged;
            context.phoneOpened.add(openPhone, this);
            roomCrumbs = context.roomCrumbs;
            setupAppMenu(context.player, context.languageCrumbs);
            setupApps(context);
            com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED.x = view._x - 15;
            com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED.y = view._y - 15;
            com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED.scale = view._xscale;
            setupListeners();
            closeTweenCompleteDelegate = com.clubpenguin.util.Delegate.create(this, onCloseTweenComplete);
            changeState(com.clubpenguin.hud.phone.model.PhoneState.CLOSED);
        }
        function setupAppMenu(player, languageCrumbs) {
            appMenuMediator = new com.clubpenguin.hud.phone.mediator.AppMenuMediator(context, view.appMenu, player, languageCrumbs);
            appMenuMediator.iconPressed.add(onIconPressed, this);
        }
        function setupApps(context) {
            context.appClosed.add(onAppClosed, this);
            agentStatusMediator = new com.clubpenguin.hud.phone.mediator.AgentStatusMediator(view.agentStatus, context);
            teleportMediator = new com.clubpenguin.hud.phone.mediator.TeleportMediator(view.teleport, context);
            gadgetsMediator = new com.clubpenguin.hud.phone.mediator.GadgetsMediator(view.gadgets, context);
            missionMediator = new com.clubpenguin.hud.phone.mediator.MissionMediator(view.mission, context);
            puffleMediator = new com.clubpenguin.hud.phone.mediator.PuffleMediator(view.puffle, context);
            puffleMediator.puffleEquipped.add(closePhone, this);
            recruitMediator = new com.clubpenguin.hud.phone.mediator.AppMediator(view.recruit, context.appClosed, context.languageCode);
            communicationMediator = new com.clubpenguin.hud.phone.mediator.CommunicationMediator(view.communication, context);
        }
        function setupListeners() {
            view.rightCloseButton.onPress = (view.leftCloseButton.onPress = com.clubpenguin.util.Delegate.create(this, onCloseButtonPress));
            view.homeButton.onRelease = com.clubpenguin.util.Delegate.create(this, onHomeButtonPressed);
            view.bezel.onPress = com.clubpenguin.util.Delegate.create(this, onBezelPress);
            view.bezel.onRelease = (view.bezel.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, onBezelRelease));
        }
        function onIconPressed(iconID) {
            changeState(com.clubpenguin.hud.phone.model.PhoneState.getStateByIconID(iconID));
        }
        function openApp(appID) {
            currentApp.close();
            currentApp = view[appID];
            currentApp.open();
        }
        function openAgentStatus() {
            changeState(com.clubpenguin.hud.phone.model.PhoneState.AGENT_STATUS);
        }
        function onAppClosed(appID) {
            if (openedToCatalog) {
                closePhone();
            } else {
                changeState(com.clubpenguin.hud.phone.model.PhoneState.APP_MENU);
            }
        }
        function onHomeButtonPressed() {
            if (!isHomeButtonEnabled) {
                return(undefined);
            }
            isHomeButtonEnabled = false;
            if (context.isUserCurrentlyInRoom(roomCrumbs[COMMAND_ROOM_KEY].room_id)) {
            } else {
                teleportMediator.cancelTeleport();
                view.hideAllViews();
                changeState(com.clubpenguin.hud.phone.model.PhoneState.CLOSING);
                currentRoomService.joinRoom(roomCrumbs[COMMAND_ROOM_KEY].room_id, COMMAND_ROOM_SPAWN_X, COMMAND_ROOM_SPAWN_Y);
            }
        }
        function closePhone() {
            view.hideAllViews();
            changeState(com.clubpenguin.hud.phone.model.PhoneState.CLOSING);
        }
        function onCloseButtonPress() {
            closePhone();
        }
        function openPhone() {
            context.SHELL.hideTriggers();
            openedToCatalog = false;
            if (context.openInComChannel) {
                changeState(com.clubpenguin.hud.phone.model.PhoneState.COMMUNICATION);
            } else {
                changeState(com.clubpenguin.hud.phone.model.PhoneState.APP_MENU);
            }
        }
        function openPhoneCatalog() {
            openedToCatalog = true;
            changeState(com.clubpenguin.hud.phone.model.PhoneState.AGENT_STATUS);
        }
        function onCloseTweenComplete() {
            changeState(com.clubpenguin.hud.phone.model.PhoneState.CLOSED);
            context.phoneClosed.dispatch();
        }
        function onMissionStateUpdated() {
            missionState = epfService.getMissionState();
        }
        function animatePhoneTo(newLayout) {
            if (_layout == newLayout) {
                return(undefined);
            }
            _layout = newLayout;
            view._visible = true;
            switch (_layout) {
                case com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE : 
                    view.hideDistortion();
                    view.leftCloseButton._visible = true;
                    view.rightCloseButton._visible = false;
                case com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE_LARGE : 
                    view.hideDistortion();
                    context.SHELL.sendAS3StopNotificationServices();
                    break;
                case com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT : 
                    if (context.roomViewPaused) {
                        context.unpauseRoomView();
                    }
                    view.showDistortion();
                    view.leftCloseButton._visible = false;
                    view.rightCloseButton._visible = true;
                    context.SHELL.sendAS3StartNotificationServices();
                    break;
                case com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED : 
            }
            if (_layout.draggable) {
                enableDrag();
            } else {
                disableDrag();
            }
            layoutChanged.dispatch(_layout);
            var _local_2 = _layout.tweenProperties;
            if (_state == com.clubpenguin.hud.phone.model.PhoneState.CLOSING) {
                _local_2.onComplete = closeTweenCompleteDelegate;
            }
            com.clubpenguin.engine.tweener.Tweener.removeTweens(view);
            com.clubpenguin.engine.tweener.Tweener.addTween(view, _local_2);
        }
        function changeState(newState) {
            if (_state == newState) {
                return(undefined);
            }
            switch (newState) {
                case com.clubpenguin.hud.phone.model.PhoneState.CLOSING : 
                    if (context.roomViewPaused) {
                        context.unpauseRoomView();
                    }
                    if (_state == com.clubpenguin.hud.phone.model.PhoneState.CLOSED) {
                        return(undefined);
                    }
                    currentApp.close();
                    break;
                case com.clubpenguin.hud.phone.model.PhoneState.CLOSED : 
                    view.hideAllViews();
                    view._visible = false;
                    currentApp.close();
                    currentApp = view[com.clubpenguin.hud.phone.model.PhoneState.APP_MENU.viewID];
                    break;
                case com.clubpenguin.hud.phone.model.PhoneState.APP_MENU : 
                    appMenuMediator.initView(view.appMenu);
                    isHomeButtonEnabled = true;
                    openApp(newState.viewID);
                    break;
                case com.clubpenguin.hud.phone.model.PhoneState.AGENT_STATUS : 
                    agentStatusMediator.initView(view.agentStatus);
                    view.hideAppMenu();
                    isHomeButtonEnabled = true;
                    openApp(newState.viewID);
                    break;
                case com.clubpenguin.hud.phone.model.PhoneState.GADGETS : 
                case com.clubpenguin.hud.phone.model.PhoneState.TELEPORT : 
                case com.clubpenguin.hud.phone.model.PhoneState.RECRUIT : 
                case com.clubpenguin.hud.phone.model.PhoneState.MISSION : 
                case com.clubpenguin.hud.phone.model.PhoneState.COMMUNICATION : 
                    view.hideAppMenu();
                    isHomeButtonEnabled = true;
                    openApp(newState.viewID);
                    break;
                case com.clubpenguin.hud.phone.model.PhoneState.PUFFLE : 
                    if (!context.playerHasElitePuffleWhistle()) {
                        context.INTERFACE.showContent("puffle_whistle", null, null, {oopsTag:"game_pufflewhistle_mem"});
                        return(undefined);
                    }
                    isHomeButtonEnabled = true;
                    openApp(newState.viewID);
                    break;
                case com.clubpenguin.hud.phone.model.PhoneState.TELEPORTING : 
                    break;
            }
            _state = newState;
            if (_state != com.clubpenguin.hud.phone.model.PhoneState.CLOSED) {
                animatePhoneTo(_state.layout);
            }
        }
        function onSoftwareCloseButtonPress() {
            changeState(com.clubpenguin.hud.phone.model.PhoneState.APP_MENU);
        }
        function enableDrag() {
            view.bezel._visible = true;
        }
        function disableDrag() {
            view.bezel._visible = false;
        }
        function onBezelPress() {
            view.startDrag();
            view.onMouseMove = function () {
                updateAfterEvent();
            };
        }
        function onBezelRelease() {
            com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT.x = view._x;
            com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT.y = view._y;
            view.stopDrag();
            delete view.onMouseMove;
        }
        static var DELAYED_SERVICE_CALL_DURATION = 2000;
        static var COMMAND_ROOM_KEY = "agentcom";
        static var COMMAND_ROOM_SPAWN_X = 570;
        static var COMMAND_ROOM_SPAWN_Y = 150;
        var isHomeButtonEnabled = true;
    }
