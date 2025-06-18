//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.HUDIconMediator
    {
        var view, phoneOpened, context, currentState, _trackerAS2, onClick, onClickTimer, lastQuestState, onClickAction, callAction;
        function HUDIconMediator (hudIconView, context) {
			onClickAction = false;
            view = hudIconView;
            phoneOpened = context.phoneOpened;
            this.context = context;
            currentState = IDLE_FRAME;
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            context.phoneClosed.add(onPhoneClosed, this);
            context.epfService.comMessagesReceived.add(onComMessagesReceived, this);
            context.epfService.newComMessageReceived.add(onNewComMessageReceived, this);
            //context.epfService.missionStateUpdated.add(onMissionStateUpdated, this);
            //context.epfService.facetimeCallReceived.add(onFacetimeCallReceived, this);
            //context.SHELL.getPlayerEPFStatusChanged().add(onMissionStateUpdated, this);
            //if (context.epfService.isFacetimeCallWaiting()) {
                //var _local_3 = context.epfService.getWaitingFacetimeArgs();
                //onFacetimeCallReceived(_local_3[0], _local_3[1]);
            //}
			context.SHELL.getPlayerEPFStatusChanged().add(sendFacetimeCall, this);
			if(!_global.getCurrentParty().Trailblazer.getMessageViewed(0) && context.SHELL.isEPFAgent()) {
				sendFacetimeCall();
			};
            //context.SHELL.playerJoinedRoom.add(onPlayerJoinedRoom, this);
            view.onPress = com.clubpenguin.util.Delegate.create(this, onHudIconPressed);
            view.onRollOver = com.clubpenguin.util.Delegate.create(this, onHudIconRollOver);
            view.onRollOut = com.clubpenguin.util.Delegate.create(this, onHudIconRollOut);
            //onMissionStateUpdated();
        }
		function sendFacetimeCall() {
			receiveFacetimeCallAlert(_global.getCurrentParty().Trailblazer.CONSTANTS.LOGIN_FACETIME, false);
		}
        function onHudIconRollOver() {
            view.epf_icon_mc.gotoAndStop("_over");
        }
        function onHudIconRollOut() {
            view.epf_icon_mc.gotoAndStop("_up");
        }
        function onHudIconPressed() {
            onHudIconRollOut();
            if (onClickAction == true) {
                clearTimeout(onClickTimer);
                _global.getCurrentInterface().showContent(callAction);
                callAction = null;
				onClickAction = false;
            } else {
                view._visible = false;
                phoneOpened.dispatch();
            }
            if (currentState == MESSAGE_FRAME) {
                context.comNotificationQueued = false;
                context.openInComChannel = false;
            }
            view.gotoAndStop(IDLE_FRAME);
            currentState = IDLE_FRAME;
        }
        function onPlayerJoinedRoom() {
            if (((currentState != MESSAGE_FRAME) && (currentState != CALL_FRAME)) && (currentState != ALERT_FRAME)) {
                setCurrentState(IDLE_FRAME);
            }
        }
        function onPhoneClosed() {
            context.SHELL.showTriggers();
            view._visible = true;
            if (!context.ENGINE.isPlayerOnFieldOpTrigger()) {
                if (context.comNotificationQueued) {
                    setCurrentState(MESSAGE_FRAME);
                } else {
                    setCurrentState(IDLE_FRAME);
                }
            }
        }
        function onMissionStateUpdated() {
            var _local_2 = context.epfService.getMissionState();
            if (_local_2 == context.epfService.QUEST_STATE_MISSION_AVAILABLE) {
                if (currentState == IDLE_FRAME) {
                }
            } else if (currentState == ALERT_FRAME) {
                setCurrentState(IDLE_FRAME);
            }
            lastQuestState = _local_2;
        }
		function receiveFacetimeCall(action, autoAnswer) {
            setCurrentState(CALL_FRAME);
            callAction = action;
			onClickAction = true;
            if (autoAnswer) {
                onClickTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, onHudIconPressed), 3000);
            }
        }
		function receiveFacetimeCallAlert(action, autoAnswer) {
            setCurrentState(ALERT_FRAME);
            callAction = action;
			onClickAction = true;
            if (autoAnswer) {
                onClickTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, onHudIconPressed), 3000);
            }
        }
        function onFacetimeCallReceived(action, autoAnswer) {
            setCurrentState(CALL_FRAME);
            onClick = _global.getCurrentInterface().showContent(action);
            if (autoAnswer) {
                onClickTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, onHudIconPressed), 3000);
            }
        }
        function onComMessagesReceived(messages, isNewMessage) {
            if (isNewMessage) {
                onNewComMessageReceived(messages);
            }
        }
        function onNewComMessageReceived(messages) {
            if (currentState == IDLE_FRAME) {
                setCurrentState(MESSAGE_FRAME);
            } else {
                context.comNotificationQueued = true;
            }
        }
        function setCurrentState(frameState) {
            if ((currentState == MESSAGE_FRAME) && (frameState != MESSAGE_FRAME)) {
                context.openInComChannel = false;
                context.comNotificationQueued = true;
            }
            if (frameState == MESSAGE_FRAME) {
                context.openInComChannel = true;
            }
            currentState = frameState;
            view.gotoAndStop(frameState);
        }
        static var ALERT_FRAME = "alert";
        static var IDLE_FRAME = "idle";
        static var FIELDOP_FRAME = "fieldop";
        static var MESSAGE_FRAME = "newmission";
        static var CALL_FRAME = "message";
    }
