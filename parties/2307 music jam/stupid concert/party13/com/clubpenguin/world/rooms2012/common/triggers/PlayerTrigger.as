dynamic class com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger
{
    static var WALKING: String = "walking";
    static var STANDING: String = "standing";
    static var GONE: String = "gone";
    static var STOPPED: String = "stopped";
    var _clothingRequirements;
    var _isLocalPlayerOnly;
    var _playerCount;
    var _playerSnapshot;
    var _prevPlayerSnapshot;
    var _requiredAction;
    var _triggerArea;
    var playersAdded;
    var playersRemoved;
    var playersStanding;
    var playersWalking;

    function PlayerTrigger(triggerArea)
    {
        this._triggerArea = triggerArea;
        this._triggerArea;
        this.playersAdded = new org.osflash.signals.Signal(Array);
        this.playersRemoved = new org.osflash.signals.Signal(Array);
        this.playersStanding = new org.osflash.signals.Signal(Array);
        this.playersWalking = new org.osflash.signals.Signal(Array);
        this._prevPlayerSnapshot = {};
        this._playerSnapshot = {};
        this._playerCount = 0;
        this._isLocalPlayerOnly = false;
    }

    function getBounds(mc)
    {
        if (mc) 
        {
            return this._triggerArea.getBounds(mc);
        }
        return this._triggerArea.getBounds();
    }

    function beginSnapshot()
    {
        this._prevPlayerSnapshot = this._playerSnapshot;
        this._playerSnapshot = {};
        this._playerCount = 0;
    }

    function getPlayerCount()
    {
        return this._playerCount;
    }

    function getPlayersWhoAre(state)
    {
        var __reg2 = [];
        for (var __reg3 in this._playerSnapshot) 
        {
            if (this._playerSnapshot[__reg3] == state) 
            {
                __reg2.push(Number(__reg3));
            }
        }
        return __reg2;
    }

    function getAllPlayers()
    {
        var __reg2 = [];
        for (var __reg3 in this._playerSnapshot) 
        {
            __reg2.push(Number(__reg3));
        }
        return __reg2;
    }

    function endSnapshot()
    {
        for (var __reg6 in this._prevPlayerSnapshot) 
        {
            if (this._playerSnapshot[__reg6]) 
            {
                if ((this._prevPlayerSnapshot[__reg6] == com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STOPPED || this._prevPlayerSnapshot[__reg6] == com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STANDING) && this._playerSnapshot[__reg6] == com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STOPPED) 
                {
                    this._playerSnapshot[__reg6] = com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STANDING;
                }
            }
            else 
            {
                this._playerSnapshot[__reg6] = com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.GONE;
                continue;
            }
        }
        var __reg5 = [];
        var __reg2 = [];
        var __reg3 = [];
        var __reg4 = [];
        for (__reg6 in this._playerSnapshot) 
        {
            if ((__reg0 = this._playerSnapshot[__reg6]) === com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.WALKING) 
            {
                ++this._playerCount;
                __reg5.push(__reg6);
            }
            else if (__reg0 === com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STANDING) 
            {
                ++this._playerCount;
                __reg3.push(__reg6);
            }
            else if (__reg0 === com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STOPPED) 
            {
                ++this._playerCount;
                __reg2.push(__reg6);
            }
            else if (__reg0 === com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.GONE) 
            {
                __reg4.push(__reg6);
                delete this._playerSnapshot[__reg6];
            }
        }
        if (__reg5.length >= 0) 
        {
            this.playersWalking.dispatch(__reg5);
        }
        if (__reg3.length >= 0) 
        {
            this.playersStanding.dispatch(__reg3);
        }
        if (__reg2.length > 0) 
        {
            this.playersAdded.dispatch(__reg2);
        }
        if (__reg4.length > 0) 
        {
            this.playersRemoved.dispatch(__reg4);
        }
    }

    function hitTest(player, playerMC)
    {
        if (this._isLocalPlayerOnly && !com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isLocalPlayer(player)) 
        {
            return false;
        }
        if (this._requiredAction && !com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isPlayer(player, this._requiredAction)) 
        {
            return false;
        }
        if (!this.clothingRequirementMet(player)) 
        {
            return false;
        }
        if (this._triggerArea.hitTest(playerMC._x, playerMC._y, true)) 
        {
            if (playerMC.is_moving) 
            {
                this._playerSnapshot[player.player_id] = com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.WALKING;
            }
            else 
            {
                this._playerSnapshot[player.player_id] = com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STOPPED;
            }
            return true;
        }
        return false;
    }

    function isLocalPlayerOnly()
    {
        this._isLocalPlayerOnly = true;
    }

    function clothingRequirementMet(player)
    {
        if (!this._clothingRequirements) 
        {
            return true;
        }
        var __reg2 = 0;
        while (__reg2 < this._clothingRequirements.length) 
        {
            if (!com.clubpenguin.world.rooms2012.common.triggers.ClothingRequirement(this._clothingRequirements[__reg2]).isWornBy(player)) 
            {
                return false;
            }
            ++__reg2;
        }
        return true;
    }

    function addClothingRequirement(bodyPart, clothingID)
    {
        if (!this._clothingRequirements) 
        {
            this._clothingRequirements = [];
        }
        this._clothingRequirements.push(new com.clubpenguin.world.rooms2012.common.triggers.ClothingRequirement(bodyPart, clothingID));
    }

    function requireAction(action)
    {
        this._requiredAction = action;
    }

}
