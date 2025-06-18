//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.islandAdventure2011.Berg extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, showContent, _SHELL, _ENGINE;
        function Berg (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 326;
            _stage.start_y = 224;
            localize([_stage.sign]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.scrollCompass.scrollCompassButton, true, "party_note03", "")]);
            _stage.triggers_mc.aqua_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, aquaGame);
            if (_SHELL == undefined) {
                init();
            }
        }
        function aquaGame() {
            _ENGINE.sendJoinGame("aqua", true);
        }
        function init() {
            playerHasPrereqItem = _SHELL.isItemInMyInventory(PREREQUISITE_ITEM);
            playerHasNextItem = _SHELL.isItemInMyInventory(NEXT_ROOM_ITEM);
            if (_SHELL == undefined) {
                playerHasPrereqItem = true;
            }
            if (playerHasPrereqItem) {
                _stage.background_mc.kracken.gotoAndStop("enter");
                if (playerHasNextItem) {
                    _stage.scrollCompass.gotoAndStop("on");
                }
            }
        }
        function handleThrow(ball) {
            if (!playerHasPrereqItem) {
                return(undefined);
            }
            var _local_3 = 175;
            var _local_4 = 375;
            if (ball._x < _local_3) {
                if (ball._y > _local_4) {
                    var _local_5 = {_x:ball._x, _y:ball._y};
                    fishIterator++;
                    ball._visible = false;
                    _stage.attachMovie("splash", "fish" + fishIterator, _stage.getNextHighestDepth(), _local_5);
                    resolveFeeding();
                }
            }
        }
        function resolveFeeding() {
            if (krackenFed) {
                return(undefined);
            }
            if (fishIterator >= KRACKEN_FISH_LIMIT) {
                krackenFed = true;
                _stage.background_mc.kracken.gotoAndStop("exit");
                _stage.burpSplash.play();
                if (!playerHasNextItem) {
                    _stage.scrollBurp.gotoAndStop("on");
                }
            } else {
                _stage.feedBubbles.play();
            }
        }
        var PREREQUISITE_ITEM = 7063;
        var NEXT_ROOM_ITEM = 7064;
        var KRACKEN_FISH_LIMIT = 3;
        var playerHasPrereqItem = false;
        var playerHasNextItem = false;
        var krackenFed = false;
        var fishIterator = 0;
    }
