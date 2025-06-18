//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.ui.components.FuturePartyInterfaceRobo_B extends MovieClip
    {
        var gotoAndStop;
        function FuturePartyInterfaceRobo_B () {
            super();
            var _local_4 = _global.getCurrentParty().FutureParty.partyCookie.getRoboPaint(1);
            this.gotoAndStop(_local_4 + 1);
        }
    }
