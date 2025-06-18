﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampBookItemType extends com.clubpenguin.util.Enumeration
    {
        var type;
        function StampBookItemType (type) {
            super();
            this.type = type;
        }
        function toString() {
            return(("[StampBookItemType type=\"" + type) + "\"]");
        }
        static var STAMP = new com.clubpenguin.stamps.StampBookItemType("stamp");
        static var PIN = new com.clubpenguin.stamps.StampBookItemType("pin");
        static var AWARD = new com.clubpenguin.stamps.StampBookItemType("award");
        static var POLAROID = new com.clubpenguin.stamps.StampBookItemType("polaroid");
    }
