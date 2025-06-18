class com.clubpenguin.igloo.furniture.FairWinds
{
    var _view, SHELL, handlePlayerMoveCompleteDelegate, handleRoomDestroyedDelegate, cookieKey;
    function FairWinds(shellRef, view) {
        _view = view;
        SHELL = shellRef;
        handlePlayerMoveCompleteDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveComplete);
        handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed);
        SHELL.addListener(SHELL.PLAYER_MOVE_DONE, handlePlayerMoveCompleteDelegate);
        SHELL.addListener(SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate);
		cookieKey = "fairWindsFurniture";
        _view.partyTriggerClip._visible = false;
    }
    function handlePlayerMoveComplete(event) {
        if (!SHELL.isMyPlayer(event.player_id)) {
            return;
        };
		if(!_view.partyTriggerClip.hitTest(event.x, event.y)) {
			return undefined;
		};
		var _loc3_ = SHELL.getCookie(SHELL.CLIENT_COOKIE, cookieKey);
		if(_loc3_.active) {
			return undefined;
		};
		SHELL.addCookie(SHELL.CLIENT_COOKIE, cookieKey, {active: true});
        SHELL.sendJoinRoom("ship");
    }
    function handleRoomDestroyed() {
		SHELL.deleteCookie(SHELL.CLIENT_COOKIE, cookieKey);
        SHELL.removeListener(SHELL.PLAYER_MOVE_DONE, handlePlayerMoveCompleteDelegate);
        SHELL.removeListener(SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate);
    }
}
