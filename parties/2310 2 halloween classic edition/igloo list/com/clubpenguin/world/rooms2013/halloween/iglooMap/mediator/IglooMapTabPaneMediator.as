//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.mediator.IglooMapTabPaneMediator
    {
        var _context, _view, _mainModel;
        function IglooMapTabPaneMediator (context, view, mainModel) {
            _context = context;
            _view = view;
            _mainModel = mainModel;
            _view.selected_tab.onRelease = function () {
            };
            _view.selected_tab.useHandCursor = false;
            _view.spinningArrowClip.stop();
            _view.spinningArrowClip._visible = false;
            trace("Igloo Map Tab Pane Mediator " + _view.spinningArrowClip);
            var _local_4 = [new com.clubpenguin.world.rooms2013.halloween.iglooMap.vo.IglooMapTabVO("2", _context.getLocalizedString("w.igloo.map.tab.everyone"), [new com.clubpenguin.util.collection.operators.FilterOperator("isFriend", false), new com.clubpenguin.util.collection.operators.SortOperator(["name"], [Array.ASCENDING])])];
            var _local_3 = _view.getUnselectedTabs();
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                _local_3[_local_2].label.text = _local_4[_local_2].label;
                _local_3[_local_2].onRelease = com.clubpenguin.util.Delegate.create(this, onTabRelease, _local_3[_local_2], _local_4[_local_2]);
                _local_2++;
            }
            selectTab(_local_3[0], _local_4[0]);
        }
        function onTabRelease(clip, tabVO) {
            selectTab(clip, tabVO);
            _mainModel.playerList.refresh();
        }
        function selectTab(clip, tabVO) {
            _view.selected_tab.label.text = tabVO.label;
            _view.selected_tab._x = clip._x;
            _mainModel.playerList.setOperators(tabVO.operators);
            if (tabVO.id == FRIENDS_TAB_ID) {
                if (!_gotFriendsIglooList) {
                    _view.spinningArrowClip.gotoAndPlay(1);
                    _view.spinningArrowClip._visible = true;
                }
                if (!_requestedFriendsIglooList) {
                    _requestedFriendsIglooList = true;
                    _mainModel.getFriendsIglooList();
                    _mainModel.friendsIglooListReceived.addOnce(onFriendsIglooListReceived, this);
                }
            } else {
                _view.spinningArrowClip.stop();
                _view.spinningArrowClip._visible = false;
            }
        }
        function onFriendsIglooListReceived() {
            trace(this + "onFriendsIglooListReceived");
            _gotFriendsIglooList = true;
            _view.spinningArrowClip.stop();
            _view.spinningArrowClip._visible = false;
            _mainModel.playerList.refresh();
        }
        function toString() {
            return("[IglooMapListMediator]");
        }
        static var FRIENDS_TAB_ID = 1;
        var _requestedFriendsIglooList = false;
        var _gotFriendsIglooList = false;
    }
