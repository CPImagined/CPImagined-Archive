//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.scrollinglist.ScrollBarMediator
    {
        var view, verticalStepSize, _dragged, mouseMoveDelegate, dragArea;
        function ScrollBarMediator (view, verticalStepSize) {
            this.view = view;
            this.verticalStepSize = verticalStepSize || (DEFAULT_STEP_SIZE);
            _dragged = new org.osflash.signals.Signal(Number, Number);
            view.up.onPress = com.clubpenguin.util.Delegate.create(this, onUpPressed);
            view.down.onPress = com.clubpenguin.util.Delegate.create(this, onDownPressed);
            view.bar.onPress = com.clubpenguin.util.Delegate.create(this, onBarPressed);
            view.bar.onRelease = com.clubpenguin.util.Delegate.create(this, onBarReleased);
            view.bar.onReleaseOutside = view.bar.onRelease;
            mouseMoveDelegate = com.clubpenguin.util.Delegate.create(this, dispatchDragged);
            setupDragArea();
        }
        function get dragged() {
            return(_dragged);
        }
        function get dragAreaRect() {
            return(dragArea);
        }
        function set stepSize(size) {
            verticalStepSize = size;
            //return(stepSize);
        }
        function get stepSize() {
            return(verticalStepSize);
        }
        function setupDragArea() {
            var _local_2 = view.track._height - view.bar._height;
            if (_local_2 < 0) {
                _local_2 = 0;
            }
            dragArea = new flash.geom.Rectangle(view.track._x + 1, view.track._y, 0, _local_2);
        }
        function dispatchDragged() {
            var _local_2 = 0;
            _local_2 = (view.bar._y - view.track._y) / (view.track._height - view.bar._height);
            if (_local_2 < 0) {
                _local_2 = 0;
            } else if (_local_2 > 1) {
                _local_2 = 1;
            }
            _dragged.dispatch(_local_2);
        }
        function onBarPressed() {
            view.bar.startDrag(false, dragArea.left, dragArea.top, dragArea.right, dragArea.bottom);
            view.bar.onMouseMove = mouseMoveDelegate;
        }
        function onBarReleased() {
            view.bar.stopDrag();
            view.bar.onMouseMove = null;
        }
        function onUpPressed() {
            if ((view.bar._y - verticalStepSize) >= dragArea.top) {
                view.bar._y = view.bar._y - verticalStepSize;
            } else {
                view.bar._y = dragArea.top;
            }
            dispatchDragged();
        }
        function onDownPressed() {
            if ((view.bar._y + verticalStepSize) <= dragArea.bottom) {
                view.bar._y = view.bar._y + verticalStepSize;
            } else {
                view.bar._y = dragArea.bottom;
            }
            dispatchDragged();
        }
        static var DEFAULT_STEP_SIZE = 10;
    }
