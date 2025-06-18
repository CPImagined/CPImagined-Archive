//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.FlyingObject extends MovieClip
    {
        var gotoAndStop, bag, objectType;
        function FlyingObject () {
            super();
        }
        function activate(objectType) {
            this.gotoAndStop(2);
            bag.gotoAndPlay(2);
            this.objectType = objectType;
        }
        function onActivated() {
            __activated = true;
        }
        var __activated = false;
    }
