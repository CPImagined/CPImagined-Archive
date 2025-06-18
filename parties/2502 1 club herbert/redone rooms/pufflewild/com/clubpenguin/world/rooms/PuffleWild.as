//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.PuffleWild extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, poofTimer, qcTimer, foundPuffleTimer, _INTERFACE;
        function PuffleWild (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 325;
            _stage.start_y = 250;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.touchTriggers_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.block_mc._visible = false;
            _stage.triggers_mc.bottomExit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 350, 220);
			_stage.triggers_mc.leftExit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 400, 350);
			//_stage.triggers_mc.leftExit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showContent, "w.app.p2025.doom.fortressnote");
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton3, 54, 161), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton4, 590, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton1, 395, 436)]);
            _stage.navButton3.useHandCursor = false;
            _stage.navButton4.useHandCursor = false;
            _stage.navButton1.useHandCursor = false;
            addPufflesToStumps();
            setupPuffleAdoption();
        }
        function addPufflesToStumps() {
            animateSpecies(deerPuffle);
            animateSpecies(unicornPuffle);
            animateSpecies(bunnyPuffle);
            animateSpecies(raccoonPuffle);
            if (getRandomNum(1, 5) == 1) {
                animateSpecies(sasquatch);
            }
        }
        function getRandomNum(min, max) {
            return(Math.floor((Math.random() * ((max + 1) - min)) + min));
        }
        function animateSpecies(asset) {
            trace("PuffleWild.animateSpecies() - ANIMATE SPECIES - asset : " + asset);
            _stage[asset].art.gotoAndPlay(2);
            clearTimeout(poofTimer);
            if (asset == sasquatch) {
                _stage.sasquatch_watching_mc._visible = false;
            }
        }
        function setupPuffleAdoption() {
            _stage[deerPuffle].onPress = com.clubpenguin.util.Delegate.create(this, adoptPuffleHandler, "deer");
            _stage[unicornPuffle].onPress = com.clubpenguin.util.Delegate.create(this, adoptPuffleHandler, "unicorn");
            _stage[bunnyPuffle].onPress = com.clubpenguin.util.Delegate.create(this, adoptPuffleHandler, "bunny");
            _stage[raccoonPuffle].onPress = com.clubpenguin.util.Delegate.create(this, adoptPuffleHandler, "raccoon");
            _stage[sasquatch].onPress = com.clubpenguin.util.Delegate.create(this, sasquatchClickHandler);
        }
        function adoptPuffleHandler(puffleType) {
            if (_global.getCurrentShell().puffleManager.myPuffles.length >= com.clubpenguin.shell.PuffleManager.MAX_PUFFLES) {
                _global.getCurrentShell().$e("PuffleWild -> Max Puffles Reached", {error_code:_global.getCurrentShell().MAX_PUFFLE_LIMIT});
                return(undefined);
            }
            if (_global.getCurrentShell().isMyPlayerMember()) {
                if (puffleType == "deer") {
                    _global.getCurrentInterface().showContent(CHOOSE_DEER_PUFFLE_COLOR);
                } else if (puffleType == "bunny") {
                    _global.getCurrentInterface().showContent(CHOOSE_RABBIT_PUFFLE_COLOR);
                } else if (puffleType == "raccoon") {
                    _global.getCurrentInterface().showContent(CHOOSE_RACCOON_PUFFLE_COLOR);
                } else if (puffleType == "unicorn") {
                    _global.getCurrentInterface().showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, null, {puffleAdoptionType:"1020"}, true);
                }
            } else {
                _global.getCurrentInterface().showContent(OOPS_MEMBER_PUFFLE_WILD_MESSAGE);
            }
        }
        function sasquatchClickHandler() {
            trace("YOU HAVE CLICKED ON THE SASQUATCH");
        }
		function showContent(contentID) {
			_INTERFACE.showContent(contentID);
		}
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearTimeout(qcTimer);
            clearTimeout(poofTimer);
            clearTimeout(foundPuffleTimer);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "PuffleWild";
        static var OOPS_MEMBER_PUFFLE_WILD_MESSAGE = "oops_pufflewild";
        static var CHOOSE_DEER_PUFFLE_COLOR = "w.puffle.adopt.choosecolor.deer";
        static var CHOOSE_RABBIT_PUFFLE_COLOR = "w.puffle.adopt.choosecolor.rabbit";
        static var CHOOSE_RACCOON_PUFFLE_COLOR = "w.puffle.adopt.choosecolor.raccoon";
        var deerPuffle = "deerPuffle_mc";
        var unicornPuffle = "unicornPuffle_mc";
        var bunnyPuffle = "bunnyPuffle_mc";
        var raccoonPuffle = "raccoonPuffle_mc";
        var sasquatch = "sasquatch_mc";
    }
