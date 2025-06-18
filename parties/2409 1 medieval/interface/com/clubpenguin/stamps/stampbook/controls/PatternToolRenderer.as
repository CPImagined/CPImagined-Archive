//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.PatternToolRenderer extends com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer
    {
        var loader, _data, load_mc, _initialized, _shell, placeHolder;
        function PatternToolRenderer () {
            super();
        }
        function configUI() {
            loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            super.configUI();
        }
        function setModel(data) {
            _data = Number(data);
            if (((_data == INVALID_STAMP_ID) || (_data == undefined)) || (isNaN(_data))) {
                if (load_mc) {
                    load_mc._visible = false;
                }
                return(undefined);
            }
            if (_initialized) {
                populateUI();
                load_mc._visible = true;
            }
        }
        function populateUI() {
            if (((_data == INVALID_STAMP_ID) || (_data == undefined)) || (isNaN(_data))) {
                return(undefined);
            }
            var _local_2 = _shell.getPath("stampbook_patternThumb");
            if (placeHolder.clip) {
                placeHolder.clip.removeMovieClip();
            }
            load_mc = placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x:0, _y:0});
            loader.loadClip((_local_2 + _data) + ".swf", load_mc, "PatternToolRenderer.as populateUI()");
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.PatternToolRenderer;
        static var LINKAGE_ID = "PatternToolRenderer";
        static var RENDERER_WIDTH = 64;
        static var RENDERER_HEIGHT = 46;
        static var INVALID_STAMP_ID = -1;
    }
