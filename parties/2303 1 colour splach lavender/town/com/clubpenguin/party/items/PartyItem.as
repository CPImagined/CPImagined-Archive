class com.clubpenguin.party.items.PartyItem
{
    var _id, _type, _member, _cost, _biName, __get__biName, __get__cost, __get__id, __get__member, __get__type;
    function PartyItem(id, type, member, cost, biName)
    {
        _id = id;
        _type = type;
        _member = member != undefined ? (member) : (true);
        _cost = cost;
        _biName = biName;
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function get type()
    {
        return (_type);
    } // End of the function
    function get member()
    {
        return (_member);
    } // End of the function
    function get cost()
    {
        return (_cost);
    } // End of the function
    function get biName()
    {
        return (_biName);
    } // End of the function
    function toString()
    {
        var _loc2 = "";
        _loc2 = _loc2 + "[PartyItem ";
        _loc2 = _loc2 + (" _id: " + _id);
        _loc2 = _loc2 + (", _type: " + _type);
        _loc2 = _loc2 + (", _member: " + _member);
        _loc2 = _loc2 + (", _cost: " + _cost);
        _loc2 = _loc2 + (", _biName: " + _biName);
        _loc2 = _loc2 + "]";
        return (_loc2);
    } // End of the function
} // End of Class
