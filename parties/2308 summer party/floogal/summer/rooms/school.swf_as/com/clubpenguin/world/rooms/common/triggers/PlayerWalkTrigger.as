dynamic class com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger extends com.clubpenguin.world.rooms.common.triggers.PlayerTrigger
{
    var _playerCount;
    var _playerSnapshot;
    var _prevPlayerSnapshot;
    var playersAdded;
    var playersRemoved;
    var playersWalking;

    function PlayerWalkTrigger(triggerArea)
    {
        super(triggerArea);
    }

    function endSnapshot()
    {
        var __reg0;
        for (var __reg2 in this._prevPlayerSnapshot) 
        {
            if (this._playerSnapshot[__reg2]) 
            {
                if ((this._prevPlayerSnapshot[__reg2] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED || this._prevPlayerSnapshot[__reg2] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING) && this._playerSnapshot[__reg2] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED) 
                {
                    this._playerSnapshot[__reg2] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING;
                }
            }
            else 
            {
                this._playerSnapshot[__reg2] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.GONE;
                continue;
            }
        }
        var __reg3 = [];
        var __reg5 = [];
        var __reg4 = [];
        for (__reg2 in this._playerSnapshot) 
        {
            if ((__reg0 = this._playerSnapshot[__reg2]) === com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.WALKING) 
            {
                ++this._playerCount;
                __reg3.push(__reg2);
                if (!this._prevPlayerSnapshot[__reg2]) 
                {
                    __reg5.push(__reg2);
                }
            }
            else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.GONE) 
            {
                __reg4.push(__reg2);
                delete this._playerSnapshot[__reg2];
            }
        }
        if (__reg3.length >= 0) 
        {
            this.playersWalking.dispatch(__reg3);
        }
        if (__reg5.length > 0) 
        {
            this.playersAdded.dispatch(__reg5);
        }
        if (__reg4.length > 0) 
        {
            this.playersRemoved.dispatch(__reg4);
        }
    }

}
