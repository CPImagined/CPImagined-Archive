//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.view.ScrollBarHandleView
    {
        var canvasMC, _width, _height, _boundsWidth, _startX, _isMouseOver, _style, _mouseListener, postionChanged, _isReleaseLocked, _paneWidthInItems, _totalNumberOfItems, _lastX;
        function ScrollBarHandleView (mc, startX, width, height, boundsWidth, style) {
            trace("release gripLineBoundsWidth: " + gripLineBoundsWidth);
            canvasMC = mc;
            _width = width;
            _height = height;
            _boundsWidth = boundsWidth;
            _startX = startX;
            _isMouseOver = false;
            _style = style;
            canvasMC.onPress = com.clubpenguin.util.Delegate.create(this, onPress);
            canvasMC.onRollOver = com.clubpenguin.util.Delegate.create(this, onRollover);
            canvasMC.onRollOut = com.clubpenguin.util.Delegate.create(this, onRollout);
            canvasMC.onRelease = com.clubpenguin.util.Delegate.create(this, onRelease);
            canvasMC.onRelaseOutside = com.clubpenguin.util.Delegate.create(this, onRelease);
            _mouseListener = {};
            _mouseListener.onMouseUp = com.clubpenguin.util.Delegate.create(this, onMouseUp);
            Mouse.addListener(_mouseListener);
            canvasMC._x = _startX;
            postionChanged = new org.osflash.signals.Signal(Number);
        }
        function setWidth(newWidth) {
            trace((this + " setting the width: ") + newWidth);
            if (newWidth < minWidth) {
                newWidth = minWidth;
            }
            _width = newWidth;
            draw(_style.buttonLineColorDefault, _style.buttonFillColorDefault);
            canvasMC.stopDrag();
        }
        function onRollout() {
            draw(_style.buttonLineColorDefault, _style.buttonFillColorDefault);
            _isMouseOver = false;
        }
        function onRollover() {
            draw(_style.buttonLineColorOver, _style.buttonFillColorOver);
            _isMouseOver = true;
        }
        function onPress() {
            draw(_style.buttonLineColorDown, _style.buttonFillColorDown);
            _isReleaseLocked = true;
            startDragging();
        }
        function onRelease() {
            if (_isReleaseLocked) {
                if (com.clubpenguin.util.ClipUtils.getBoundsRectangle(canvasMC).contains(canvasMC._parent._xmouse, canvasMC._parent._ymouse)) {
                    draw(_style.buttonLineColorOver, _style.buttonFillColorOver);
                } else {
                    draw(_style.buttonLineColorDefault, _style.buttonFillColorDefault);
                }
                stopDragging();
                _isReleaseLocked = false;
            }
        }
        function onMouseUp() {
            if (_isReleaseLocked) {
                this.onRelease();
            }
        }
        function startDragging() {
            canvasMC.startDrag(false, _startX, 0, (_boundsWidth - _width) + _startX, 0);
            canvasMC.onMouseMove = com.clubpenguin.util.Delegate.create(this, whileDragging);
        }
        function whileDragging() {
            updatePosition(canvasMC._x);
        }
        function stopDragging() {
            canvasMC.onMouseMove = null;
            canvasMC.stopDrag();
        }
        function draw(lineColor, fillColor) {
            var _local_2 = new flash.geom.Rectangle(_xOffset, _yOffset, _width, _height);
            canvasMC.clear();
            com.clubpenguin.util.DrawUtil.drawRoundedRectangle(canvasMC, _local_2, _style.handleCornerRadius + 2, lineColor);
            _local_2.inflate(-_style.buttonLineThickness, -_style.buttonLineThickness);
            com.clubpenguin.util.DrawUtil.drawRoundedRectangle(canvasMC, _local_2, _style.handleCornerRadius, fillColor);
            drawGripLines((((_width - gripLineBoundsWidth) / 2) + _xOffset) + gripLineSpacing, ((_height - gripLineBoundsHeight) / 2) + _yOffset, gripLineBoundsHeight, lineColor);
        }
        function drawGripLines(x, y, h, lineColor) {
            canvasMC.lineStyle(gripLineThickness, lineColor, 100, true, "none", "round", "miter", 1);
            var _local_2 = 0;
            while (_local_2 < numberOfGripLines) {
                canvasMC.moveTo((x + (gripLineThickness * _local_2)) + (gripLineSpacing * _local_2), y);
                canvasMC.lineTo((x + (gripLineThickness * _local_2)) + (gripLineSpacing * _local_2), y + h);
                _local_2++;
            }
        }
        function resize(paneWidthInItems, totalNumberOfItems) {
            _paneWidthInItems = paneWidthInItems;
            _totalNumberOfItems = totalNumberOfItems;
            trace((((((this + " width in items: ") + paneWidthInItems) + " total items: ") + totalNumberOfItems) + " boundsWidth: ") + _boundsWidth);
            setWidth((Math.round((paneWidthInItems / totalNumberOfItems) * 100) / 100) * _boundsWidth);
            if ((_width > _boundsWidth) && (_lastX != undefined)) {
                jumpLeft();
            } else if ((_lastX + _width) > _boundsWidth) {
                jumpRight();
            }
        }
        function jumpLeft() {
            var _local_3 = ((((Math.floor(_paneWidthInItems) - 1) / _totalNumberOfItems) * 100) / 100) * _boundsWidth;
            var _local_2 = canvasMC._x - _local_3;
            if (_local_2 < _startX) {
                _local_2 = _startX;
            }
            updatePosition(_local_2);
        }
        function jumpRight() {
            var _local_3 = ((((Math.floor(_paneWidthInItems) - 1) / _totalNumberOfItems) * 100) / 100) * _boundsWidth;
            var _local_2 = canvasMC._x + _local_3;
            if (_local_2 > ((_boundsWidth - _width) + _startX)) {
                _local_2 = (_boundsWidth - _width) + _startX;
            }
            updatePosition(_local_2);
        }
        function updatePosition(newX) {
            if (newX != _lastX) {
                _lastX = newX;
                canvasMC._x = newX;
                var _local_2 = _boundsWidth - _width;
                if (_local_2 != 0) {
                    var _local_3 = Math.round(((newX - _startX) / _local_2) * 10000) / 10000;
                    trace((this + " update position: ") + _local_3);
                    postionChanged.dispatch(_local_3);
                }
            }
        }
        function setPosition(newPosition) {
            var _local_3 = _boundsWidth - _width;
            var _local_2 = _startX + (_local_3 * newPosition);
            _lastX = _local_2;
            canvasMC._x = _local_2;
        }
        function reset() {
            updatePosition(_startX);
        }
        function destroy() {
            if (_mouseListener.onMouseUp) {
                Mouse.removeListener(_mouseListener);
                _mouseListener.onMouseUp = null;
            }
        }
        function toString() {
            return("[ScrollBarHandleView]");
        }
        var _xOffset = 0;
        var _yOffset = 0;
        var gripLineBoundsHeight = 5;
        var numberOfGripLines = 5;
        var gripLineSpacing = 1;
        var gripLineThickness = 2;
        var minWidth = 25;
        var gripLineBoundsWidth = (com.clubpenguin.igloo.component.scrollpane.view.ScrollBarHandleView.prototype.numberOfGripLines * com.clubpenguin.igloo.component.scrollpane.view.ScrollBarHandleView.prototype.gripLineThickness) + ((com.clubpenguin.igloo.component.scrollpane.view.ScrollBarHandleView.prototype.numberOfGripLines - 1) * com.clubpenguin.igloo.component.scrollpane.view.ScrollBarHandleView.prototype.gripLineSpacing);
    }
