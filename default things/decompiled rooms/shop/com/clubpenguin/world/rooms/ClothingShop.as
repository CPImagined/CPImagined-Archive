//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.ClothingShop extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _ENGINE, _INTERFACE, _SHELL, _destroyDelegate;
        function ClothingShop (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 285;
            localize([_stage.interface_mc.clothing_btn_states]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 550, 180), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.changeroom_btn, 235, 195), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chest_mc.chest_btn, 660, 295)]);
            _stage.interface_mc.redemption_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "treasure_book");
            _stage.interface_mc.clothing_btn_states.clothing_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "clothing_catalogue");
            _stage.desk_mc.display_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, deskDisplaySpin);
            _stage.desk_mc.display_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.desk_mc.display_btn.useHandCursor = false;
            _stage.desk_mc.register_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, registerAnimate);
            _stage.desk_mc.register_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.desk_mc.register_btn.useHandCursor = false;
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 530, 245);
            _stage.triggers_mc.redemption_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showContent, "treasure_book");
            _stage.triggers_mc.changeroom_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showContent, "clothing_catalogue");
            _ENGINE.showHiddenQuestIcon.add(showCatalogueIcon, this);
            checkCatalogueIconVisibility();
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function deskDisplaySpin() {
            _stage.desk_mc.display_mc.gotoAndPlay(2);
        }
        function registerAnimate() {
            if (_stage.desk_mc.register_mc._currentframe == 2) {
                _stage.desk_mc.register_mc.gotoAndStop(3);
            } else {
                _stage.desk_mc.register_mc.gotoAndStop(2);
            }
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function exit(name, x, y) {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom(name, x, y);
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function checkCatalogueIconVisibility() {
            _stage.interface_mc.clothing_btn_states._visible = !_ENGINE.shopClothingCatalogueIconHide;
        }
        function showCatalogueIcon() {
            _stage.interface_mc.clothing_btn_states._visible = true;
            _ENGINE.shopClothingCatalogueIconHide = false;
            _ENGINE.shopClothingCatalogueIconVisibility = true;
            _ENGINE.questIconVisibilityChanged.dispatch();
        }
        static var CLASS_NAME = "ClothingShop";
    }
