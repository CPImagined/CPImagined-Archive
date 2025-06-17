//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.Pet extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, setupHint, _onCancelCloseUpClickDelegate, puffleBounceSFX, _SHELL, _INTERFACE, _ENGINE, _updatePlayerDelegate, _roomDestroyedDelegate;
        function Pet (_arg_5) {
            super(_arg_5);
            _stage = _arg_5;
            _stage.start_x = 380;
            _stage.start_y = 210;
            localize([_stage.background_mc.signAdopt, _stage.background_mc.signExit, _stage.background_mc.doorPark, _stage.interface_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plazaButton, 380, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rollerscapeButton, 500, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.puffleCannonButton, 575, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.doorPark.doorParkButton, 690, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.adoptButton, 180, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hotelEntrance_mc.hotel_btn, 50, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.goldBerry_btn, 289, 215)]);
            var _local_4;
            _local_4 = _global.getCurrentInterface();
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.catalogueButton, true, "catalog_viewer", "", _local_4.getFilePath("pets_catalogue"))]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.puffleCannonButton, _stage.puffleCannonHint, "cannon_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.rollerscapeButton, _stage.rollerscapeHint, "pufflescape_hint")]);
            _stage.triggers_mc.plazaTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 190, 280);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 630, 250);
            _stage.triggers_mc.parkTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 120, 195);
            _stage.triggers_mc.cannonTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, gameCannon);
            _stage.triggers_mc.pufflescapeTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, gamePufflescape);
            _stage.triggers_mc.adoptTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, showAdoptCatalogue);
            _stage.triggers_mc.goldBerry_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, onGoldBerryMachineTrigger);
            setupRoomAnimations();
            _stage.background_mc.goldBerry_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, goldBerryRollOver);
            _stage.background_mc.goldBerry_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, goldBerryRollOut);
            _stage.background_mc.goldBerry_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, goldBerryRollOut);
            _onCancelCloseUpClickDelegate = com.clubpenguin.util.Delegate.create(this, onCancelCloseUpClick);
            puffleBounceSFX = new Sound(_stage.background_mc.housePuffles);
            puffleBounceSFX.attachSound("sfx_puffle_bounce");
            if (!_SHELL) {
                init();
            }
            configurePH();
        }
        function configurePH() {
            var _local_3 = _global.getCurrentParty().PuffleParty;
            if (_local_3.partyCookie.msgViewedArray[_local_3.CONSTANTS.PUFFLETRICKS_MESSAGE_NUMBER] == 1) {
                _stage.PH_mc.gotoAndStop(3);
                _stage.block_mc.gotoAndStop(2);
                return(undefined);
            }
            _stage.PH_mc.gotoAndStop(1);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.PH_mc.ph_btn, 440, 400)]);
            _stage.triggers_mc.ph_trigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, showPHDialogue);
        }
        function showPHDialogue() {
            _stage.PH_mc.gotoAndStop(2);
            _INTERFACE.showContent(_global.getCurrentParty().PuffleParty.CONSTANTS.PH_DIALOGUE_PUFFLETRICKS_PATH);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.PH_mc.ph_btn, 440, 400)]);
            _global.getCurrentParty().PuffleParty.sendPHSpriteView();
        }
        function goldBerryRollOver() {
            _stage.background_mc.spout_mc.gotoAndStop("rollOver");
        }
        function goldBerryRollOut() {
            _stage.background_mc.spout_mc.gotoAndStop("rollOut");
        }
        function onGoldBerryMachineTrigger() {
            showGoldBerryMachineCloseup();
        }
        function showGoldBerryMachineCloseup() {
            var _local_2 = new Object();
            _local_2.userPuffleCount = _SHELL.puffleManager.myPuffleCount;
            _local_2.maxPuffleCount = com.clubpenguin.shell.PuffleManager.MAX_PUFFLES;
            _local_2.userCoinCount = _SHELL.getMyPlayerTotalCoins();
            _local_2.berryCost = 10;
            var _local_3 = com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getMyPlayerObject(), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE);
            if (_local_3) {
                _local_2.walkingPuffleId = _SHELL.getMyPlayerObject().attachedPuffle.id;
            } else {
                _local_2.walkingPuffleId = 0;
            }
            _SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_GOLD_BERRY_MACHINE, _local_2, {modalBackgroundEnabled:true, hideLoadingDialog:true, blockPuffleNotifications:true});
        }
        function onCancelCloseUpClick(playerObject) {
            _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_TREASURE_HUNTING, _SHELL.getMyPlayerObject().player_id);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _onCancelCloseUpClickDelegate);
        }
        function gamePufflescape() {
            _ENGINE.sendJoinGame("pufflescape", true);
        }
        function gameCannon() {
            _ENGINE.sendJoinGame("cannon", true);
        }
        function gameRoundup() {
            _ENGINE.sendJoinGame("roundup", true);
        }
        function showFurnitureCatalogue() {
            _SHELL.sendOpenAS3Module("catalog_viewer", String(_INTERFACE.getFilePath("pets_catalogue")), {blockPuffleNotifications:true});
        }
        function showPuffleManual() {
            _INTERFACE.showContent("puffle_manual", null, undefined, null, true);
        }
        function showAdoptCatalogue() {
            _INTERFACE.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, undefined, null, true);
        }
        function setupRoomAnimations() {
            _stage.adoptButton.onRollOver = com.clubpenguin.util.Delegate.create(this, puffleAnim);
            _stage.adoptButton.onRollOut = com.clubpenguin.util.Delegate.create(this, puffleStopAnim);
            _stage.adoptButton.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, puffleStopAnim);
        }
        function puffleAnim() {
            pufflesMousedOver = true;
            _stage.puffleDirector.play();
            _stage.background_mc.housePuffles.houseLight.gotoAndStop(2);
            puffleBounceSFX.start(0, 99);
        }
        function puffleStopAnim() {
            pufflesMousedOver = false;
            _stage.background_mc.housePuffles.houseLight.gotoAndStop(1);
            puffleBounceSFX.stop();
        }
        function puffleAnimCheck(_arg_2) {
            if (pufflesMousedOver == true) {
                _arg_2.gotoAndPlay("repeat");
            }
        }
        function init() {
            _stage.bookDepth.book.onPress = com.clubpenguin.util.Delegate.create(this, showPuffleManual);
            _stage.interface_mc.clipBoardButton.onPress = com.clubpenguin.util.Delegate.create(this, showAdoptCatalogue);
            _updatePlayerDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer);
            _roomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            updatePuffleRug();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _updatePlayerDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _roomDestroyedDelegate);
            _ENGINE.showHiddenQuestIcon.add(showClipBoardIcon, this);
            checkAdoptionIconVisibility();
        }
        function showClipBoardIcon() {
            _stage.interface_mc.clipBoardButton._visible = true;
            _ENGINE.petPuffleAdoptionIconHide = false;
            _ENGINE.petPuffleAdoptionIconVisibility = true;
            _ENGINE.questIconVisibilityChanged.dispatch();
        }
        function checkAdoptionIconVisibility() {
            _stage.interface_mc.clipBoardButton._visible = !_ENGINE.petPuffleAdoptionIconHide;
        }
        function destroy() {
            _stage.onEnterFrame = null;
            _stage = null;
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _updatePlayerDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _roomDestroyedDelegate);
        }
        function handleUpdatePlayer(_arg_2) {
            if (_SHELL.getMyPlayerId() != _arg_2.player_id) {
                return(undefined);
            }
            updatePuffleRug();
        }
        function updatePuffleRug() {
            var _local_4 = _SHELL.getMyPlayerId();
            var _local_3 = _SHELL.getPlayerObjectFromRoomById(_local_4);
            var _local_2 = "blue";
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_3, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                _local_2 = _local_3.attachedPuffle["color"];
            }
            _stage.background_mc.rugPuffles.gotoAndStop(_local_2);
        }
        function exit(_arg_2, _arg_4, _arg_3) {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom(_arg_2, _arg_4, _arg_3);
            }
        }
        static var CLASS_NAME = "Pet";
        static var NONMEMBER_OOPS_BERRY_MACHINE = "oops_gold_berry_machine";
        var _previousTimer = 0;
        var pufflesMousedOver = false;
    }
