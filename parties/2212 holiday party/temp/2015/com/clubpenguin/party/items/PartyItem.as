class com.clubpenguin.party.items.PartyItem
{
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
      var _loc2_ = "";
      _loc2_ += "[PartyItem ";
      _loc2_ += " _id: " + this._id;
      _loc2_ += ", _type: " + this._type;
      _loc2_ += ", _member: " + this._member;
      _loc2_ += ", _cost: " + this._cost;
      _loc2_ += ", _biName: " + this._biName;
      _loc2_ += "]";
      return _loc2_;
   }
}
