class com.clubpenguin.world.rooms.common.triggers.PlayerTrigger
{
    var _triggerArea, playersAdded, playersRemoved, playersStanding, playersWalking, _prevPlayerSnapshot, _playerSnapshot, _playerCount, _isLocalPlayerOnly, _requiredAction, _clothingRequirements, __get__isValid;
    static var DEBUG_CANVAS2;
    function PlayerTrigger(triggerArea)
    {
        _triggerArea = triggerArea;
        if (_triggerArea == null)
        {
            _isValid = false;
            trace ("A trigger path is incorrect! Check all you trigger instance paths.");
        }
        else
        {
            trace ("Tigger added successfully: " + _triggerArea);
        } // end else if
        playersAdded = new org.osflash.signals.Signal(Array);
        playersRemoved = new org.osflash.signals.Signal(Array);
        playersStanding = new org.osflash.signals.Signal(Array);
        playersWalking = new org.osflash.signals.Signal(Array);
        _prevPlayerSnapshot = {};
        _playerSnapshot = {};
        _playerCount = 0;
        _isLocalPlayerOnly = false;
    } // End of the function
    function get isValid()
    {
        return (_isValid);
    } // End of the function
    function getBounds(mc)
    {
        if (!_isValid)
        {
            return ({xMin: 0, xMax: 0, yMin: 0, yMax: 0});
        } // end if
        if (com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG)
        {
            var _loc2 = _triggerArea.getBounds(mc);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineStyle(1, 65535, 100);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.moveTo(_loc2.xMin, _loc2.yMin);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineTo(_loc2.xMax, _loc2.yMin);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineTo(_loc2.xMax, _loc2.yMax);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineTo(_loc2.xMin, _loc2.yMax);
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2.lineTo(_loc2.xMin, _loc2.yMin);
        } // end if
        if (mc)
        {
            return (_triggerArea.getBounds(mc));
        } // end if
        return (_triggerArea.getBounds());
    } // End of the function
    function beginSnapshot()
    {
        _prevPlayerSnapshot = _playerSnapshot;
        _playerSnapshot = {};
        _playerCount = 0;
    } // End of the function
    function getPlayerCount()
    {
        return (_playerCount);
    } // End of the function
    function getPlayersWhoAre(state)
    {
        var _loc2 = [];
        for (var _loc3 in _playerSnapshot)
        {
            if (_playerSnapshot[_loc3] == state)
            {
                _loc2.push(Number(_loc3));
            } // end if
        } // end of for...in
        return (_loc2);
    } // End of the function
    function getAllPlayers()
    {
        var _loc2 = [];
        for (var _loc3 in _playerSnapshot)
        {
            _loc2.push(Number(_loc3));
        } // end of for...in
        return (_loc2);
    } // End of the function
    function endSnapshot()
    {
        for (var _loc6 in _prevPlayerSnapshot)
        {
            if (!_playerSnapshot[_loc6])
            {
                _playerSnapshot[_loc6] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.GONE;
                continue;
                continue;
            } // end if
            if ((_prevPlayerSnapshot[_loc6] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED || _prevPlayerSnapshot[_loc6] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING) && _playerSnapshot[_loc6] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED)
            {
                _playerSnapshot[_loc6] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING;
            } // end if
        } // end of for...in
        var _loc5 = [];
        var _loc2 = [];
        var _loc3 = [];
        var _loc4 = [];
        for (var _loc6 in _playerSnapshot)
        {
            switch (_playerSnapshot[_loc6])
            {
                case com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.WALKING:
                {
                    ++_playerCount;
                    _loc5.push(_loc6);
                    break;
                } 
                case com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING:
                {
                    ++_playerCount;
                    _loc3.push(_loc6);
                    break;
                } 
                case com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED:
                {
                    ++_playerCount;
                    _loc2.push(_loc6);
                    break;
                } 
                case com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.GONE:
                {
                    _loc4.push(_loc6);
                    delete _playerSnapshot[_loc6];
                    break;
                } 
            } // End of switch
        } // end of for...in
        if (_loc5.length >= 0)
        {
            playersWalking.dispatch(_loc5);
        } // end if
        if (_loc3.length >= 0)
        {
            playersStanding.dispatch(_loc3);
        } // end if
        if (_loc2.length > 0)
        {
            playersAdded.dispatch(_loc2);
        } // end if
        if (_loc4.length > 0)
        {
            playersRemoved.dispatch(_loc4);
        } // end if
    } // End of the function
    function hitTest(player, playerMC)
    {
        if (_isLocalPlayerOnly && !com.clubpenguin.world.rooms.common.triggers.PlayerAction.isLocalPlayer(player))
        {
            return (false);
        } // end if
        if (_requiredAction && !com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(player, _requiredAction))
        {
            return (false);
        } // end if
        if (!this.clothingRequirementMet(player))
        {
            return (false);
        } // end if
        if (_triggerArea.hitTest(playerMC._x, playerMC._y, true))
        {
            if (playerMC.is_moving)
            {
                _playerSnapshot[player.player_id] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.WALKING;
            }
            else
            {
                _playerSnapshot[player.player_id] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED;
            } // end else if
            return (true);
        } // end if
        return (false);
    } // End of the function
    function isLocalPlayerOnly()
    {
        _isLocalPlayerOnly = true;
    } // End of the function
    function clothingRequirementMet(player)
    {
        if (!_clothingRequirements)
        {
            return (true);
        } // end if
        for (var _loc2 = 0; _loc2 < _clothingRequirements.length; ++_loc2)
        {
            if (!(com.clubpenguin.world.rooms.common.triggers.ClothingRequirement)(_clothingRequirements[_loc2]).isWornBy(player))
            {
                return (false);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    function addClothingRequirement(bodyPart, clothingID)
    {
        if (!_clothingRequirements)
        {
            _clothingRequirements = [];
        } // end if
        _clothingRequirements.push(new com.clubpenguin.world.rooms.common.triggers.ClothingRequirement(bodyPart, clothingID));
    } // End of the function
    function requireAction(action)
    {
        _requiredAction = action;
    } // End of the function
    static var WALKING = "walking";
    static var STANDING = "standing";
    static var GONE = "gone";
    static var STOPPED = "stopped";
    var _isValid = true;
    static var DEBUG = false;
} // End of Class
