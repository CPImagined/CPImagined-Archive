//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.Surfboard extends MovieClip
    {
        var surfboard;
        function Surfboard () {
            super();
            init();
        }
        function init() {
            var _local_2 = Math.ceil(Math.random() * NUM_SURFBOARD_COLOURS);
            trace("Surfboard.init():: random surfboard frame " + _local_2);
            surfboard.gotoAndStop(_local_2);
        }
        static var NUM_SURFBOARD_COLOURS = 3;
    }
