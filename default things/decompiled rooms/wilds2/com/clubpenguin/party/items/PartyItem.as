//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.items.PartyItem
    {
        var _id, _type, _member, _cost, _biName;
        function PartyItem (id, type, member, cost, biName) {
            _id = id;
            _type = type;
            _member = ((member != undefined) ? (member) : true);
            _cost = cost;
            _biName = biName;
        }
        function get id() {
            return(_id);
        }
        function get type() {
            return(_type);
        }
        function get member() {
            return(_member);
        }
        function get cost() {
            return(_cost);
        }
        function get biName() {
            return(_biName);
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + "[PartyItem ";
            _local_2 = _local_2 + (" _id: " + _id);
            _local_2 = _local_2 + (", _type: " + _type);
            _local_2 = _local_2 + (", _member: " + _member);
            _local_2 = _local_2 + (", _cost: " + _cost);
            _local_2 = _local_2 + (", _biName: " + _biName);
            _local_2 = _local_2 + "]";
            return(_local_2);
        }
    }
