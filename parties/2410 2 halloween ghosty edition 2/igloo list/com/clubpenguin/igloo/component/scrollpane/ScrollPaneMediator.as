//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.ScrollPaneMediator
    {
        var _view, _model, _scrollBarMediator, _paneMediator;
        function ScrollPaneMediator (view, model, removeAllRenderersOnUpdate) {
            _view = view;
            _model = model;
            _model.itemsUpdated.add(onItemsUpdated, this);
            _model.itemsPerPageChanged.add(onItemsUpdated, this);
            _scrollBarMediator = new com.clubpenguin.igloo.component.scrollpane.mediator.ScrollBarMediator(_view.scrollBar, _model);
            _paneMediator = new com.clubpenguin.igloo.component.scrollpane.mediator.PaneMediator(_view.pane, _model, removeAllRenderersOnUpdate);
            _model.setNumberOfItemsPerPage(_view.getItemsPerRow(), _view.getItemsPerColumn());
        }
        function destroy() {
            _scrollBarMediator.destroy();
            _paneMediator.destroy();
            _model.itemsUpdated.remove(onItemsUpdated, this);
            _model.itemsPerPageChanged.remove(onItemsUpdated, this);
            _view = null;
            _model = null;
            _scrollBarMediator = null;
            _paneMediator = null;
        }
        function onItemsUpdated() {
            if (_model.isVertical) {
                if (_model.getVisibleItems().length <= _view.getItemsPerColumn()) {
                    _view.hideScrollbar();
                } else {
                    _view.showScrollbar();
                }
            } else if (_model.isHorizontal) {
                if (_model.getVisibleItems().length <= _view.getItemsPerRow()) {
                    _view.hideScrollbar();
                } else {
                    _view.showScrollbar();
                }
            }
        }
        function getItemClickedSignal() {
            return(_paneMediator.getItemClickedSignal());
        }
    }
