//Created by Action Script Viewer - https://www.buraks.com/asv
    class ColorState
    {
        var id, color, colorFrameNumber;
        function ColorState (_id) {
            id = _id;
            color = _id;
            switch (id) {
                case BLUE : 
                    colorFrameNumber = BLUE_FRAME;
                    priority = 0;
                    break;
                case RED : 
                    colorFrameNumber = RED_FRAME;
                    priority = 1;
                    break;
                case GREEN : 
                    colorFrameNumber = GREEN_FRAME;
                    priority = 2;
                    break;
                case YELLOW : 
                    colorFrameNumber = YELLOW_FRAME;
                    priority = 3;
                    break;
            }
        }
        function equals(colourState) {
            return(colourState.id == id);
        }
        static var BLUE_FRAME = 1;
        static var RED_FRAME = 2;
        static var GREEN_FRAME = 3;
        static var YELLOW_FRAME = 4;
        static var BLUE = "blue";
        static var RED = "red";
        static var GREEN = "green";
        static var YELLOW = "yellow";
        var count = 0;
        var priority = 0;
    }
