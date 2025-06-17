//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.HighlightToolRenderer extends com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer
    {
        var loader, _data, _initialized, _shell, placeHolder;
        function HighlightToolRenderer () {
            super();
        }
        function configUI() {
            loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            super.configUI();
        }
        function setModel(data) {
            _data = String(data);
            if (_initialized) {
                populateUI();
            }
        }
        function populateUI() {
            var _local_2 = _shell.getPath("stampbook_highlightThumb");
            if (placeHolder.clip) {
                placeHolder.clip.removeMovieClip();
            }
            placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x:0, _y:0});
            loader.loadClip((_local_2 + _data) + ".swf", placeHolder.clip, "HighlightToolRenderer.as populateUI()");
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.HighlightToolRenderer;
        static var LINKAGE_ID = "HighlightToolRenderer";
    }
