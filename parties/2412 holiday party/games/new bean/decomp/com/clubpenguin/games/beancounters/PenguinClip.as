//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.PenguinClip extends MovieClip
    {
        var __bagColorList, __bagLauncher, bodyShield, __bagList, _currentframe, color_1a, color_2a, color_3a, color_4a, penguinLimit, color_5a;
        function PenguinClip () {
            super();
        }
        function get bagColorList() {
            return(__bagColorList);
        }
        function init(bagLauncher) {
            __bagLauncher = bagLauncher;
            __bagColorList = new Array();
            bodyShield._visible = false;
        }
        function reset() {
            __bagColorList.splice(0, __bagColorList.length);
        }
        function updateBagColorOnPush(color) {
            __bagList = null;
            switch (_currentframe) {
                case 2 : 
                    __bagList = new Array();
                    __bagList.push(color_1a);
                    break;
                case 3 : 
                    __bagList = new Array();
                    __bagList.push(color_1a);
                    __bagList.push(color_2a);
                    break;
                case 4 : 
                    __bagList = new Array();
                    __bagList.push(color_1a);
                    __bagList.push(color_2a);
                    __bagList.push(color_3a);
                    break;
                case 5 : 
                    __bagList = new Array();
                    __bagList.push(color_1a);
                    __bagList.push(color_2a);
                    __bagList.push(color_3a);
                    __bagList.push(color_4a);
                    break;
                case 6 : 
                    __bagList = new Array();
                    __bagList.push(penguinLimit.color_1a);
                    __bagList.push(penguinLimit.color_2a);
                    __bagList.push(penguinLimit.color_3a);
                    __bagList.push(penguinLimit.color_4a);
                    __bagList.push(penguinLimit.color_5a);
                    break;
                case 7 : 
                    __bagList = new Array();
                    __bagList.push(color_1a);
                    __bagList.push(color_2a);
                    __bagList.push(color_3a);
                    __bagList.push(color_4a);
                    __bagList.push(color_5a);
                    break;
            }
            __bagColorList.push(color);
            var _local_3 = new Color(__bagList[__bagList.length - 1]);
            _local_3.setRGB(color);
            _local_3 = null;
            var _local_2 = 0;
            while (_local_2 < (__bagList.length - 1)) {
                _local_3 = new Color(__bagList[_local_2]);
                _local_3.setRGB(__bagColorList[_local_2]);
                _local_3 = null;
                _local_2++;
            }
        }
        function glowPenguinShield() {
            bodyShield.filters = [com.clubpenguin.games.beancounters.BeanFilters.getInstance.filter_glow];
            bodyShield._visible = true;
        }
        function clearPenguinShield() {
            bodyShield.filters = [];
            bodyShield._visible = false;
        }
        function updateBagColorOnPop() {
            var _local_5;
            __bagList.pop();
            _local_5 = Number(__bagColorList.pop());
            var _local_2 = 0;
            while (_local_2 < __bagList.length) {
                var _local_4 = Number(__bagColorList[_local_2]);
                if (_currentframe == 5) {
                    __bagList[0] = color_1a;
                    __bagList[1] = color_2a;
                    __bagList[2] = color_3a;
                    __bagList[3] = color_4a;
                }
                var _local_3 = new Color(__bagList[_local_2]);
                _local_3.setRGB(_local_4);
                _local_3 = null;
                _local_2++;
            }
            return(_local_5);
        }
        function setBagColor() {
            var _local_2;
            _local_2 = new Color(penguinLimit.color_1a);
            _local_2.setRGB(__bagColorList[0]);
            _local_2 = null;
            _local_2 = new Color(penguinLimit.color_2a);
            _local_2.setRGB(__bagColorList[1]);
            _local_2 = null;
            _local_2 = new Color(penguinLimit.color_3a);
            _local_2.setRGB(__bagColorList[2]);
            _local_2 = null;
            _local_2 = new Color(penguinLimit.color_4a);
            _local_2.setRGB(__bagColorList[3]);
            _local_2 = null;
            _local_2 = new Color(penguinLimit.color_5a);
            _local_2.setRGB(__bagColorList[4]);
            _local_2 = null;
        }
        function onFrame() {
            switch (_currentframe) {
                case 1 : 
                    reset();
                    break;
                case 8 : 
                    __bagLauncher.anvilOut = false;
                    reset();
                case 9 : 
                    __bagLauncher.fishOut = false;
                    reset();
                case 10 : 
                    __bagLauncher.flowerOut = false;
                    reset();
            }
        }
    }
