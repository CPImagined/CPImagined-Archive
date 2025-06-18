//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.HolidayCalendar
    {
        var _stage, _SHELL, _today, _destroyDelegate, _openDoorInterval, _INTERFACE, _AIRTOWER, _showPrompt;
        function HolidayCalendar (stageReference) {
            super(stageReference);
			_AIRTOWER = _global.getCurrentAirtower();
            _stage = stageReference;
			_SHELL = _global.getCurrentShell();
            init();
        }
		function showAddedPrompt(obj) {
			obj.shift();
			var _local_5 = _SHELL.getLocalizedString("buy_inventory_done");
			_local_5 = _INTERFACE.replaceString("%name%", obj[0], _local_5);
			_INTERFACE.showPrompt("ok", _local_5);
			trace("prompt shown");
		}
		function init() {
			trace("ehehehheheheheeeheheee (init)");
            var _local_2 = _SHELL.getPenguinStandardTime();
            if (!_local_2) {
                _local_2 = new Date();
            }
            _today = _local_2.getDate();
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_AIRTOWER.addListener("holidayprompt", _showPrompt);
			_showPrompt = com.clubpenguin.util.Delegate.create(this, showAddedPrompt);
            var _local_3 = _SHELL.getMyPlayerId();
            _stage.background_mc.house.door14.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 14);
            _stage.background_mc.house.door15.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 15);
            _stage.background_mc.house.door16.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 16);
            _stage.background_mc.house.door17.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 17);
            _stage.background_mc.house.door18.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 18);
            _stage.background_mc.house.door19.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 19);
            _stage.background_mc.house.door20.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 20);
            _stage.background_mc.house.door21.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 21);
            _stage.background_mc.house.door22.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 22);
            _stage.background_mc.house.door23.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 23);
            _stage.background_mc.house.door24.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 24);
            _stage.background_mc.house.door25.onRelease = com.clubpenguin.util.Delegate.create(this, doorClick, 25);
			trace("buttons set");
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_AIRTOWER.removeListener("holidayprompt", _showPrompt);
            clearInterval(_openDoorInterval);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
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
			trace("Door clicked: " + doorNumber);
            if (_openDoorInterval) {
				trace("_openDoorInterval in progress");
                return(undefined);
            }
            var _local_3 = _stage.background_mc.house[DOOR + doorNumber];
			trace("Door clip: " + _local_3);
            if (doorNumber == _today) {
                _stage.background_mc.house.day._visible = false;
            }
            if (_today >= doorNumber) {
                var _local_4 = fetchItemID(doorNumber);
				var _local_7 = fetchItemType(doorNumber);
                var _local_5 = _stage.background_mc.house[GLOW + doorNumber];
                openDoor(_local_3, _local_5, _local_4, _local_7);
				trace("door number higher than today");
            } else {
                _local_3.gotoAndStop(DOOR_STATE_RATTLE);
				trace("lmao get rekt");
            }
        }
        function fetchItemID(doorNumber) {
            var _local_2;
            switch (doorNumber) {
                case 14 : 
                    _local_2 = DAY_14_ITEM;
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
			trace("Item ID: " + _local_2 + " (Door passed: " + doorNumber + ")");
            return(_local_2);
        }
		function fetchItemType(doorNumber) {
            var _local_2;
            switch (doorNumber) {
                case 14 : 
                    _local_2 = TYPE_ITEM;
                    break;
                case 15 : 
                    _local_2 = TYPE_ITEM;
                    break;
                case 16 : 
                    _local_2 = TYPE_ITEM;
                    break;
                case 17 : 
                    _local_2 = TYPE_FURN;
                    break;
                case 18 : 
                    _local_2 = TYPE_ITEM;
                    break;
                case 19 : 
                    _local_2 = TYPE_PUFF;
                    break;
                case 20 : 
                    _local_2 = TYPE_ITEM;
                    break;
                case 21 : 
                    _local_2 = TYPE_FURN;
                    break;
                case 22 : 
                    _local_2 = TYPE_FURN;
                    break;
                case 23 : 
                    _local_2 = TYPE_FURN;
                    break;
                case 24 : 
                    _local_2 = TYPE_IGGY;
                    break;
                case 25 : 
                    _local_2 = TYPE_LOCO;
                    break;
            }
			trace("Item type: " + _local_2 + " (Door passed: " + doorNumber);
            return(_local_2);
        }
        function openDoor(doorClip, glowClip, itemNumber, itemType) {
            doorClip.gotoAndStop(DOOR_STATE_OPEN);
            glowClip.gotoAndStop(DOOR_STATE_OPEN);
            _openDoorInterval = setInterval(com.clubpenguin.util.Delegate.create(this, awardItem, itemNumber, itemType), DOOR_OPEN_DELAY);
			trace("_openDoorInterval set");
        }
        function awardItem(item, type) {
            clearInterval(_openDoorInterval);
            _openDoorInterval = null;
			switch(type) {
				case TYPE_ITEM :
					trace("Item bought: " + item);
					_AIRTOWER.send(_AIRTOWER.PLAY_EXT, "i#calendaritem", [item], "str", _SHELL.getCurrentServerRoomId());
					break;
				case TYPE_FURN :
					trace("Furniture bought: " + item);
					_AIRTOWER.send(_AIRTOWER.PLAY_EXT, "i#calendarfurn", [item], "str", _SHELL.getCurrentServerRoomId());
					break;
				case TYPE_PUFF :
					trace("Puffle item bought: " + item);
					_INTERFACE.buyPuffleItem(item)
					break;
				case TYPE_IGGY :
					trace("Igloo bought: " + item);
					_AIRTOWER.send(_AIRTOWER.PLAY_EXT, "i#calendariggy", [item], "str", _SHELL.getCurrentServerRoomId());
					break;
				case TYPE_LOCO :
					trace("Location bought: " + item);
					_INTERFACE.buyLocation(item);
					break;
			}
        }
        static var CLASS_NAME = "HolidayCalendar";
        static var PARK = "park";
        static var DAY = "day";
        static var DOOR = "door";
        static var GLOW = "glow";
        static var DOOR_STATE_OPEN = "open";
        static var DOOR_STATE_RATTLE = "rattle1";
        static var DOOR_STATE_RATTLE_GLOW = "rattle2";
        static var DOOR_OPEN_DELAY = 1000;
        static var FIRST_DAY = 14;
        static var LAST_DAY = 25;
        static var DAY_14_ITEM = 14444;
        static var DAY_15_ITEM = 11314;
        static var DAY_16_ITEM = 14445;
        static var DAY_17_ITEM = 260;
        static var DAY_18_ITEM = 471;
        static var DAY_19_ITEM = 50;
        static var DAY_20_ITEM = 9124;
        static var DAY_21_ITEM = 2270;
        static var DAY_22_ITEM = 2272;
        static var DAY_23_ITEM = 2271;
        static var DAY_24_ITEM = 76;
        static var DAY_25_ITEM = 3;
		static var TYPE_ITEM = "item";
		static var TYPE_FURN = "furn";
		static var TYPE_PUFF = "puff";
		static var TYPE_IGGY = "iggy";
		static var TYPE_LOCO = "loco";
/*
14th: Holiday Lights outfit
15th: Nutcracker Hat
16th: Nutcracker Outfit
17th: Toy Train
18th: Reindeer Antlers
19th: Night Cap Puffle Hat
20th: Holiday Magic background
21st: Ice Throne
22nd: Ice Rug
23rd: Ice Table
24th: Ice Palace Igloo
25th: Merry Walrus Island Igloo Location
*/
    }
