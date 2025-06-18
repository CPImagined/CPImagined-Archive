//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Forest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons;
        function Forest (stageReference) {
            super(stageReference);
            configureDragonScales();
            _stage.start_x = 485;
            _stage.start_y = 345;
        }
        function exitPlaza() {
            _SHELL.sendJoinRoom("plaza", 675, 300);
        }
        function exitCove() {
            _SHELL.sendJoinRoom("cove", 170, 160);
        }
        function exitShack() {
            _SHELL.sendJoinRoom("shack", 485, 320);
        }
        function exitLake() {
            _SHELL.sendJoinRoom("lake", 220, 160);
        }
        function exitParty1() {
            _SHELL.sendJoinRoom("party1", 400, 310);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPlaza);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitCove);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitShack);
            _stage.triggers_mc.what_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitLake);
            _stage.triggers_mc.party1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitParty1);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.cove_btn, 600, 375), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.party1_btn, 500, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 50, 320), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.shack_btn, 130, 160)]);
            _stage.background_mc.cove_btn.useHandCursor = false;
            _stage.background_mc.plaza_btn.useHandCursor = false;
            _stage.background_mc.shack_btn.useHandCursor = false;
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.showPartyCatalogue);
        }
        function configureDragonScales() {
            if (com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.hasPlayerCollectedIngredient(com.clubpenguin.world.rooms2013.medieval.MedievalParty.DRAGONSCALE_ITEM_ID)) {
                deactivateIngredient();
                return(undefined);
            }
            _stage.tower_mc.scale_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.sendCollectIngredient, com.clubpenguin.world.rooms2013.medieval.MedievalParty.DRAGONSCALE_ITEM_ID);
        }
        function deactivateIngredient() {
            _stage.tower_mc.sparkles_MC._visible = false;
            _stage.tower_mc.scale_btn.enabled = false;
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        static var CLASS_NAME = "Forest";
    }
