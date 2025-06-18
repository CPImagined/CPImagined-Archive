//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.Rink extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _airtower, _waterSlideHandlerDelegate, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, showContent, localize, _triggerWatcherInterval, _waterSlideLeftTrigger, _waterSlideCenterTrigger, _waterSlideRightTrigger, _ENGINE;
        function Rink (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 580;
            _stage.start_y = 395;
            init();
        }
        function init() {
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.activateTeenBeachPlayerOverrides();
            _airtower = _global.getCurrentAirtower();
            _waterSlideHandlerDelegate = com.clubpenguin.util.Delegate.create(this, handlePenguinOnWaterSlide);
            _airtower.addListener(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.WATERSLIDE_COMMAND_NAME, _waterSlideHandlerDelegate);
            _stage.waterSlideTester.gotoAndStop(1);
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.configureItemHut(CLASS_NAME.toLowerCase(), _stage.kioskcontainer_mc.itemHut_mc);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 134, 209);
			_stage.triggers_mc.item_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickupItem);
            configureWaterSlideTriggers();
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 678, 418), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.leftsteps_mc.leftslide_btn, 98, 270), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.centersteps_mc.centerslide_btn, 474, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rightsteps_mc.rightslide_btn, 720, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.kioskcontainer_mc.itemHut_mc.itemHut_btn, 372, 260)]);
            _stage.forts_btn.useHandCursor = false;
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.sports_mc.sports_btn, true, "sport_catalogue", "")]);
            localize([_stage.interface_mc.sports_mc]);
			showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.catalogue_btn, true, "party_catalogue", "")]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
		function pickupItem() {
			if(_SHELL.isItemInMyInventory(325)) {
				_INTERFACE.buyInventory(325);
			};
		}
        function configureWaterSlideTriggers() {
            _stage.triggers_mc.itemHutTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.collectPartyItem, CLASS_NAME.toLowerCase());
            _waterSlideLeftTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slideLeft_mc);
            _waterSlideLeftTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateWaterSlide, LEFT_SLIDE));
            _triggerWatcher.addTrigger(_waterSlideLeftTrigger);
            _waterSlideCenterTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slideCenter_mc);
            _waterSlideCenterTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateWaterSlide, CENTER_SLIDE));
            _triggerWatcher.addTrigger(_waterSlideCenterTrigger);
            _waterSlideRightTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slideRight_mc);
            _waterSlideRightTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateWaterSlide, RIGHT_SLIDE));
            _triggerWatcher.addTrigger(_waterSlideRightTrigger);
        }
        function activateWaterSlide(players, slideNum) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.sendPenguinOnWaterslide(slideNum);
                }
                _local_2++;
            }
        }
        function addPenguintoWaterSlidePather(slideNum, player_id) {
            if (player_id == _SHELL.getMyPlayerId()) {
                switch (slideNum) {
                    case 1 : 
                        _stage.leftSlideLight.light.gotoAndPlay("green");
                        break;
                    case 2 : 
                        _stage.background_mc.light.gotoAndPlay("green");
                        break;
                    case 3 : 
                        _stage.rightSlideLight.light.gotoAndPlay("green");
                        break;
                }
            }
            _stage.waterSlideContainerMC.attachMovie("Waterslide_Path_" + slideNum, (("slideguide_" + slideNum) + "_") + player_id, _stage.waterSlideContainerMC.getNextHighestDepth(), {_x:0, _y:0});
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.addPenguinToWaterslide(player_id);
            var _local_2 = _stage.waterSlideContainerMC[(("slideguide_" + slideNum) + "_") + player_id];
            _local_2.gotoAndStop(1);
            _ENGINE.teleportPlayer(player_id, _local_2.patherMC._x, _local_2.patherMC._y);
            if (player_id == _SHELL.getMyPlayerId()) {
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.playSound(_local_2, "sfx_slide_start");
            }
            _local_2.play();
            _local_2.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updatePenguinSlidePosition, player_id, _local_2, slideNum);
        }
        function updatePenguinSlidePosition(player_id, patherMC, slideNum) {
            if (patherMC._currentframe == patherMC._totalframes) {
                patherMC.gotoAndStop(1);
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.removePenguinFromWaterslide(player_id);
                delete patherMC.onEnterFrame;
                patherMC.removeMovieClip();
                patherMC = null;
            } else if (patherMC._currentframe == splashFrame[slideNum]) {
                if (_stage.foreground_mc["slideSplash_" + slideNum]._currentframe == 1) {
                    _stage.foreground_mc["slideSplash_" + slideNum].play();
                }
            } else if (patherMC._currentframe == cornerFrame[slideNum]) {
                if (player_id == _SHELL.getMyPlayerId()) {
                    com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.playSound(patherMC, "sfx_corner_" + Math.ceil(Math.random() * 2));
                }
            } else if (patherMC._currentframe == woohooFrame[slideNum]) {
                if (player_id == _SHELL.getMyPlayerId()) {
                    com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.playSound(patherMC, "sfx_woohoo_" + Math.ceil(Math.random() * 3));
                }
            } else {
                var _local_5 = _SHELL.getPlayerObjectById(player_id).x;
                _ENGINE.teleportPlayer(player_id, patherMC.patherMC._x, patherMC.patherMC._y);
                updateSlidingPenguinFrame(player_id, _local_5, patherMC.patherMC._x);
            }
        }
        function updateSlidingPenguinFrame(player_id, old_x, new_x) {
            var _local_3 = new_x - old_x;
            var _local_2 = 0;
            if (_local_3 > MINIMUM_SLIDE_DISPLACEMENT) {
                _local_2 = com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.PENGUIN_SIT_FRONT_RIGHT;
            } else if (_local_3 < (-MINIMUM_SLIDE_DISPLACEMENT)) {
                _local_2 = com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.PENGUIN_SIT_FRONT_LEFT;
            } else {
                _local_2 = com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.PENGUIN_SIT_FRONT_CENTER;
            }
            if (_local_2 <= 0) {
                return(undefined);
            }
            _ENGINE.updatePlayerFrame(player_id, _local_2, true);
        }
        function handlePenguinOnWaterSlide(data) {
            var _local_2 = Number(data[1]);
            var _local_3 = Number(data[2]);
            trace("Penguin who is going down the slide " + _local_2);
            trace("Slide number " + _local_3);
            addPenguintoWaterSlidePather(_local_3, _local_2);
            data = null;
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.deactivateTeenBeachPlayerOverrides();
            _airtower.removeListener(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.WATERSLIDE_COMMAND_NAME, _waterSlideHandlerDelegate);
        }
        static var CLASS_NAME = "Rink";
        static var MINIMUM_SLIDE_DISPLACEMENT = 1;
        static var LEFT_SLIDE = 1;
        static var CENTER_SLIDE = 2;
        static var RIGHT_SLIDE = 3;
        var splashFrame = new Array(0, 140, 98, 60);
        var cornerFrame = new Array(0, 127, 75, 0);
        var woohooFrame = new Array(0, 76, 33, 38);
    }
