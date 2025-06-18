//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.events.MembershipEvent
    {
        var type, context, action;
        function MembershipEvent (type, context, action) {
            this.type = type;
            this.context = context;
            this.action = action;
        }
        function clone() {
            return(new com.clubpenguin.shell.events.MembershipEvent(type, context, action));
        }
        function toString() {
            return(((((("[ " + type) + " | ") + context) + " | ") + action) + " ]");
        }
        static var MEMBER_ONLY_ACTIVITY = "memberOnlyActivity";
    }
