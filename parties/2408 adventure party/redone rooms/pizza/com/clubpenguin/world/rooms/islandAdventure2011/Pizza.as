//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.islandAdventure2011.Pizza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, setupHint, _SHELL, _ENGINE, _destroyDelegate, _table0, _table1, _table2, _table3;
        function Pizza (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 390;
            _stage.start_y = 290;
            localize([_stage.background_mc.elements.kitchen_mc, _stage.background_mc.pizzanote_mc.barrels.barrelpaper_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 390, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizzatron_btn, 200, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.redChairButton, 587, 281), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.blueChairButton, 663, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.ladderChair1Button, 482, 209), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.ladderChair2Button, 538, 209)]);
            _stage.redChairButton.useHandCursor = false;
            _stage.blueChairButton.useHandCursor = false;
            _stage.ladderChair1Button.useHandCursor = false;
            _stage.ladderChair2Button.useHandCursor = false;
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.background_mc.pizzanote_mc.pizzanote_btn, true, "party_note01", "")]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.pizzatron_btn, _stage.background_mc.pizzatron_btn, "pizzatron_hint")]);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitBack);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPizza);
            if (_SHELL == undefined) {
                init();
            }
        }
        function exitBack() {
            _SHELL.sendJoinRoom("plaza", 555, 290);
        }
        function exitPizza() {
            _ENGINE.sendJoinGame("pizzatron", true);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            playerHasItem = _SHELL.isItemInMyInventory(FINAL_ITEM);
            if (_SHELL == undefined) {
                playerHasItem = true;
            }
            if (playerHasItem) {
                var _local_2 = {_x:_stage.table2.decorationInit._x, _y:_stage.table2.decorationInit._y};
                _stage.background_mc.pizzanote_mc.gotoAndStop("appear");
                _stage.table0.bottles.gotoAndStop("appear");
                _stage.table1.bottles.gotoAndStop("appear");
                _stage.table2.attachMovie("table3Bottles", "decoration", _stage.table2.getNextHighestDepth(), _local_2);
            }
            _table0 = new com.clubpenguin.world.rooms.common.WaitedTable(true, false, false, false, false, _stage.table0, _stage.triggers_mc.waiter0, [_stage.triggers_mc.seat00, _stage.triggers_mc.seat01, _stage.triggers_mc.seat02, _stage.triggers_mc.seat03, _stage.triggers_mc.seat04, _stage.triggers_mc.seat05]);
            _table1 = new com.clubpenguin.world.rooms.common.WaitedTable(true, false, false, false, false, _stage.table1, _stage.triggers_mc.waiter1, [_stage.triggers_mc.seat10, _stage.triggers_mc.seat11, _stage.triggers_mc.seat12, _stage.triggers_mc.seat13, _stage.triggers_mc.seat14, _stage.triggers_mc.seat15]);
            _table2 = new com.clubpenguin.world.rooms.common.WaitedTable(true, false, false, false, false, _stage.table2, _stage.triggers_mc.waiter2, [_stage.triggers_mc.seat20, _stage.triggers_mc.seat21]);
            _table3 = new com.clubpenguin.world.rooms.common.WaitedTable(true, false, false, false, false, _stage.table3, _stage.triggers_mc.waiter3, [_stage.triggers_mc.seat30, _stage.triggers_mc.seat31]);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _table0.destroy();
            _table1.destroy();
            _table2.destroy();
            _table3.destroy();
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        var FINAL_ITEM = 1283;
        var playerHasItem = false;
    }
