//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.Soda extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, localize, setupNavigationButtons, TELEPORT_POINT_BARREL1, TELEPORT_POINT_BARREL2, TELEPORT_POINT_BARREL3, TELEPORT_POINT_BARREL4, TELEPORT_POINT_BARREL5, TELEPORT_POINT_BARREL7, TELEPORT_POINT_BARREL8, TELEPORT_POINT_BARREL9, TELEPORT_POINT_BARREL10, TELEPORT_POINT_BARREL11, TELEPORT_POINT_BARREL12, _SHELL, _currentPlayerID, _opcodeJournal, _destroyDelegate, _INTERFACE, _ENGINE;
        function Soda (stageReference) {
            super();
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 240;
            _stage.start_y = 420;
            localize([_stage.freesign_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelOne["button"], 90, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelTwo["button"], 180, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelThree["button"], 280, 340), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelFour["button"], 600, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelFive["button"], 720, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelSix["button"], 33, 156), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelSeven["button"], 143, 142), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelEight["button"], 510, 200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelNine["button"], 620, 195), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelTen["button"], 720, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelEleven["button"], 250, 40), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.barrelTwelve["button"], 630, 35), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boxBtn, 370, 420)]);
            _stage.barrelOne["button"].useHandCursor = false;
            _stage.barrelTwo["button"].useHandCursor = false;
            _stage.barrelThree["button"].useHandCursor = false;
            _stage.barrelFour["button"].useHandCursor = false;
            _stage.barrelFive["button"].useHandCursor = false;
            _stage.barrelSix["button"].useHandCursor = false;
            _stage.barrelSeven["button"].useHandCursor = false;
            _stage.barrelEight["button"].useHandCursor = false;
            _stage.barrelNine["button"].useHandCursor = false;
            _stage.barrelTen["button"].useHandCursor = false;
            _stage.barrelEleven["button"].useHandCursor = false;
            _stage.barrelTwelve["button"].useHandCursor = false;
            _stage.triggers_mc.boxDimension.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPortal);
            _stage.triggers_mc.pressurePlate.triggerFunction = com.clubpenguin.util.Delegate.create(this, mazeComplete);
            TELEPORT_POINT_BARREL1 = new flash.geom.Point(95, 350);
            TELEPORT_POINT_BARREL2 = new flash.geom.Point(180, 343);
            TELEPORT_POINT_BARREL3 = new flash.geom.Point(280, 350);
            TELEPORT_POINT_BARREL4 = new flash.geom.Point(600, 360);
            TELEPORT_POINT_BARREL5 = new flash.geom.Point(725, 365);
            TELEPORT_POINT_BARREL7 = new flash.geom.Point(145, 155);
            TELEPORT_POINT_BARREL8 = new flash.geom.Point(510, 220);
            TELEPORT_POINT_BARREL9 = new flash.geom.Point(615, 210);
            TELEPORT_POINT_BARREL10 = new flash.geom.Point(715, 210);
            TELEPORT_POINT_BARREL11 = new flash.geom.Point(250, 52);
            TELEPORT_POINT_BARREL12 = new flash.geom.Point(625, 55);
            _stage.triggers_mc.barrel1.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL10);
            _stage.triggers_mc.barrel2.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL11);
            _stage.triggers_mc.barrel3.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL5);
            _stage.triggers_mc.barrel4.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL8);
            _stage.triggers_mc.barrel5.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL1);
            _stage.triggers_mc.barrel6.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL3);
            _stage.triggers_mc.barrel7.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL12);
            _stage.triggers_mc.barrel8.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL7);
            _stage.triggers_mc.barrel9.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL2);
            _stage.triggers_mc.barrel10.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL9);
            _stage.triggers_mc.barrel11.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL4);
            _stage.triggers_mc.barrel12.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_BARREL3);
        }
        function exitPortal() {
            _SHELL.sendJoinRoom("boxdimension", 500, 332);
        }
        function init() {
            _currentPlayerID = _SHELL.getMyPlayerId();
            _opcodeJournal = new com.clubpenguin.world.rooms2012.aprilfools.OpcodeJournal();
            _opcodeJournal.init(_currentPlayerID);
            _stage.itemCage.itemBtn.onPress = com.clubpenguin.util.Delegate.create(this, getFreeItem, "1383");
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function getFreeItem(itemID) {
            _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.aprilfools.OpcodeJournal.BOX_HEAD_ITEM_EARNED);
            _INTERFACE.buyInventory(itemID);
        }
        function mazeComplete() {
            _stage.background_mc.pressurePlate.nextFrame();
            _stage.itemCage.play();
            _SHELL.stampEarned(PUZZLE_SOLVER_STAMP_ID);
        }
        function teleport(XY) {
            var _local_3 = 50;
            _ENGINE.sendPlayerTeleportAndMove(XY.x, XY.y, XY.x, XY.y + _local_3);
        }
        function onFoundHandler() {
            _stage.itemCage.itemBtn._visible = false;
        }
        function alreadyFoundHandler() {
            _stage.itemCage.itemBtn._visible = false;
            _stage.itemCage.stop();
            _stage.background_mc.pressurePlate.gotoAndStop(_stage.background_mc.pressurePlate._totalframes);
            _stage.itemCage.fakeItem._visible = false;
        }
        static var CLASS_NAME = "Soda";
        static var PUZZLE_SOLVER_STAMP_ID = 183;
    }
