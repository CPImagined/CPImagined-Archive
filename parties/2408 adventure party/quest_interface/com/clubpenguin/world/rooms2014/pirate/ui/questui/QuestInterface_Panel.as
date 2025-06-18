//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.ui.questui.QuestInterface_Panel
    {
        var _view, _buttonLeft, _buttonRight, _statusDisplay, _panelsAll;
        function QuestInterface_Panel (skin) {
            _view = skin;
            _buttonLeft = _view._parent.button_left;
            _buttonRight = _view._parent.button_right;
            _statusDisplay = _view.statusdisplay;
            _buttonLeft.onRelease = com.clubpenguin.util.Delegate.create(this, buttonLeft_Click_Handler);
            _buttonRight.onRelease = com.clubpenguin.util.Delegate.create(this, buttonRight_Click_Handler);
            configurePanelViews();
            showInitialState();
        }
        function showInitialState() {
            var _local_3 = Number(_global.getCurrentShell().getCurrentRoomId());
            if (_local_3 == com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.CRAB_BATTLE_ROOM_ID) {
                _local_3 = Number(_global.getCurrentShell().getLastRoomId());
            }
            switch (_local_3) {
                case com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.ROOM_ID_BEACH : 
                case com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.ROOM_ID_DOCK : 
                    _state = 1;
                    break;
                case com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.ROOM_ID_TOWN : 
                case com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.ROOM_ID_FORTS : 
                case com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.ROOM_ID_PLAZA : 
                    _state = 2;
                    break;
                case com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.ROOM_ID_FOREST : 
                case com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.ROOM_ID_COVE : 
                    _state = 3;
                    break;
                default : 
                    _state = 1;
            }
            if (!com.clubpenguin.world.rooms2014.pirate.party.PirateParty.partyCookie.didCompleteAtLeastOneTask) {
                _state = 1;
            }
            changeState(_state, false);
        }
        function buttonLeft_Click_Handler() {
            trace("QuestInterface_Panel.buttonLeft_Click_Handler _state " + _state);
            var _local_2 = Math.max(_state - 1, 1);
            if (_local_2 != _state) {
                com.clubpenguin.world.rooms2014.pirate.party.PirateParty.playSound(_view, "sfx_scroll_" + random(3));
                changeState(_local_2, true);
            }
        }
        function buttonRight_Click_Handler() {
            trace("QuestInterface_Panel.buttonRight_Click_Handler");
            var _local_2 = Math.min(_state + 1, 5);
            if (_local_2 != _state) {
                com.clubpenguin.world.rooms2014.pirate.party.PirateParty.playSound(_view, "sfx_scroll_" + random(3));
                changeState(_local_2, true);
            }
        }
        function changeState(stateNum, tween) {
            trace("changeState stateNum " + stateNum);
            _state = stateNum;
            var _local_2 = PANEL_POSITION_2;
            switch (stateNum) {
                case 1 : 
                    _local_2 = PANEL_POSITION_1;
                    _buttonLeft._visible = false;
                    _buttonRight._visible = true;
                    break;
                case 2 : 
                    _local_2 = PANEL_POSITION_2;
                    _buttonLeft._visible = true;
                    _buttonRight._visible = true;
                    break;
                case 3 : 
                    _local_2 = PANEL_POSITION_3;
                    _buttonLeft._visible = true;
                    _buttonRight._visible = false;
                    break;
            }
            _buttonLeft.onRelease = null;
            _buttonRight.onRelease = null;
            trace((((("QuestInterface_Panel.changeState: " + stateNum) + " ") + _local_2) + " ") + tween);
            if (tween) {
                com.greensock.TweenMax.to(_panelsAll, PANEL_TWEEN_SPEED, {_x:_local_2, onComplete:com.clubpenguin.util.Delegate.create(this, changeState_Complete_Handler)});
            } else {
                _panelsAll._x = _local_2;
                changeState_Complete_Handler();
            }
        }
        function changeState_Complete_Handler() {
            _buttonLeft.onRelease = com.clubpenguin.util.Delegate.create(this, buttonLeft_Click_Handler);
            _buttonRight.onRelease = com.clubpenguin.util.Delegate.create(this, buttonRight_Click_Handler);
            _statusDisplay.gotoAndStop(_state);
        }
        function configurePanelViews() {
            _panelsAll = _view.panel_container.panel_all;
            var _local_5 = new com.clubpenguin.ui.itembuttons.BuyItemVendingMachine();
            var _local_2 = 0;
            while (_local_2 < com.clubpenguin.world.rooms2014.pirate.party.PirateParty.questVOs.length) {
                var _local_3 = com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyQuestVO(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.questVOs[_local_2]);
                var _local_4 = new com.clubpenguin.world.rooms2014.pirate.ui.questui.panels.QuestInterface_Panel_Quest(_view.panel_container.panel_all["panel_" + (_local_2 + 2)], _local_3.roomId, _local_5);
                _local_2++;
            }
        }
        var PANEL_POSITION_1 = -818.35;
        var PANEL_POSITION_2 = -1595.35;
        var PANEL_POSITION_3 = -2325.3;
        var PANEL_POSITION_4 = -3088.3;
        var PANEL_POSITION_5 = -3938.3;
        var PANEL_TWEEN_SPEED = 1;
        var _state = 1;
    }
