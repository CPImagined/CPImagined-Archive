//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.holiday2011.ForestCalendar extends com.clubpenguin.world.rooms.Forest
    {
        var _stage, localize, showContent, _SHELL, _today, _destroyDelegate, _opcodeJournal, _openDoorInterval, _INTERFACE;
        function ForestCalendar (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 380;
            _stage.start_y = 360;
            localize([_stage.house.sign, _stage.c4c_mc.sign_mc]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.c4c_mc.c4cButton, true, "coins_for_change", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.treesSide.bakerysign_mc.bakerysign_btn, true, "party_poster2", "")]);
            if (!_SHELL) {
                init();
            }
        }
        function exitPlaza() {
            _SHELL.sendJoinRoom("plaza", 710, 320);
        }
        function init() {
            var _local_2 = _SHELL.getPenguinStandardTime();
            if (!_local_2) {
                _local_2 = new Date();
            }
            _today = _local_2.getDate();
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            lightUpClips();
            _opcodeJournal = new com.clubpenguin.world.rooms.common.OpcodeJournal();
            var _local_3 = _SHELL.getMyPlayerId();
            _opcodeJournal.init(_local_3);
            _stage.house.door14.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 14);
            _stage.house.door15.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 15);
            _stage.house.door16.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 16);
            _stage.house.door17.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 17);
            _stage.house.door18.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 18);
            _stage.house.door19.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 19);
            _stage.house.door20.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 20);
            _stage.house.door21.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 21);
            _stage.house.door22.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 22);
            _stage.house.door23.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 23);
            _stage.house.door24.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 24);
            _stage.house.door25.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 25);
            _stage.c4c_mc.c4cButton.onRollOver = com.clubpenguin.util.Delegate.create(this, bucketActivate);
            _stage.c4c_mc.c4cButton.onRollOut = com.clubpenguin.util.Delegate.create(this, bucketDeactivate);
            _stage.c4c_mc.c4cButton.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, bucketDeactivate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_openDoorInterval);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        function bucketActivate() {
            _stage.c4c_mc.gotoAndPlay(18);
            _stage.c4c_mc.c4coutline_mc.gotoAndPlay(18);
        }
        function bucketDeactivate() {
            _stage.c4c_mc.c4coutline_mc.gotoAndStop(1);
        }
        function lightUpClips() {
            var _local_2 = todaysFrame();
            _stage.foreground_mc.lightsLeft.gotoAndStop(_local_2);
            _stage.foreground_mc.lightsRight.gotoAndStop(_local_2);
            _stage.house.day.gotoAndStop(_local_2);
            _stage.house.tree1.gotoAndStop(_local_2);
            _stage.house.tree2.gotoAndStop(_local_2);
            _stage.house.canes.gotoAndStop(_local_2);
            _stage.treesSide.tree1.gotoAndStop(_local_2);
            _stage.treesSide.tree2.gotoAndStop(_local_2);
            _stage.treesLeft.gotoAndStop(_local_2);
            _stage.foreground_mc.treeLights.gotoAndStop(_local_2);
        }
        function todaysFrame() {
            if (_today < FIRST_DAY) {
                return(PARK);
            } else if (_today >= LAST_DAY) {
                return(DAY + LAST_DAY);
            } else {
                return(DAY + _today);
            }
        }
        function doorClick(doorNumber) {
            if (_openDoorInterval) {
                return(undefined);
            }
            var _local_3 = _stage.house[DOOR + doorNumber];
            if (doorNumber == _today) {
                _stage.house.day._visible = false;
            }
            if (_today >= doorNumber) {
                var _local_4 = fetchItemID(doorNumber);
                var _local_5 = _stage.house[GLOW + doorNumber];
                openDoor(_local_3, _local_5, _local_4);
            } else {
                _local_3.gotoAndStop(DOOR_STATE_RATTLE);
                _INTERFACE.showContent(NOTE + doorNumber);
            }
        }
        function fetchItemID(doorNumber) {
            var _local_2;
            switch (doorNumber) {
                case 14 : 
                    _local_2 = DAY_14_ITEM;
                    if (_SHELL.isItemInMyInventory(_local_2)) {
                        _opcodeJournal.sendOpcodeHolidayForestTakesItem();
                    }
                    break;
                case 15 : 
                    _local_2 = DAY_15_ITEM;
                    break;
                case 16 : 
                    _local_2 = DAY_16_ITEM;
                    break;
                case 17 : 
                    _local_2 = DAY_17_ITEM;
                    break;
                case 18 : 
                    _local_2 = DAY_18_ITEM;
                    break;
                case 19 : 
                    _local_2 = DAY_19_ITEM;
                    break;
                case 20 : 
                    _local_2 = DAY_20_ITEM;
                    break;
                case 21 : 
                    _local_2 = DAY_21_ITEM;
                    break;
                case 22 : 
                    _local_2 = DAY_22_ITEM;
                    break;
                case 23 : 
                    _local_2 = DAY_23_ITEM;
                    break;
                case 24 : 
                    _local_2 = DAY_24_ITEM;
                    break;
                case 25 : 
                    _local_2 = DAY_25_ITEM;
                    break;
            }
            return(_local_2);
        }
        function openDoor(doorClip, glowClip, itemNumber) {
            if (_SHELL.isItemInMyInventory(itemNumber)) {
                doorClip.gotoAndStop(DOOR_STATE_RATTLE_GLOW);
            } else {
                doorClip.gotoAndStop(DOOR_STATE_OPEN);
                glowClip.gotoAndStop(DOOR_STATE_OPEN);
                _openDoorInterval = setInterval(com.clubpenguin.util.Delegate.create(this, awardItem, itemNumber), DOOR_OPEN_DELAY);
            }
        }
        function awardItem(item) {
            clearInterval(_openDoorInterval);
            _openDoorInterval = null;
            _INTERFACE.buyInventory(item);
        }
        static var CLASS_NAME = "ForestCalendar";
        static var PARK = "park";
        static var DAY = "day";
        static var DOOR = "door";
        static var GLOW = "glow";
        static var NOTE = "advent_note_dec";
        static var DOOR_STATE_OPEN = "open";
        static var DOOR_STATE_RATTLE = "rattle1";
        static var DOOR_STATE_RATTLE_GLOW = "rattle2";
        static var DOOR_OPEN_DELAY = 1000;
        static var FIRST_DAY = 14;
        static var LAST_DAY = 25;
        static var DAY_14_ITEM = 1333;
        static var DAY_15_ITEM = 9122;
        static var DAY_16_ITEM = 7093;
        static var DAY_17_ITEM = 1332;
        static var DAY_18_ITEM = 9123;
        static var DAY_19_ITEM = 7092;
        static var DAY_20_ITEM = 1334;
        static var DAY_21_ITEM = 9125;
        static var DAY_22_ITEM = 7091;
        static var DAY_23_ITEM = 1335;
        static var DAY_24_ITEM = 9124;
        static var DAY_25_ITEM = 4473;
    }
