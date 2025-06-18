//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.balloons.TextBalloon extends com.clubpenguin.ui.balloons.AbstractBalloon
    {
        var hide, __get__mc, _counter, setSize, _textFormat, __get__maxWidth;
        function TextBalloon (mc) {
            super(mc);
        }
        function show() {
            this.hide();
            __get__mc().gotoAndStop(UNPARKED_FRAME);
            showText(_multiPartMessage[_multiPartIndex]);
        }
        function isDone() {
            return(!((_multiPartMessage.length > 1) && (_multiPartIndex < (_multiPartMessage.length - 1))));
        }
        function showNextPart() {
            _multiPartIndex++;
            _counter = 0;
            this.show();
        }
        function showText(text) {
            __get__mc().message_txt.text = text;
            __get__mc().message_txt.setTextFormat(textFormat);
            var _local_3 = _maxWidth - TEXT_X_PADDING;
            var _local_4 = __get__mc().message_txt.textHeight;
            __get__mc().message_txt._width = _local_3;
            __get__mc().message_txt._height = (_local_4 + (TEXT_Y_PADDING * 0.5)) + 20;
            setSize(_local_3 + TEXT_X_PADDING, __get__mc().message_txt.textHeight + TEXT_Y_PADDING);
            __get__mc().message_txt._x = (__get__mc().balloon_mc._x - (__get__mc().balloon_mc._width * 0.5)) + (TEXT_X_PADDING * 0.5);
            __get__mc().message_txt._y = __get__mc().balloon_mc._y;
            __get__mc().message_txt._y = __get__mc().message_txt._y + (TEXT_Y_PADDING / 2);
            if (_global.getCurrentEngine().getRoomMovieClip().invertedPenguins) {
                __get__mc().message_txt._yscale = -100;
                __get__mc().message_txt._y = __get__mc().message_txt._y + (__get__mc().balloon_mc._height - 12);
            }
        }
        function get message() {
            return(_message);
        }
        function set message(message) {
            _message = message;
            _multiPartMessage = message.split(TEXT_DELIMITER);
            _multiPartIndex = 0;
            _counter = 0;
            //return(this.message);
        }
        function get textFormat() {
            return(_textFormat);
        }
        function set textFormat(textFormat) {
            _textFormat = textFormat;
            //return(this.textFormat);
        }
        function set maxWidth(maxWidth) {
            _maxWidth = maxWidth;
            //return(__get__maxWidth());
        }
        function toString() {
            return((("Text" + super.toString()) + "message: ") + message);
        }
        static var UNPARKED_FRAME = "text";
        static var TEXT_Y_PADDING = 8;
        static var TEXT_X_PADDING = 14;
        static var TEXT_DELIMITER = "|";
        var _message = "";
        var _multiPartMessage = [""];
        var _multiPartIndex = 0;
        var _maxWidth = 100;
    }
