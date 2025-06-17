//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.ui.questui.QuestInterface_Panel
    {
        var _view, _buttonLeft, _buttonRight, _panelsAll;
        function QuestInterface_Panel (skin) {
            trace(("QuestInterface_Panel( SKIN: " + skin) + ") !!!");
            _view = skin;
            _buttonLeft = _view._parent.button_left;
            _buttonRight = _view._parent.button_right;
            _buttonLeft.onRelease = com.clubpenguin.util.Delegate.create(this, buttonLeft_Click_Handler);
            _buttonRight.onRelease = com.clubpenguin.util.Delegate.create(this, buttonRight_Click_Handler);
            _panelsAll = _view.panel_all;
            configurePanelViews();
            showInitialState();
        }
        function showInitialState() {
            trace("QuestInterface_Panel.showInitialState()");
            changeState(_state, false);
        }
        function buttonLeft_Click_Handler() {
            var _local_2 = Math.max(_state - 1, 1);
            if (_local_2 != _state) {
                changeState(_local_2, true);
            }
        }
        function buttonRight_Click_Handler() {
            var _local_2 = Math.min(_state + 1, 5);
            if (_local_2 != _state) {
                changeState(_local_2, true);
            }
        }
        function changeState(stateNum, tween) {
            trace((("QuestInterface_Panel.changeState() - stateNum : " + stateNum) + " / tween : ") + tween);
            _state = stateNum;
            var _local_2 = PANEL_POSITION_1;
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
                    _buttonRight._visible = true;
                    break;
                case 4 : 
                    _local_2 = PANEL_POSITION_4;
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
        }
        function configurePanelViews() {
            trace("_view : " + _view.panel_all.panel_1);
            var _local_5 = new com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel1(_view.panel_all.panel1);
            var _local_4 = new com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel2(_view.panel_all.panel2);
            var _local_3 = new com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel3(_view.panel_all.panel3);
            var _local_2 = new com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel4(_view.panel_all.panel4);
        }
        function toString(arr) {
            var _local_1 = 0;
            while (_local_1 < (arr.length - 1)) {
                trace(arr[_local_1]);
                _local_1++;
            }
        }
        var PANEL_POSITION_1 = 1411.35;
        var PANEL_POSITION_2 = 806.35;
        var PANEL_POSITION_3 = 203.35;
        var PANEL_POSITION_4 = -403.35;
        var PANEL_TWEEN_SPEED = 1;
        var _state = 1;
    }
