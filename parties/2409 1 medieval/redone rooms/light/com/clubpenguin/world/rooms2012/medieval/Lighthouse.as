//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.Lighthouse extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, setupNavigationButtons, _triggerWatcher, _garyWaveExplosion, _roomUpdateInterval, _delayedLeaveRoomCall, _INTERFACE;
        function Lighthouse (stageReference) {
            super(stageReference);
            _stage.start_x = 215;
            _stage.start_y = 335;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.exit_beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 305, 255);
            _stage.triggers_mc.exit_beacon_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beacon", 212, 335);
            _stage.background_mc.btn_totop.onRelease = com.clubpenguin.util.Delegate.create(this, exit, "beacon", 212, 335);
            _stage.btn_telescope.onRelease = com.clubpenguin.util.Delegate.create(this, showTelescopeCloseup);
            _stage.interface_mc.music_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openCatalog);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.btn_frontdoor, 170, 290)]);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _garyWaveExplosion = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.garypoof_mc);
            _garyWaveExplosion.requireAction(com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.DANCING);
            _garyWaveExplosion.playersStanding.add(com.clubpenguin.util.Delegate.create(this, showGaryExplosion));
            _triggerWatcher.addTrigger(_garyWaveExplosion);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 80);
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function showGaryExplosion(playerList) {
            if (playerList.length <= 0) {
                return(undefined);
            }
            if (_stage.garyExplosion._currentframe == 1) {
                _stage.garyExplosion.gotoAndPlay(2);
                if (playerList[0] == _SHELL.getMyPlayerId()) {
                    clearInterval(_delayedLeaveRoomCall);
                    _delayedLeaveRoomCall = setInterval(this, "delayedLeaveRoom", 180);
                }
            }
        }
        function delayedLeaveRoom() {
            clearInterval(_delayedLeaveRoomCall);
            _SHELL.sendJoinRoom("beach", 29, 222);
        }
        function showTelescopeCloseup() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2012.medieval.MedievalParty.CONTENT_TELESCOPE_CLOSE_UP);
        }
        function openCatalog() {
            _INTERFACE.showContent("light_catalogue");
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_delayedLeaveRoomCall);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_roomUpdateInterval);
        }
        static var CLASS_NAME = "Lighthouse";
    }
