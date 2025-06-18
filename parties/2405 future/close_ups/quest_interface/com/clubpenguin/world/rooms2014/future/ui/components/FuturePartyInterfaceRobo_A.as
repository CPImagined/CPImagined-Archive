//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.ui.components.FuturePartyInterfaceRobo_A extends MovieClip
    {
        var gotoAndStop;
        function FuturePartyInterfaceRobo_A () {
            super();
            var _local_4 = _global.getCurrentParty().FutureParty.partyCookie.getRoboPaint(0);
            this.gotoAndStop(_local_4 + 1);
        }
    }
