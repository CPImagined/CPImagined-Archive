//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.views.WorldSelection extends com.clubpenguin.login.views.ServerSelectionView
    {
        var _backgroundClip, bg_mc, _suggestedWorldClips, world_00_mc, world_01_mc, world_02_mc, world_03_mc, world_04_mc, _redemptionBadgeClip, redemption_mc, _selectWorldField, select_world_txt, _buddiesField, buddies_txt, _numPenguinsOnlineField, amount_peng_txt, _ultimateSafeChatField, ultimate_safe_txt, _moreServersClip, more_servers_btn, _trackerAS2, _contentTracked, _localizedTrackingName, _languageAbbreviation, viewManager, _visible, _shell, hide, _selectedWorldID;
        function WorldSelection () {
            super();
            debugTrace("instantiated..");
            _backgroundClip = bg_mc;
            _suggestedWorldClips = new Array(world_00_mc, world_01_mc, world_02_mc, world_03_mc, world_04_mc);
            _backgroundClip.onRelease = undefined;
            _backgroundClip.useHandCursor = false;
            _backgroundClip.tabEnabled = false;
            _redemptionBadgeClip = redemption_mc;
            _selectWorldField = select_world_txt;
            _buddiesField = buddies_txt;
            _numPenguinsOnlineField = amount_peng_txt;
            _ultimateSafeChatField = ultimate_safe_txt;
            _moreServersClip = more_servers_btn;
            _moreServersClip.onRelease = com.clubpenguin.util.Delegate.create(this, showMoreServersOnRelease);
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            _contentTracked = false;
            _localizedTrackingName = "";
        }
        function setLanguageAbbr(abbr) {
            _languageAbbreviation = abbr;
            _localizedTrackingName = TRACKING_NAME + abbr.toLowerCase();
        }
        function show() {
            debugTrace("show - isMoreServersActive: " + com.clubpenguin.login.views.ViewManager(viewManager).isMoreServersActive());
            if (!com.clubpenguin.login.views.ViewManager(viewManager).isMoreServersActive()) {
                _visible = true;
            }
            if ((!_contentTracked) && (_localizedTrackingName.length > 0)) {
                _contentTracked = true;
                _shell.trackContent(_localizedTrackingName);
            }
        }
        function showMoreServersOnRelease() {
            this.hide();
            com.clubpenguin.login.views.ViewManager(viewManager).gotoMoreServers();
        }
        function setupWorldSelection() {
            debugTrace("setupWorldSelection");
            setRedemptionForWorldSelection();
            translateWorldSelection();
            com.clubpenguin.login.Keyboard.clearOnEnterFunction();
            chooseServerScreen();
            this.show();
        }
        function setRedemptionForWorldSelection() {
            _redemptionBadgeClip._visible = true;
            _redemptionBadgeClip.onRelease = com.clubpenguin.util.Delegate.create(this, onRedemptionPress);
        }
        function onRedemptionPress() {
            _shell.gotoState(_shell.MERCH_STATE);
        }
        function translateWorldSelection() {
            _redemptionBadgeClip.gotoAndStop(_languageAbbreviation);
            _selectWorldField.text = _shell.getLocalizedString("Your Suggested Servers").toUpperCase();
            _buddiesField.text = _shell.getLocalizedString("Buddies online");
            _numPenguinsOnlineField.text = _shell.getLocalizedString("Amount of penguins online");
            _ultimateSafeChatField.text = _shell.getLocalizedString("Ultimate safe chat");
            var _local_2 = _shell.getLocalizedFrame();
            _moreServersClip.gotoAndStop(_local_2);
        }
        function chooseServerScreen() {
            var _local_3 = com.clubpenguin.login.LocalData.getLastWorldIdForActivePlayer();
            var _local_2 = _shell.getSortedWorldList();
            if (_local_3 != undefined) {
                showReturnUser(_local_2, _local_3);
            } else {
                setupWorldClips(_local_2);
            }
        }
        function showReturnUser(serverList, lastWorldId) {
            var _local_4 = serverList.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                if (serverList[_local_2].id == lastWorldId) {
                    serverList.splice(_local_2, 1);
                    break;
                }
                _local_2++;
            }
            var _local_6 = _shell.getWorldById(lastWorldId);
            if (_local_6.population == FULL_POPULATION) {
                serverList.splice(1, 0, _local_6);
            } else {
                serverList.splice(0, 0, _local_6);
            }
            setupWorldClips(serverList);
        }
        function setupWorldClips(data) {
            var _local_6 = _suggestedWorldClips.length;
            var _local_3 = 0;
            while (_local_3 < _local_6) {
                var _local_2 = _suggestedWorldClips[_local_3];
                if (data[_local_3] == undefined) {
                    _local_2._visible = false;
                } else {
                    var _local_5 = ((data[_local_3].population == FIVE_BARS_HIGH) ? (FIVE_BARS) : (data[_local_3].population));
                    _local_2.name_txt.text = data[_local_3].name;
                    com.clubpenguin.login.Tools.ResizeTextToFit(_local_2.name_txt, true);
                    _local_2.pop_mc.gotoAndStop(_local_5);
                    _local_2.population = _local_5;
                    if (_local_2.population == FULL_POPULATION) {
                        _local_2.pop_mc.serverFull.gotoAndStop(_shell.getLocalizedFrame());
                    }
                    _local_2.id = data[_local_3].id;
                    _local_2.onRollOver = com.clubpenguin.util.Delegate.create(this, rollOverWorldSelection, _local_2);
                    _local_2.onDragOver = _local_2.onRollOver;
                    _local_2.onRollOut = com.clubpenguin.util.Delegate.create(this, rollOutWorldSelection, _local_2);
                    _local_2.onDragOut = _local_2.onRollOut;
                    _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, connectToWorld, _local_2);
                    _local_2.hover_mc._visible = false;
                    _local_2.pop_mc.buddy_mc.gotoAndStop(1);
                    if (data[_local_3].has_buddies) {
                        _local_2.pop_mc.buddy_mc.gotoAndStop(2);
                    }
                    if (data[_local_3].is_safe) {
                        _local_2.pop_mc.safe_chat_mc._visible = true;
                    } else {
                        _local_2.pop_mc.safe_chat_mc._visible = false;
                    }
                }
                _local_3++;
            }
            if (!worldSelectLogSent) {
                worldSelectLogSent = true;
            }
        }
        function onRosterUpdated(numBuddies) {
            chooseServerScreen();
        }
        function rollOverWorldSelection(worldClip) {
            worldClip.hover_mc._visible = true;
        }
        function rollOutWorldSelection(worldClip) {
            worldClip.hover_mc._visible = false;
        }
        function connectToWorld(worldClip) {
            if ((worldClip.population == undefined) || (worldClip.population < FULL_POPULATION)) {
                _selectedWorldID = worldClip.id;
                _shell.setWorldForConnection(_selectedWorldID);
            } else if (_shell._localLoginServerData.autoLogin) {
                _shell.tryNextValidWorldLogin();
            } else {
                _shell.$e("[login] createServer() -> Server is full!", {error_code:_shell.SERVER_FULL});
            }
        }
        static function debugTrace(msg) {
            if (_debugTracesActive) {
            }
        }
        static var LINKAGE_ID = "com.clubpenguin.login.views.WorldSelection";
        static var FULL_POPULATION = 7;
        static var FIVE_BARS_HIGH = 6;
        static var FIVE_BARS = 5;
        static var FOUR_BARS = 4;
        static var THREE_BARS = 3;
        static var TWO_BARS = 2;
        static var ONE_BARS = 1;
        static var TARGET_POPULATION = 3;
        static var SUGGESTED_WORLD_DISPLAY_COUNT = 5;
        static var TRACKING_NAME = "select_server_";
        static var _debugTracesActive = true;
        var worldSelectLogSent = false;
    }
