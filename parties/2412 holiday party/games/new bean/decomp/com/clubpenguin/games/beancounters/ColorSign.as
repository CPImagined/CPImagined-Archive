//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.ColorSign extends MovieClip
    {
        var __colorSignMcList, colorSection1, colorSection2, colorSection3, colorSection4, colorSection5, colorSection6, colorSection7, colorSection8, colorSection9, colorSection10, colorSection11, colorSection12;
        function ColorSign () {
            super();
            __colorSignMcList = new Array(colorSection1, colorSection2, colorSection3, colorSection4, colorSection5, colorSection6, colorSection7, colorSection8, colorSection9, colorSection10, colorSection11, colorSection12);
        }
        function get colorList() {
            return(__colorList);
        }
        function get complementaryColorList() {
            return(__complementaryColorList);
        }
        function get analogousColorList() {
            return(__analogousColorList);
        }
        function get warmColorList() {
            return(__warmColorList);
        }
        function get coolColorList() {
            return(__coolColorList);
        }
        function get primaryColorList() {
            return(__primaryColorList);
        }
        function get secondaryColorList() {
            return(__secondaryColorList);
        }
        function get tertiaryColorList() {
            return(__tertiaryColorList);
        }
        function get colorSignMcList() {
            return(__colorSignMcList);
        }
        function set colorSignMcList(param) {
            __colorSignMcList = param;
            //return(colorSignMcList);
        }
        var __colorList = new Array(com.clubpenguin.games.beancounters.ColorConstants.RED_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.VIOLET, com.clubpenguin.games.beancounters.ColorConstants.BLUE_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.BLUE, com.clubpenguin.games.beancounters.ColorConstants.BLUE_GREEN, com.clubpenguin.games.beancounters.ColorConstants.GREEN, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_GREEN, com.clubpenguin.games.beancounters.ColorConstants.YELLOW, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_ORANGE, com.clubpenguin.games.beancounters.ColorConstants.ORANGE, com.clubpenguin.games.beancounters.ColorConstants.RED_ORANGE, com.clubpenguin.games.beancounters.ColorConstants.RED);
        static var __complementaryColorList1 = new Array(com.clubpenguin.games.beancounters.ColorConstants.RED, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_GREEN);
        static var __complementaryColorList2 = new Array(com.clubpenguin.games.beancounters.ColorConstants.RED_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_GREEN);
        static var __complementaryColorList3 = new Array(com.clubpenguin.games.beancounters.ColorConstants.YELLOW, com.clubpenguin.games.beancounters.ColorConstants.VIOLET);
        static var __complementaryColorList4 = new Array(com.clubpenguin.games.beancounters.ColorConstants.BLUE_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_ORANGE);
        static var __complementaryColorList5 = new Array(com.clubpenguin.games.beancounters.ColorConstants.BLUE, com.clubpenguin.games.beancounters.ColorConstants.ORANGE);
        static var __complementaryColorList6 = new Array(com.clubpenguin.games.beancounters.ColorConstants.RED_ORANGE, com.clubpenguin.games.beancounters.ColorConstants.BLUE_GREEN);
        static var __complementaryColorList = new Array(__complementaryColorList1, __complementaryColorList2, __complementaryColorList3, __complementaryColorList4, __complementaryColorList5, __complementaryColorList6);
        static var __analogousColorList1 = new Array(com.clubpenguin.games.beancounters.ColorConstants.RED_ORANGE, com.clubpenguin.games.beancounters.ColorConstants.RED, com.clubpenguin.games.beancounters.ColorConstants.RED_VIOLET);
        static var __analogousColorList2 = new Array(com.clubpenguin.games.beancounters.ColorConstants.BLUE_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.BLUE, com.clubpenguin.games.beancounters.ColorConstants.BLUE_GREEN);
        static var __analogousColorList3 = new Array(com.clubpenguin.games.beancounters.ColorConstants.YELLOW_GREEN, com.clubpenguin.games.beancounters.ColorConstants.YELLOW, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_ORANGE);
        static var __analogousColorList4 = new Array(com.clubpenguin.games.beancounters.ColorConstants.YELLOW_ORANGE, com.clubpenguin.games.beancounters.ColorConstants.ORANGE, com.clubpenguin.games.beancounters.ColorConstants.RED_ORANGE);
        static var __analogousColorList5 = new Array(com.clubpenguin.games.beancounters.ColorConstants.RED_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.VIOLET, com.clubpenguin.games.beancounters.ColorConstants.BLUE_VIOLET);
        static var __analogousColorList6 = new Array(com.clubpenguin.games.beancounters.ColorConstants.BLUE_GREEN, com.clubpenguin.games.beancounters.ColorConstants.GREEN, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_GREEN);
        static var __analogousColorList = new Array(__analogousColorList1, __analogousColorList2, __analogousColorList3, __analogousColorList4, __analogousColorList5, __analogousColorList6);
        static var __warmColorList = new Array(com.clubpenguin.games.beancounters.ColorConstants.YELLOW, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_ORANGE, com.clubpenguin.games.beancounters.ColorConstants.ORANGE, com.clubpenguin.games.beancounters.ColorConstants.RED_ORANGE, com.clubpenguin.games.beancounters.ColorConstants.RED, com.clubpenguin.games.beancounters.ColorConstants.RED_VIOLET);
        static var __coolColorList = new Array(com.clubpenguin.games.beancounters.ColorConstants.VIOLET, com.clubpenguin.games.beancounters.ColorConstants.BLUE_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.BLUE, com.clubpenguin.games.beancounters.ColorConstants.BLUE_GREEN, com.clubpenguin.games.beancounters.ColorConstants.GREEN, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_GREEN);
        static var __primaryColorList = new Array(com.clubpenguin.games.beancounters.ColorConstants.RED, com.clubpenguin.games.beancounters.ColorConstants.BLUE, com.clubpenguin.games.beancounters.ColorConstants.YELLOW);
        static var __secondaryColorList = new Array(com.clubpenguin.games.beancounters.ColorConstants.GREEN, com.clubpenguin.games.beancounters.ColorConstants.VIOLET, com.clubpenguin.games.beancounters.ColorConstants.ORANGE);
        static var __tertiaryColorList = new Array(com.clubpenguin.games.beancounters.ColorConstants.RED_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.RED_ORANGE, com.clubpenguin.games.beancounters.ColorConstants.BLUE_GREEN, com.clubpenguin.games.beancounters.ColorConstants.BLUE_VIOLET, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_GREEN, com.clubpenguin.games.beancounters.ColorConstants.YELLOW_ORANGE);
    }
