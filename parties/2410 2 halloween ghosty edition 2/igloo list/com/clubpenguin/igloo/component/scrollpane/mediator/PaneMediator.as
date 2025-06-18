//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.mediator.PaneMediator
    {
        var _view, _model;
        function PaneMediator (view, model, removeAllRenderersOnUpdate) {
            _view = view;
            _model = model;
            _model.getTotalNumberOfItems();
            _model.itemsUpdated.add(onItemsUpdated, this);
            _model.postionUpdated.add(onPositionUpdated, this);
            _removeAllRenderersOnUpdate = removeAllRenderersOnUpdate;
        }
        function destroy() {
            _model.itemsUpdated.remove(onItemsUpdated, this);
            _model.postionUpdated.remove(onPositionUpdated, this);
            _view = null;
            _model = null;
        }
        function onPositionUpdated(newPosition) {
            _view.updatePosition(newPosition);
        }
        function onItemsUpdated() {
            trace(newline);
            trace("+++++++++++++++++++++++++++++");
            trace("PaneMediator");
            trace("onItemsUpdated");
            trace("+++++++++++++++++++++++++++++");
            _view.update(_model.getVisibleItems(), _removeAllRenderersOnUpdate);
        }
        function getItemClickedSignal() {
            return(_view.itemClicked);
        }
        var _removeAllRenderersOnUpdate = false;
    }
