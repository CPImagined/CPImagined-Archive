//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.PetTube extends MovieClip
    {
        var __init, onEnterFrame, __maxPuffleFrame, _totalframes, __randomPuffleFrame, gotoAndStop, __reset, anim;
        function PetTube () {
            super();
            __init = false;
            onEnterFrame = checkInit;
        }
        function checkInit(Void) {
            if (!__init) {
                __init = true;
                __maxPuffleFrame = _totalframes;
                __randomPuffleFrame = Math.ceil(Math.random() * __maxPuffleFrame);
                this.gotoAndStop(__randomPuffleFrame);
                __reset = true;
                onEnterFrame = update;
            }
        }
        function update(Void) {
            if (__reset) {
                __reset = false;
                resetPuffle();
            }
            if ((!__reset) && (anim._currentframe >= anim._totalframes)) {
                __reset = true;
            }
        }
        function resetPuffle(Void) {
            anim.gotoAndStop(1);
            __randomPuffleFrame = __randomPuffleFrame + Math.ceil(Math.random() * (__maxPuffleFrame - 1));
            if (__randomPuffleFrame > __maxPuffleFrame) {
                __randomPuffleFrame = __randomPuffleFrame - __maxPuffleFrame;
            }
            this.gotoAndStop(__randomPuffleFrame);
            anim.gotoAndPlay(1);
        }
    }
