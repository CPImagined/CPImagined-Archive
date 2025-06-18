//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.TrickorTreat_IglooMapContext
    {
        var SHELL, ENGINE, INTERFACE, AIRTOWER, _container, _clientPath, _contentPath, _iglooMapModel, _iglooMapMediator;
        function TrickorTreat_IglooMapContext (SHELL, INTERFACE, ENGINE, AIRTOWER, container, clientPath, contentPath) {
            if (SHELL == undefined) {
                trace(this + " WARNING: Shell is null. Check igloo_map.fla to see if init is being called. If so, remove it.");
            }
            trace("\n\n\n###### Igloo Map ######\n\n");
            trace(this + " initializing");
            this.SHELL = SHELL;
            this.ENGINE = ENGINE;
            this.INTERFACE = INTERFACE;
            this.AIRTOWER = AIRTOWER;
            _container = container;
            _clientPath = clientPath;
            _contentPath = contentPath;
            _iglooMapModel = new com.clubpenguin.world.rooms2013.halloween.iglooMap.TrickorTreat_IglooMapModel(this);
            _iglooMapMediator = new com.clubpenguin.world.rooms2013.halloween.iglooMap.TrickorTreat_IglooMapMediator(this, _container.iglooMap, _iglooMapModel);
            _iglooMapModel.init();
        }
        function destroy() {
            trace("destroy igloo map context");
            _iglooMapModel.destroy();
            _iglooMapMediator.destroy();
        }
        function closeMap(closeGlobalMap) {
            trace("closeMap");
            destroy();
            INTERFACE.closeContent();
        }
        function get connection() {
            return(AIRTOWER.getServer());
        }
        function get currentServerRoomID() {
            return(SHELL.getCurrentServerRoomId());
        }
        function get myPlayerID() {
            return(SHELL.getMyPlayerId());
        }
        function get myPlayerName() {
            return(SHELL.getMyPlayerObject().nickname);
        }
        function get localizedFrame() {
            return(SHELL.getLocalizedFrame());
        }
        function showHint(clip, text, xOffset, yOffset, isLocalized) {
            INTERFACE.showHint(clip, text, xOffset, yOffset, isLocalized);
        }
        function closeHint() {
            INTERFACE.closeHint();
        }
        function joinPlayerIgloo(playerID) {
            destroy();
            INTERFACE.sendJoinPlayerIgloo(playerID);
        }
        function joinMyIgloo() {
            destroy();
            INTERFACE.sendJoinPlayerIgloo(myPlayerID);
        }
        function getFriendsRoster() {
            var _local_3 = SHELL.ROSTER.buddies;
            var _local_4 = {};
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                if (_local_3[_local_2].player_id != -1) {
                    _local_4[_local_3[_local_2].player_id] = _local_3[_local_2];
                }
                _local_2++;
            }
            return(_local_4);
        }
        function getLocalizedString(key) {
            return(SHELL.getLocalizedString(key));
        }
        function toString() {
            return("[IglooMapContext]");
        }
    }
