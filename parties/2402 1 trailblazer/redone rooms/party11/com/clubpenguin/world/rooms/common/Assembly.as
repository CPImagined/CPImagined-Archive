//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.Assembly
    {
        var _stage, _parts, _selectedPart, _tempPartUsable;
        function Assembly (stageReference, parts) {
            _stage = stageReference;
            _parts = parts;
            var _local_2 = 0;
            while (_local_2 < parts.length) {
                parts[_local_2].assembledPart._visible = false;
                parts[_local_2].disassembledPart.onPress = com.clubpenguin.util.Delegate.create(this, partClick, _local_2);
                _local_2++;
            }
        }
        function partClick(whichPart) {
            _selectedPart = _parts[whichPart];
            var _local_2 = new Object();
            _local_2._x = _stage._xmouse + _selectedPart.xCorrection;
            _local_2._y = _stage._ymouse + _selectedPart.yCorrection;
            if (_selectedPart.preRequisite._visible == false) {
                _tempPartUsable = false;
            } else {
                _tempPartUsable = true;
            }
            _selectedPart.disassembledPart._visible = false;
            _selectedPart.assembledPart.duplicateMovieClip("tempClip", _stage.getNextHighestDepth(), _local_2);
            _stage.tempClip.startDrag();
            _stage.tempClip.onPress = com.clubpenguin.util.Delegate.create(this, selected_onClick);
        }
        function selected_onClick() {
            var _local_2 = findDistance(_stage.tempClip._x, _stage.tempClip._y, _selectedPart.assembledPart._x, _selectedPart.assembledPart._y);
            if (_tempPartUsable && (_local_2 <= _acceptableDistance)) {
                _selectedPart.assembledPart.gotoAndStop("park");
                _selectedPart.assembledPart._visible = true;
                _partsAssembled = _partsAssembled + 1;
            } else {
                _selectedPart.disassembledPart._visible = true;
            }
            if (_partsAssembled == _parts.length) {
                finished = true;
            }
            _selectedPart = null;
            _stage.tempClip.removeMovieClip();
        }
        function findDistance(fromX, fromY, toX, toY) {
            var _local_2 = Math.round(toX - fromX);
            var _local_1 = Math.round(toY - fromY);
            return(Math.round(Math.sqrt((_local_2 * _local_2) + (_local_1 * _local_1))));
        }
        var finished = false;
        var _partsAssembled = 0;
        var _acceptableDistance = 30;
    }
