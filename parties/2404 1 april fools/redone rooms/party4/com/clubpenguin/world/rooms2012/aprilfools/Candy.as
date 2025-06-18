//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.Candy extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, localize, setupNavigationButtons, _SHELL, _destroyDelegate, _INTERFACE;
        function Candy (stageReference) {
            super();
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 615;
            _stage.start_y = 355;
            localize([_stage.storeFront.sign, _stage.shop_mc.text_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boxIsland.boxBtn, 710, 335), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.storeFront.host, 75, 260)]);
            _stage.storeFront.host.useHandCursor = false;
            _stage.triggers_mc.boxDimension.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPortal);
        }
        function exitPortal() {
            _SHELL.sendJoinRoom("boxdimension", 140, 260);
        }
        function init() {
            _stage.background_mc.spoonAnimation.spoonBtn.onRelease = com.clubpenguin.util.Delegate.create(this, feedTheSky);
            _stage.storeFront.sign.onPress = com.clubpenguin.util.Delegate.create(this, lightToggle);
            _stage.storeFront.useHandCursor = false;
            _stage.shop_mc.onRelease = com.clubpenguin.util.Delegate.create(this, showPartyCatalog);
            _stage.interface_mc.box_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showPartyCatalog);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function showPartyCatalog() {
            _INTERFACE.showContent("w.p.catalog.loading", null, _INTERFACE.getFilePath("w.p0412.aprilfools.catalog"));
        }
        function feedTheSky() {
            _stage.background_mc.spoonAnimation.gotoAndPlay("noItemFeed");
        }
        function lightToggle() {
            _stage.storeBack.play();
        }
        function handleThrow() {
            _SHELL.stampEarned(FOOD_FIGHT_STAMP_ID);
        }
        function onFoundHandler() {
            _stage.background_mc.spoonAnimation.itemBtn._visible = false;
        }
        function alreadyFoundHandler() {
            _stage.background_mc.spoonAnimation.itemBtn._visible = false;
        }
        static var CLASS_NAME = "Candy";
        static var FOOD_FIGHT_STAMP_ID = 332;
    }
