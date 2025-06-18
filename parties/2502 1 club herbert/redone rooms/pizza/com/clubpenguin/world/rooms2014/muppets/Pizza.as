//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.Pizza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _onCancelCloseUpClickDelegate, _ENGINE, _INTERFACE, _SHELL, _destroyDelegate;
        function Pizza (stageReference) {
            super(stageReference);
            _stage.start_x = 300;
            _stage.start_y = 310;
            localize([_stage.background_mc.kitchen_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 380, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizzatron_btn, 165, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.careStation_mc.careStation_btn, 488, 178), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stand_btn, 246, 156), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool01_btn, 247, 213), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool02_btn, 249, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool03_btn, 219, 293), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool04_btn, 640, 228), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat01_btn, 335, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat02_btn, 405, 222), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat03_btn, 456, 306), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat04_btn, 514, 253)]);
            _stage.stand_btn.useHandCursor = false;
            _stage.stool01_btn.useHandCursor = false;
            _stage.stool02_btn.useHandCursor = false;
            _stage.stool03_btn.useHandCursor = false;
            _stage.stool04_btn.useHandCursor = false;
            _stage.seat01_btn.useHandCursor = false;
            _stage.seat02_btn.useHandCursor = false;
            _stage.seat03_btn.useHandCursor = false;
            _stage.seat04_btn.useHandCursor = false;
            _stage.desk_mc.register_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, registerAnimate);
            _stage.desk_mc.register_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.desk_mc.register_btn.useHandCursor = false;
            _stage.background_mc.pizzatron_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showPizzatronHint);
            _stage.background_mc.pizzatron_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hidePizzatronHint);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 635, 300);
            _stage.triggers_mc.pizzatron_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchPizzatronGame);
            _stage.background_mc.careStation_mc.careStation_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, careStationRollOver);
            _stage.background_mc.careStation_mc.careStation_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, careStationRollOut);
            _stage.background_mc.careStation_mc.careStation_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, careStationRollOut);
            _stage.triggers_mc.careStation_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showPuffleCareStationMenu);
            _stage.background_mc.careStation_mc.careStation_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onCareStationClick);
            _onCancelCloseUpClickDelegate = com.clubpenguin.util.Delegate.create(this, onCancelCloseUpClick);
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
        function showPizzatronHint() {
            _INTERFACE.showHint(_stage.hintpizzatron_mc, "pizzatron_hint");
        }
        function hidePizzatronHint() {
            _INTERFACE.closeHint();
        }
        function launchPizzatronGame() {
            _ENGINE.sendJoinGame("pizzatron", true);
        }
        function careStationRollOver() {
            _stage.background_mc.careStation_mc.spout_mc.gotoAndStop("rollOver");
        }
        function careStationRollOut() {
            _stage.background_mc.careStation_mc.spout_mc.gotoAndStop("rollOut");
        }
        function moveToPizzaMachine() {
            _ENGINE.sendPlayerMove(488, 178);
        }
        function showPuffleCareStationMenu() {
            var _local_3 = com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getMyPlayerObject(), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE);
            var _local_5 = null;
            if (_local_3) {
                _local_5 = _SHELL.getMyPlayerObject().attachedPuffle["color"];
            }
            _SHELL.sendOpenAS3Module("puffle_care_station_menu", {isWalkingPuffle:_local_3, puffleColor:_local_5}, {modalBackgroundEnabled:true, hideLoadingDialog:true, blockPuffleNotifications:false, persistent:false});
        }
        function onCareStationClick() {
            _ENGINE.sendPlayerMove(488, 178);
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, _SHELL.getMyPlayerObject().player_id);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _onCancelCloseUpClickDelegate);
        }
        function onCancelCloseUpClick(playerObject) {
            _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_TREASURE_HUNTING, _SHELL.getMyPlayerObject().player_id);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _onCancelCloseUpClickDelegate);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Pizza";
    }
