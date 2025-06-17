//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.paperdoll.PaperDollGenerator
    {
        function PaperDollGenerator (stage, shell, paperDollContainer) {
            _stage = stage;
            _SHELL = shell;
            _paperDollContainer = paperDollContainer;
        }
        function clearPaperDoll() {
            _paperDoll.clear();
        }
        function drawPaperDoll(playerID) {
            clearPaperDoll();
            _playerID = playerID;
            _paperDollContainer.swapDepths(_stage.getNextHighestDepth());
            var _local_6 = _stage.paper_doll_mc;
            var _local_2 = _SHELL.getPlayerObjectById(_playerID);
            var _local_5 = _paperDollContainer.paper_doll_mc;
            var _local_4 = _paperDollContainer.flag_mc;
            var _local_3 = _paperDollContainer.photo_mc;
            _paperDoll = new com.clubpenguin.ui.PaperDoll(_playerID);
            _paperDoll.paperDollClip = _local_5;
            _paperDoll.shell = _SHELL;
            _paperDoll.isInteractive = false;
            _paperDoll.fadeAfterLoad = false;
            _paperDoll.backgroundClip = _local_3;
            _paperDoll.flagClip = _local_4;
            updateBackground(_local_2);
            dressPaperDoll(_local_2);
        }
        function updateBackground(playerObject) {
            var _local_3 = playerObject.colour_id;
            var _local_4 = playerObject.photo_id;
            var _local_5 = playerObject.flag_id;
            _paperDoll.colourID = _local_3;
			_paperDoll.photoID = _local_4;
			_paperDoll.flagID = _local_5;
        }
        function dressPaperDoll(playerObject) {
            for (var _local_3 in _SHELL.PAPERDOLL_DEFAULT_LAYER_DEPTHS) {
                _paperDoll.addItem(_local_3, playerObject[_local_3]);
            }
        }
        var _paperDollContainer = null;
        var _paperDoll = null;
        var _stage = null;
        var _SHELL = null;
        var _playerID = 0;
    }
