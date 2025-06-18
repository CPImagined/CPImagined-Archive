//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.islandAdventure2011.TreefortRepeat extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, showContent, _SHELL, _INTERFACE, _simonSays, _fireflieClips, _fireFliesLength, _fireflyUpdateDelegate, _destroyDelegate;
        function TreefortRepeat (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 355;
            _stage.start_y = 375;
            localize([_stage.background_mc.feedsign_mc.feedwords_mc, _stage.foreground_mc.roof]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.boatBack.egg.scrollButton, true, "party_note05", "")]);
            _stage.triggers_mc.party_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit);
            _stage.boatBack.egg.scrollButton.onRelease = com.clubpenguin.util.Delegate.create(this, flipTheBird);
            if (!_SHELL) {
                init();
            }
        }
        function exit() {
            _SHELL.sendJoinRoom("forest", 387, 280);
        }
        function init() {
            _playerHasNextItem = _SHELL.isItemInMyInventory(NEXT_ROOM_ITEM);
            _stage.foreground_mc.roof.inside.gotoAndStop("show");
            _simonSays = new com.clubpenguin.world.rooms.common.SimonSays(com.clubpenguin.util.Delegate.create(this, creackEgg), [_stage.foreground_mc.bird0, _stage.foreground_mc.bird1, _stage.bird2, _stage.centerTree.bird3], [_stage.drum0, _stage.drum1, _stage.drum2, _stage.drum3], [_stage.foreground_mc.roof.inside.roof.sign.sign.sign.ledDisplay.led0, _stage.foreground_mc.roof.inside.roof.sign.sign.sign.ledDisplay.led1, _stage.foreground_mc.roof.inside.roof.sign.sign.sign.ledDisplay.led2, _stage.foreground_mc.roof.inside.roof.sign.sign.sign.ledDisplay.led3, _stage.foreground_mc.roof.inside.roof.sign.sign.sign.ledDisplay.led4], new com.clubpenguin.world.rooms.common.SimonPatternVO(SIMON_PATTERN_ONE, SIMON_PATTERN_TWO, SIMON_PATTERN_THREE));
            if (_playerHasNextItem) {
                _stage.boatBack.gotoAndStop("done");
                _stage.boatBack.egg.gotoAndStop("done");
            }
            _fireflieClips = [_stage.background_mc.fairyHolder0, _stage.background_mc.fairyHolder1, _stage.background_mc.fairyHolder2, _stage.background_mc.fairyHolder3, _stage.background_mc.fairyHolder4, _stage.background_mc.fairyHolder5, _stage.background_mc.fairyHolder6, _stage.background_mc.fairyHolder7, _stage.background_mc.fairyHolder8, _stage.background_mc.fairyHolder9, _stage.background_mc.fairyHolder10, _stage.background_mc.fairyHolder11, _stage.background_mc.fairyHolder12, _stage.background_mc.fairyHolder13, _stage.background_mc.fairyHolder14];
            _fireFliesLength = _fireflieClips.length;
            fireflyUpdate();
            _fireflyUpdateDelegate = com.clubpenguin.util.Delegate.create(this, fireflyUpdate);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ADD_PLAYER, _fireflyUpdateDelegate);
            _SHELL.addListener(_SHELL.REMOVE_PLAYER, _fireflyUpdateDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ADD_PLAYER, _fireflyUpdateDelegate);
            _SHELL.removeListener(_SHELL.REMOVE_PLAYER, _fireflyUpdateDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _simonSays.destroy();
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
		function flipTheBird() {
			_INTERFACE.buyInventory(NEXT_ROOM_ITEM);
		}
        function creackEgg() {
            if (_playerHasNextItem) {
                return(undefined);
            }
            _SHELL.stampEarned(MUSICAL_MAESTRO_STAMP_ID);
            _stage.boatBack.gotoAndPlay("play");
            _stage.boatBack.egg.gotoAndPlay("play");
        }
        function fireflyUpdate() {
            var _local_3 = _SHELL.getPlayerList().length;
            var _local_4 = 1;
            var _local_5 = 2;
            var _local_2 = _local_3;
            while (_local_2 < _fireFliesLength) {
                _fireflieClips[_local_2].gotoAndStop(_local_4);
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < _local_3) {
                _fireflieClips[_local_2].gotoAndStop(_local_5);
                _local_2++;
            }
        }
        static var CLASS_NAME = "TreefortRepeat";
        static var NEXT_ROOM_ITEM = 3023;
        static var MUSICAL_MAESTRO_STAMP_ID = 426;
        static var SIMON_PATTERN_ONE = [0, 1, 0];
        static var SIMON_PATTERN_TWO = [0, 1, 0, 2];
        static var SIMON_PATTERN_THREE = [0, 1, 0, 2, 3];
        var _playerHasPrereqItem = false;
        var _playerHasNextItem = false;
    }
