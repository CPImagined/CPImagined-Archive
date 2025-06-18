//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Party9 extends com.clubpenguin.world.rooms.MazeRoom
    {
        var mazeCompleteTaskId, mazeCompletePopupPathToken, exit, _stage;
        function Party9 (stageReference) {
            super(stageReference);
            mazeCompletePopupPathToken = "w.p2024.holiday.herbert.3";
            _stage.triggers_mc.exitTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 375, 110);
        }
    }
