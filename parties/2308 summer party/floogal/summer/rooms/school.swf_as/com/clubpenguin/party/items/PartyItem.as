dynamic class com.clubpenguin.party.items.PartyItem
{
    var _biName;
    var _cost;
    var _id;
    var _member;
    var _type;

    function PartyItem(id, type, member, cost, biName)
    {
        this._id = id;
        this._type = type;
        this._member = member == undefined ? true : member;
        this._cost = cost;
        this._biName = biName;
    }

    function get id()
    {
        return this._id;
    }

    function get type()
    {
        return this._type;
    }

    function get member()
    {
        return this._member;
    }

    function get cost()
    {
        return this._cost;
    }

    function get biName()
    {
        return this._biName;
    }

    function toString()
    {
        var __reg2 = "";
        __reg2 = __reg2 + "[PartyItem ";
        __reg2 = __reg2 + (" _id: " + this._id);
        __reg2 = __reg2 + (", _type: " + this._type);
        __reg2 = __reg2 + (", _member: " + this._member);
        __reg2 = __reg2 + (", _cost: " + this._cost);
        __reg2 = __reg2 + (", _biName: " + this._biName);
        __reg2 = __reg2 + "]";
        return __reg2;
    }

}
