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
            var out = "";
            out = out + "[PartyItem ";
            out = out + (" _id: " + _id);
            out = out + (", _type: " + _type);
            out = out + (", _member: " + _member);
            out = out + (", _cost: " + _cost);
            out = out + (", _biName: " + _biName);
            out = out + "]";
            return(out);
        }
    }
