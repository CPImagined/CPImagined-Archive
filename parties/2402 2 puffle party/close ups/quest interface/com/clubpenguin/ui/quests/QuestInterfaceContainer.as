//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.quests.QuestInterfaceContainer
    {
        var _view, _currentParty, PANEL_POSITION_X, _panelsAll, _buttonLeft, _buttonRight, _statusDisplay;
        function QuestInterfaceContainer (skin, state) {
            _view = skin;
            if ((state != undefined) && (state > 0)) {
                _state = state;
            }
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            PANEL_POSITION_X = _currentParty.CONSTANTS.PARTY_FEATURES.featureSettings.panelPositionsX;
            _panelsAll = _view.panel_container.panel_all;
            configurePanelScrolling();
            configurePanelViews();
            showInitialState();
        }
        function configurePanelScrolling() {
            _buttonLeft = _view.button_left;
            _buttonRight = _view.button_right;
            _statusDisplay = _view.statusdisplay;
            _buttonLeft.onRelease = com.clubpenguin.util.Delegate.create(this, buttonLeft_Click_Handler);
            _buttonRight.onRelease = com.clubpenguin.util.Delegate.create(this, buttonRight_Click_Handler);
        }
        function showInitialState() {
            changeState(_state, false);
        }
        function buttonLeft_Click_Handler() {
            var _local_2 = Math.max(1, _state - 1);
            if (_local_2 != _state) {
                changeState(_local_2, true);
            }
        }
        function buttonRight_Click_Handler() {
            var _local_2 = Math.min(_state + 1, PANEL_POSITION_X.length);
            if (_local_2 != _state) {
                changeState(_local_2, true);
            }
        }
        function changeState(stateNum, tween) {
            _state = stateNum;
            var _local_2 = PANEL_POSITION_X[_state - 1];
            _buttonLeft._visible = true;
            _buttonRight._visible = true;
            if (_state == 1) {
                _buttonLeft._visible = false;
            } else if (_state >= PANEL_POSITION_X.length) {
                _buttonRight._visible = false;
            }
            _buttonLeft.onRelease = null;
            _buttonRight.onRelease = null;
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
            if (_currentParty.getQuestVOs().length == undefined) {
                return(undefined);
            }
            var _local_2 = 0;
            while (_local_2 < _currentParty.getQuestVOs().length) {
                var _local_3 = com.clubpenguin.ui.quests.panels.PanelFactory.getQuestPanel(_panelsAll["panel_" + String(_local_2)], _local_2);
                _local_2++;
            }
        }
        function toString(arr) {
            var _local_1 = 0;
            while (_local_1 < (arr.length - 1)) {
                _local_1++;
            }
        }
        var PANEL_TWEEN_SPEED = 1;
        var _state = 1;
        var CLASS = "QuestInterfaceContainer";
    }
