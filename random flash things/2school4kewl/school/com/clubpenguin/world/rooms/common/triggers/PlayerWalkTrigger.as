class com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger extends com.clubpenguin.world.rooms.common.triggers.PlayerTrigger
{
    var _prevPlayerSnapshot, _playerSnapshot, _playerCount, playersWalking, playersAdded, playersRemoved;
    function PlayerWalkTrigger(triggerArea)
    {
        super(triggerArea);
    } // End of the function
    function endSnapshot()
    {
        for (var _loc5 in _prevPlayerSnapshot)
        {
            if (!_playerSnapshot[_loc5])
            {
                _playerSnapshot[_loc5] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.GONE;
                continue;
                continue;
            } // end if
            if ((_prevPlayerSnapshot[_loc5] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED || _prevPlayerSnapshot[_loc5] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING) && _playerSnapshot[_loc5] == com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED)
            {
                _playerSnapshot[_loc5] = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING;
            } // end if
        } // end of for...in
        var _loc4 = [];
        var _loc2 = [];
        var _loc3 = [];
        for (var _loc5 in _playerSnapshot)
        {
            switch (_playerSnapshot[_loc5])
            {
                case com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.WALKING:
                {
                    ++_playerCount;
                    _loc4.push(_loc5);
                    if (!_prevPlayerSnapshot[_loc5])
                    {
                        _loc2.push(_loc5);
                    } // end if
                    break;
                } 
                case com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.GONE:
                {
                    _loc3.push(_loc5);
                    delete _playerSnapshot[_loc5];
                    break;
                } 
            } // End of switch
        } // end of for...in
        if (_loc4.length >= 0)
        {
            playersWalking.dispatch(_loc4);
        } // end if
        if (_loc2.length > 0)
        {
            playersAdded.dispatch(_loc2);
        } // end if
        if (_loc3.length > 0)
        {
            playersRemoved.dispatch(_loc3);
        } // end if
    } // End of the function
} // End of Class
