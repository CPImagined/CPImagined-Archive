dynamic class com.clubpenguin.world.rooms.common.triggers.PlayerTrigger
{
    static var WALKING: String = "walking";
    static var STANDING: String = "standing";
    static var GONE: String = "gone";
    static var STOPPED: String = "stopped";
    var _isValid: Boolean = true;
    static var DEBUG: Boolean = false;
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
        if (this._triggerArea == null) 
        {
            this._isValid = false;
        }
        this.playersAdded = new org.osflash.signals.Signal(Array);
        this.playersRemoved = new org.osflash.signals.Signal(Array);
        this.playersStanding = new org.osflash.signals.Signal(Array);
        this.playersWalking = new org.osflash.signals.Signal(Array);
        this._prevPlayerSnapshot = {};
        this._playerSnapshot = {};
        this._playerCount = 0;
        this._isLocalPlayerOnly = false;
    }

    function get isValid()
    {
        return this._isValid;
    }

    function getBounds(mc)
    {
        if (!this._isValid) 
        {
            return {xMin: 0, xMax: 0, yMin: 0, yMax: 0};
        }
        if (com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG) 
        {
            var __reg2 = this._triggerArea.getBounds(mc);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineStyle(1, 65535, 100);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.moveTo(__reg2.xMin, __reg2.yMin);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineTo(__reg2.xMax, __reg2.yMin);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineTo(__reg2.xMax, __reg2.yMax);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineTo(__reg2.xMin, __reg2.yMax);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineTo(__reg2.xMin, __reg2.yMin);
        }
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
        for (var __reg4 in this._playerSnapshot) 
        {
            if (this._playerSnapshot[__reg4] == state) 
            {
                __reg2.push(Number(__reg4));
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
        var __reg6 = [];
        var __reg5 = [];
        var __reg4 = [];
        for (__reg2 in this._playerSnapshot) 
        {
            if ((__reg0 = this._playerSnapshot[__reg2]) === com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.WALKING) 
            {
                ++this._playerCount;
                __reg3.push(__reg2);
            }
            else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING) 
            {
                ++this._playerCount;
                __reg5.push(__reg2);
            }
            else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED) 
            {
                ++this._playerCount;
                __reg6.push(__reg2);
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
        if (__reg5.length >= 0) 
        {
            this.playersStanding.dispatch(__reg5);
        }
        if (__reg6.length > 0) 
        {
            this.playersAdded.dispatch(__reg6);
        }
        if (__reg4.length > 0) 
        {
            this.playersRemoved.dispatch(__reg4);
        }
    }

    function hitTest(player, playerMC)
    {
        if (this._isLocalPlayerOnly && !com.clubpenguin.world.rooms.common.triggers.PlayerAction.isLocalPlayer(player)) 
        {
            return false;
        }
        if (this._requiredAction && !com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(player, this._requiredAction)) 
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
                this._playerSnapshot[player.player_id] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.WALKING;
            }
            else 
            {
                this._playerSnapshot[player.player_id] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED;
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
            if (!com.clubpenguin.world.rooms.common.triggers.ClothingRequirement(this._clothingRequirements[__reg2]).isWornBy(player)) 
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
        this._clothingRequirements.push(new com.clubpenguin.world.rooms.common.triggers.ClothingRequirement(bodyPart, clothingID));
    }

    function requireAction(action)
    {
        this._requiredAction = action;
    }

}
