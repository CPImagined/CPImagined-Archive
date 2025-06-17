//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.views.MoreServers extends com.clubpenguin.login.views.ServerSelectionView
    {
        var _moreServersCloseClip, close_btn, _moreServersListClip, list_mc, _pleaseSelectField, select_world_txt, down_btn, up_btn, _visible, viewManager, _shell;
        function MoreServers () {
            super();
            debugTrace("instantiated");
            _moreServersCloseClip = close_btn;
            _moreServersListClip = list_mc;
            _pleaseSelectField = select_world_txt;
            down_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moreServerPageDown);
            up_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moreServerPageUp);
            _moreServersCloseClip.onRelease = com.clubpenguin.util.Delegate.create(this, hideMoreServers);
        }
        function isActive() {
            return(_moreServersActive);
        }
        function show() {
            super.show();
            translateMoreServers();
            setupMoreServers();
            _visible = true;
            _moreServersActive = true;
        }
        function hideMoreServers() {
            _visible = false;
            _moreServersActive = false;
            com.clubpenguin.login.views.ViewManager(viewManager).gotoWorldSelection();
        }
        function translateMoreServers() {
            _pleaseSelectField.text = _shell.getLocalizedString("Please Select a Server").toUpperCase();
        }
        function moreServerPageUp() {
            _currentPage--;
            if (_currentPage < 0) {
                _currentPage = 0;
                return(undefined);
            }
            setupMoreServers();
        }
        function moreServerPageDown() {
            _currentPage++;
            if (_currentPage > getMaxMoreServerPages()) {
                _currentPage = getMaxMoreServerPages();
                return(undefined);
            }
            setupMoreServers();
        }
        function getMaxMoreServerPages() {
            return(Math.ceil(_shell.getWorldList().length / SERVERS_PER_PAGE) - 1);
        }
        function setupMoreServers() {
            var _local_7 = _shell.getWorldList();
            var _local_11 = new Object();
            _local_7.sortOn(_sortOption, Array.CASEINSENSITIVE);
            _local_7 = _shell.paginateArray(_local_7, _currentPage, SERVERS_PER_PAGE);
            var _local_3;
            var _local_9 = 10;
            var _local_10 = 2;
            var _local_8 = 0;
            var _local_4 = 2;
            var _local_2 = 0;
            while (_local_2 < SERVERS_PER_PAGE) {
                if (_local_7[_local_2] != undefined) {
                    _local_3 = createServer(_local_7[_local_2], _local_2);
                    var _local_6 = _local_3.hover_mc._width;
                    var _local_5 = _local_3.hover_mc._height;
                    _local_3._x = (_local_2 % _local_4) * (_local_6 + _local_9);
                    _local_3._y = _local_8 * (_local_5 + _local_10);
                    if ((_local_2 % _local_4) == (_local_4 - 1)) {
                        _local_8++;
                    }
                } else {
                    removeServer(_local_2);
                }
                _local_2++;
            }
        }
        function createServer(server, i) {
            var _local_2 = _moreServersListClip.attachMovie("world_02", "world_" + i, i);
            var _local_4 = ((server.population == com.clubpenguin.login.views.WorldSelection.FIVE_BARS_HIGH) ? (com.clubpenguin.login.views.WorldSelection.FIVE_BARS) : (server.population));
            _local_2.name_txt.text = server.name;
            com.clubpenguin.login.Tools.ResizeTextToFit(_local_2.name_txt, true);
            _local_2.population = _local_4;
            _local_2.pop_mc.gotoAndStop(_local_4);
            if (_local_2.population == com.clubpenguin.login.views.WorldSelection.FULL_POPULATION) {
                _local_2.pop_mc.serverFull.gotoAndStop(_shell.getLocalizedFrame());
            }
            _local_2.id = server.id;
            _local_2.onRollOver = com.clubpenguin.util.Delegate.create(this, rollOverMoreServer, _local_2);
            _local_2.onDragOver = _local_2.onRollOver;
            _local_2.onRollOut = com.clubpenguin.util.Delegate.create(this, rollOffMoreServer, _local_2);
            _local_2.onDragOut = _local_2.onRollOut;
            _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, connectToWorld, _local_2);
            _local_2.pop_mc.buddy_mc.gotoAndStop(1);
            if (server.has_buddies) {
                _local_2.pop_mc.buddy_mc.gotoAndStop(2);
            }
            if (server.is_safe) {
                _local_2.pop_mc.safe_chat_mc._visible = true;
            } else {
                _local_2.pop_mc.safe_chat_mc._visible = false;
            }
            _local_2.hover_mc._visible = false;
            return(_local_2);
        }
        function onRosterUpdated(numBuddies) {
        }
        function removeServer(i) {
            var _local_2 = _moreServersListClip["world_" + i];
            if (_local_2 != null) {
                _local_2.removeMovieClip();
            }
        }
        function rollOverMoreServer(mcServer) {
            mcServer.hover_mc._visible = true;
            mcServer.pop_mc.p1.gotoAndStop(2);
            mcServer.pop_mc.p2.gotoAndStop(2);
            mcServer.pop_mc.p3.gotoAndStop(2);
            mcServer.pop_mc.p4.gotoAndStop(2);
            mcServer.pop_mc.p5.gotoAndStop(2);
        }
        function rollOffMoreServer(mcServer) {
            mcServer.hover_mc._visible = false;
            mcServer.pop_mc.p1.gotoAndStop(1);
            mcServer.pop_mc.p2.gotoAndStop(1);
            mcServer.pop_mc.p3.gotoAndStop(1);
            mcServer.pop_mc.p4.gotoAndStop(1);
            mcServer.pop_mc.p5.gotoAndStop(1);
        }
        function connectToWorld(clip) {
            if (clip.population < com.clubpenguin.login.views.WorldSelection.FULL_POPULATION) {
                _shell.setWorldForConnection(clip.id);
            } else {
                _shell.$e("[login] createServer() -> Server is full!", {error_code:_shell.SERVER_FULL});
            }
        }
        static function debugTrace(msg) {
            if (_debugTracesActive) {
            }
        }
        static var LINKAGE_ID = "com.clubpenguin.login.views.MoreServers";
        static var SERVERS_PER_PAGE = 22;
        static var _debugTracesActive = false;
        var _currentPage = 0;
        var _sortOption = "name";
        var _moreServersActive = false;
    }
