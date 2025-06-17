//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.model.PhoneState extends com.clubpenguin.util.Enumeration
    {
        var id, layout, isTeleportEnabled, viewID;
        function PhoneState (id, layout, isTeleportEnabled, viewID) {
            super();
            this.id = id || "no  id";
            this.layout = layout || (com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT);
            this.isTeleportEnabled = isTeleportEnabled || true;
            this.viewID = viewID;
            stateLookup[this.id] = this;
        }
        static function getStateByIconID(iconID) {
            return(stateLookup[iconID]);
        }
        static var stateLookup = new Object();
        static var CLOSING = new com.clubpenguin.hud.phone.model.PhoneState("closing", com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED, true);
        static var CLOSED = new com.clubpenguin.hud.phone.model.PhoneState("closed", com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED, true);
        static var APP_MENU = new com.clubpenguin.hud.phone.model.PhoneState("appMenu", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "appMenu");
        static var TELEPORT = new com.clubpenguin.hud.phone.model.PhoneState("teleport", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "teleport");
        static var TELEPORTING = new com.clubpenguin.hud.phone.model.PhoneState("teleporting", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, false);
        static var RECRUIT = new com.clubpenguin.hud.phone.model.PhoneState("recruit", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "recruit");
        static var PUFFLE = new com.clubpenguin.hud.phone.model.PhoneState("puffle", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "puffle");
        static var GADGETS = new com.clubpenguin.hud.phone.model.PhoneState("gadgets", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "gadgets");
        static var MISSION = new com.clubpenguin.hud.phone.model.PhoneState("mission", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "mission");
        static var AGENT_STATUS = new com.clubpenguin.hud.phone.model.PhoneState("agentStatus", com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE_LARGE, true, "agentStatus");
        static var COMMUNICATION = new com.clubpenguin.hud.phone.model.PhoneState("communication", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "communication");
    }
