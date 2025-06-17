class com.clubpenguin.shell.events.MembershipEvent
{
    var type, context, action;
    function MembershipEvent(type, context, action)
    {
        this.type = type;
        this.context = context;
        this.action = action;
    } // End of the function
    function clone()
    {
        return (new com.clubpenguin.shell.events.MembershipEvent(type, context, action));
    } // End of the function
    function toString()
    {
        return ("[ " + type + " | " + context + " | " + action + " ]");
    } // End of the function
    static var MEMBER_ONLY_ACTIVITY = "memberOnlyActivity";
} // End of Class
