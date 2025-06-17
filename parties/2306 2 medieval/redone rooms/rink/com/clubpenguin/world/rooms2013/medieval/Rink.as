//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Rink extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, _SHELL, _INTERFACE, _destroyDelegate;
        function Rink (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 370;
            _stage.start_y = 370;
            localize([_stage.yeSnacks.bitmap.sign, _stage.yeSmithy.bitmap.sign, _stage.interface_mc.sports_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forts_btn, 357, 188), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.tent2.school_btn, 601, 204)]);
            _stage.background_mc.forts_btn.useHandCursor = false;
            _stage.tent2.school_btn.useHandCursor = false;
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.sports_mc.sports_btn, true, "sport_catalogue", "")]);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 450, 180);
            if (com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.messageIndex > 0) {
                _stage.triggers_mc.school_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 100, 363);
            } else {
                _stage.triggers_mc.school_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "schoolsolo", 100, 363);
            }
            _stage.triggers_mc.sports_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, catalog);
            _stage.yeSmithy.horseShoe_mc.horseShoe_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, horseShoeOver);
            _stage.yeSmithy.horseShoe_mc.horseShoe_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, horseShoeOut);
            _stage.yeSmithy.horseShoe_mc.horseShoe_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, horseShoeOut);
            if (!com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.hasPlayerCollectedIngredient(com.clubpenguin.world.rooms2013.medieval.MedievalParty.HORSESHOE_ITEM_ID)) {
                _stage.yeSmithy.horseShoe_mc.horseShoe_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.sendCollectIngredient, com.clubpenguin.world.rooms2013.medieval.MedievalParty.HORSESHOE_ITEM_ID);
            } else {
                deactivateIngredient();
            }
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.showPartyCatalogue);
        }
        function deactivateIngredient() {
            _stage.yeSmithy.horseShoe_mc._visible = false;
            _stage.yeSmithy.sparkly_MC._visible = false;
        }
        function exit(roomName, spawnX, spawnY) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, spawnX, spawnY);
        }
        function catalog() {
            trace(CLASS_NAME + ": catalog()");
            _INTERFACE.showContent("sport_catalogue");
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function horseShoeOver() {
            _stage.yeSmithy.horseShoe_mc.gotoAndStop(2);
        }
        function horseShoeOut() {
            _stage.yeSmithy.horseShoe_mc.gotoAndStop(1);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        static var CLASS_NAME = "Rink";
    }
