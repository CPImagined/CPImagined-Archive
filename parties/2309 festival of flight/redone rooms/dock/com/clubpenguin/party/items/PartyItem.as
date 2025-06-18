//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.items.PartyItem
    {
        var _id, _type, _member;
        function PartyItem (id, type, member) {
            _id = id;
            _type = type;
            _member = member;
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
        function configureButton(itemMC, member, prompt) {
            return(undefined);
        }
    }
