//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.items.PartyItem
    {
        var _id, _type, _member, _cost, _biName;
        function PartyItem (_arg_3, _arg_6, _arg_2, _arg_4, _arg_5) {
            _id = _arg_3;
            _type = _arg_6;
            _member = ((_arg_2 != undefined) ? (_arg_2) : true);
            _cost = _arg_4;
            _biName = _arg_5;
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
