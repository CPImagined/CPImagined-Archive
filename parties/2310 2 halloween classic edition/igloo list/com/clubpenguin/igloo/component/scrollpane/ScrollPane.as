//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.ScrollPane
    {
        var _model, _scrollPaneView, _scrollPaneMediator;
        function ScrollPane (mc, x, y, width, height, itemCollection, itemRenderer, style, removeAllRenderersOnUpdate) {
            _model = new com.clubpenguin.igloo.component.scrollpane.model.ScrollPaneModel(itemCollection, style);
            _scrollPaneView = new com.clubpenguin.igloo.component.scrollpane.ScrollPaneView(mc, x, y, width, height, itemRenderer, style);
            _scrollPaneMediator = new com.clubpenguin.igloo.component.scrollpane.ScrollPaneMediator(_scrollPaneView, _model, removeAllRenderersOnUpdate);
        }
        function destroy() {
            _scrollPaneMediator.destroy();
            _model.destroy();
            _scrollPaneView.destroy();
        }
        function refresh() {
            _model.refresh();
        }
        function getItemClickedSignal() {
            return(_scrollPaneMediator.getItemClickedSignal());
        }
        function getItemsPerRow() {
            return(_scrollPaneView.getItemsPerRow());
        }
        function getItemsPerColumn() {
            return(_scrollPaneView.getItemsPerColumn());
        }
        function resetScrollPane() {
            _model.resetScrollPane();
        }
        function toString() {
            return("[ScrollPane]");
        }
    }
