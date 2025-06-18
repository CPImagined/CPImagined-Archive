//Created by Action Script Viewer - https://www.buraks.com/asv
    class LightState
    {
        var light1, light2, x;
        function LightState (_isOn, _light1, _light2) {
            isOn = _isOn;
            light1 = _light1;
            light2 = _light2;
            x = _light1._x;
        }
        function setLightIsOn(_isOn) {
            if (isOn == _isOn) {
                return(undefined);
            }
            if (_isOn) {
                light1.gotoAndPlay("on");
                light2.gotoAndPlay("on");
                isOn = true;
            } else {
                light1.gotoAndPlay("off");
                light2.gotoAndPlay("off");
                isOn = false;
            }
            isOn = _isOn;
        }
        var isOn = false;
        var priority = 0;
    }
