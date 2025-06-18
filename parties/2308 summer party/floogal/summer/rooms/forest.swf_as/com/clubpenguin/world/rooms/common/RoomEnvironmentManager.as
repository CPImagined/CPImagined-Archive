dynamic class com.clubpenguin.world.rooms.common.RoomEnvironmentManager
{
    var _ENGINE;
    var _SHELL;
    var _environmentMovieClips;
    var _playerMoveDoneFunc;
    var _roomBehaviorFactory;
    var _stageReference;

    function RoomEnvironmentManager(stageReference, shellMC, engineMC)
    {
        this._stageReference = stageReference;
        this._SHELL = shellMC;
        this._ENGINE = engineMC;
        this._roomBehaviorFactory = com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory.getInstance();
        this._playerMoveDoneFunc = com.clubpenguin.util.Delegate.create(this, this.onPlayerMoveDone);
        this._SHELL.addListener(this._SHELL.PLAYER_MOVE_DONE, this._playerMoveDoneFunc);
    }

    function destroy()
    {
        this._SHELL.removeListener(this._SHELL.PLAYER_MOVE_DONE, this._playerMoveDoneFunc);
    }

    function setupEnvironmentTriggers()
    {
        this._environmentMovieClips = new Array();
        this.searchForEnvironmentMovieClips();
    }

    function searchForEnvironmentMovieClips()
    {
        for (var __reg2 in this._stageReference) 
        {
            if (this._stageReference[__reg2].environmentType) 
            {
                this._environmentMovieClips.push(this._stageReference[__reg2]);
            }
        }
    }

    function checkTriggers(player_obj)
    {
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= this._environmentMovieClips.length) 
            {
                return;
            }
            var __reg3 = this._ENGINE.puffleAvatarController.getPuffleClip(player_obj.attachedPuffle.id);
            if (__reg3 && this._environmentMovieClips[__reg2].hitTest(__reg3._x, __reg3._y, true)) 
            {
                var __reg4 = this._roomBehaviorFactory.getRoomBehavior(this._environmentMovieClips[__reg2].environmentType);
                __reg4.applyEffect(player_obj.player_id);
            }
            ++__reg2;
        }
    }

    function onPlayerMoveDone(player_obj)
    {
        if (player_obj.attachedPuffle) 
        {
            this.checkTriggers(player_obj);
        }
    }

    function checkHitTestWithEnvironmentMC(targetMC)
    {
        var __reg2 = 0;
        while (__reg2 < this._environmentMovieClips.length) 
        {
            if (this._environmentMovieClips[__reg2].hitTest(targetMC._x, targetMC._y, true)) 
            {
                return true;
            }
            ++__reg2;
        }
        return false;
    }

}
