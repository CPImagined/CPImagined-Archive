//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.FunHouse extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _ENGINE, _currentPlayerID, _SHELL, _triggerWatcher, _puffleExitDoor, _roomUpdateInterval, _playerTalkDelegate, _INTERFACE, _destroyDelegate;
        function FunHouse (stageReference) {
            super();
            _stage = stageReference;
            _stage.triggers_mc.triggerExit.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit);
        }
        function exit() {
            _ENGINE.sendJoinRoom("party3", 134, 212);
        }
        function init() {
            trace("FunHouse init()");
            _currentPlayerID = _SHELL.getMyPlayerId();
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _puffleExitDoor = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerMouthOpenClose);
            _puffleExitDoor.playersAdded.add(com.clubpenguin.util.Delegate.create(this, exitDoorOpen));
            _puffleExitDoor.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, exitDoorClose));
            _triggerWatcher.addTrigger(_puffleExitDoor);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 100);
        }
        function exitDoorClose() {
            _stage.puffleExit.gotoAndStop("close");
        }
        function exitDoorOpen() {
            _stage.puffleExit.gotoAndStop("open");
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_roomUpdateInterval);
        }
        static var CLASS_NAME = "FunHouse";
    }
