//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.view.StampProgressView extends MovieClip
    {
        var _shell, _bar, bar_mc, _txLabel, progress_txt, gotoAndStop;
        function StampProgressView () {
            super();
            initReferences();
        }
        function setShell(shell) {
            _shell = shell;
        }
        function initReferences() {
            _bar = bar_mc;
            _txLabel = progress_txt;
        }
        function displayProgress(completedPercent) {
            var _local_3 = _shell.getLocalizedString("percent");
            _local_3 = com.clubpenguin.util.StringUtils.replaceString("%percentage%", String(completedPercent), _local_3);
            _txLabel.text = _local_3;
            this.gotoAndStop(completedPercent + 1);
            var _local_2 = _bar._width + _bar._x;
            var _local_4 = _txLabel.textWidth;
            if ((_bar._width - _local_2) < (_local_4 + PROGRESS_GAGUE_LABEL_PADDING)) {
                _txLabel._x = ((PROGRESS_GAGUE_LABEL_START_X + _local_2) - _local_4) - PROGRESS_GAGUE_LABEL_PADDING;
                _txLabel.textColor = FONT_COLOR_PROGRESS_INSIDE;
            } else {
                _txLabel._x = (_local_2 + PROGRESS_GAGUE_LABEL_START_X) + PROGRESS_GAGUE_LABEL_PADDING;
                _txLabel.textColor = FONT_COLOR_PROGRESS_OUTSIDE;
            }
        }
        static var PROGRESS_GAGUE_LABEL_START_X = -97;
        static var PROGRESS_GAGUE_LABEL_PADDING = 5;
        static var FONT_COLOR_PROGRESS_INSIDE = 3355443;
        static var FONT_COLOR_PROGRESS_OUTSIDE = 16777215;
    }
