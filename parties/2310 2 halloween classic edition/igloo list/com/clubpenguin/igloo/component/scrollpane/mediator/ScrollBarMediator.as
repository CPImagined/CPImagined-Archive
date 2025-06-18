//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.mediator.ScrollBarMediator
    {
        var _view, _model;
        function ScrollBarMediator (view, model) {
            _view = view;
            _model = model;
            _model.itemsUpdated.add(onItemsUpdated, this);
            _model.scrollPaneReset.add(onScrollPaneReset, this);
            trace("[Igloo] ScrollBarMediator _view.getPositionChangedSignal(): " + _view.getPositionChangedSignal());
            _view.getPositionChangedSignal().add(onScrollBarPositionChanged, this);
        }
        function destroy() {
            _model.itemsUpdated.remove(onItemsUpdated, this);
            _model.scrollPaneReset.remove(onScrollPaneReset, this);
            _view.getPositionChangedSignal().remove(onScrollBarPositionChanged, this);
            _view = null;
            _model = null;
        }
        function onItemsUpdated() {
            if (_model.getTotalNumberOfItems() > 0) {
                if (_model.isVertical) {
                    trace((this + " resizing scroll bar: ") + [_model.getNumberOfItemsPerColumn(), _model.getTotalNumberOfItems()]);
                    _view.resize(_model.getNumberOfItemsPerColumn(), _model.getTotalNumberOfItems());
                } else if (_model.isHorizontal) {
                    _view.resize(_model.getNumberOfItemsPerRow(), _model.getTotalNumberOfItems());
                }
                _view.getScrollHandle().setPosition(_model.currentPosition);
            }
        }
        function onScrollBarPositionChanged(newPos) {
            _model.updatePosition(newPos);
        }
        function onScrollPaneReset() {
            var _local_2 = _view.getScrollHandle();
            _local_2.reset(0);
        }
        function toString() {
            return("[ScrollBarMediator]");
        }
    }
