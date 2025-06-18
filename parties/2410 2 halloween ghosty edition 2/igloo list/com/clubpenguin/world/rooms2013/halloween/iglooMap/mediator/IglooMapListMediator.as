//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.mediator.IglooMapListMediator
    {
        var _context, _view, _mainModel, _tabPaneMediator, _scrollPane;
        function IglooMapListMediator (context, view, mainModel) {
            _context = context;
            _view = view;
            _mainModel = mainModel;
            _view.local_player.setVO(_mainModel.localPlayer);
            _view.local_player.lock_icon._visible = false;
            _view.local_player.penguin_icon._visible = false;
            _view.local_player.populationValueTxt._visible = false;
            _view.local_player.getItemClickedSignal().add(com.clubpenguin.util.Delegate.create(this, onLocalPlayerClick), this);
            _mainModel.onInitialized.addOnce(com.clubpenguin.util.Delegate.create(this, onMainModelInitialized), this);
        }
        function destroy() {
            _view.local_player.getItemClickedSignal().remove(onLocalPlayerClick, this);
        }
        function onMainModelInitialized() {
            var _local_2 = new com.clubpenguin.igloo.component.scrollpane.style.ScrollPaneStyle();
            _local_2.itemRendererXOffset = 0;
            _local_2.itemRendererYOffset = 20;
            _tabPaneMediator = new com.clubpenguin.world.rooms2013.halloween.iglooMap.mediator.IglooMapTabPaneMediator(_context, _view.tab_pane, _mainModel);
            var _local_3 = _view.createEmptyMovieClip("scrollPaneView", _view.getNextHighestDepth());
            _scrollPane = new com.clubpenguin.igloo.component.scrollpane.ScrollPane(_local_3, 10, 132, 200, 285, _mainModel.playerList, com.clubpenguin.world.rooms2013.halloween.iglooMap.view.IglooMapListItemRenderer, _local_2, true);
            _scrollPane.getItemClickedSignal().add(com.clubpenguin.util.Delegate.create(this, onItemClicked), this);
            _scrollPane.refresh();
            _view.local_player.setVO(_mainModel.localPlayer);
            _view.local_player.lock_icon._visible = false;
            _view.local_player.penguin_icon._visible = false;
        }
        function onLocalPlayerClick(playerVO) {
            trace((this + " local player clicked: ") + playerVO);
            _context.joinMyIgloo();
        }
        function onItemClicked(playerVO) {
            trace((this + " other player clicked: ") + playerVO);
            _context.joinPlayerIgloo(Number(playerVO.playerID));
        }
        function toString() {
            return("[IglooMapListMediator]");
        }
    }
