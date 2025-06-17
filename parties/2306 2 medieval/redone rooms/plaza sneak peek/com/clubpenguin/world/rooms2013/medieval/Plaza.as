//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, localize, _INTERFACE, _triggerWatcherInterval;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 190;
            _stage.start_y = 360;
            init();
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            randomizeBubbles();
            configureSnot();
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party", 678, 205);
			_stage.triggers_mc.puffle_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showModernPopup);
			_stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showModernPopup);
			_stage.triggers_mc.stage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showModernPopup);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party", 463, 200);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party", 120, 300);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party", 590, 307);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.puffle_btn, 128, 283), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.hotel_btn, 266, 270), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stage_btn, 445, 270), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizza_btn, 594, 256), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 30, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 735, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pool_mc.manhole_mc.manhole_btn, 547, 327)]);
            _stage.forts_btn.useHandCursor = false;
            _stage.forest_btn.useHandCursor = false;
            _stage.pool_mc.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.pool_mc.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            localize([_stage.background_mc.bgbitmap1_mc.stageSign_mc]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.showPartyCatalogue);
        }
		function showModernPopup() {
			_INTERFACE.showContent("party_catalogue");
		}
        function manholeRollOver() {
            _stage.pool_mc.manhole_mc.gotoAndPlay(2);
        }
        function manholeRollOut() {
            _stage.pool_mc.manhole_mc.gotoAndPlay(9);
        }
        function randomizeBubbles() {
            _stage.background_mc.bubble1_mc.gotoAndPlay(5);
            _stage.background_mc.bubble3_mc.gotoAndPlay(55);
            _stage.background_mc.bubble2_mc.gotoAndPlay(31);
        }
        function configureSnot() {
            if (com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.hasPlayerCollectedIngredient(com.clubpenguin.world.rooms2013.medieval.MedievalParty.OGRE_SNOT_ITEM_ID)) {
                deactivateIngredient();
                return(undefined);
            }
            _stage.foreground_mc.snotbucket_MC.snotbucket_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.sendCollectIngredient, com.clubpenguin.world.rooms2013.medieval.MedievalParty.OGRE_SNOT_ITEM_ID);
        }
        function deactivateIngredient() {
            _stage.foreground_mc.snotbucket_MC.sparkles_MC._visible = false;
            _stage.foreground_mc.snotbucket_MC.snotbucket_Btn.enabled = false;
        }
        function exit(roomName, x, y) {
            if (roomName == "cave") {
                _SHELL.stampEarned(UNDERGROUND_STAMP_ID);
            }
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Plaza";
        var UNDERGROUND_STAMP_ID = 10;
    }
