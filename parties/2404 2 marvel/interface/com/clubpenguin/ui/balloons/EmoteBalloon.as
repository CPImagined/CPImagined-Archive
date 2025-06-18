//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.balloons.EmoteBalloon extends com.clubpenguin.ui.balloons.AbstractBalloon
    {
        var hide, __get__mc;
        function EmoteBalloon (mc) {
            super(mc);
        }
        function show() {
            this.hide();
            __get__mc().gotoAndStop(UNPARKED_FRAME);
            __get__mc().icon_mc.gotoAndStop(emoteFrame);
        }
        function get emoteFrame() {
            return(_emoteFrame);
        }
        function set emoteFrame(frame) {
            _emoteFrame = frame;
            __get__mc().icon_mc.gotoAndStop(emoteFrame);
            //return(emoteFrame);
        }
        function toString() {
            return((("Emote" + super.toString()) + "emoteFrame: ") + emoteFrame);
        }
        static var UNPARKED_FRAME = "emote";
        var _emoteFrame = 0;
    }
