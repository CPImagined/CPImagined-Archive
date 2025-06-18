//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.Truck extends MovieClip
    {
        var __colorBeanList, truckSym;
        function Truck () {
            super();
            __colorBeanList = new Array(truckSym.colorBean_1, truckSym.colorBean_2, truckSym.colorBean_3, truckSym.colorBean_4, truckSym.colorBean_5, truckSym.colorBean_6);
        }
        function get colorBeanList() {
            return(__colorBeanList);
        }
        function set colorBeanList(param) {
            __colorBeanList = param;
            //return(colorBeanList);
        }
    }
