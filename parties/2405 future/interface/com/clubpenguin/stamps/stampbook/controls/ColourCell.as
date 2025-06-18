//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.ColourCell extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
    {
        var _data, _initialized, _filePath, _shell, loader, placeHolder;
        function ColourCell () {
            super();
            com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance().addEventListener("colorChange", handleChange, this);
        }
        function setModel(data) {
            _data = String(data);
            if (_initialized) {
                populateUI();
            }
        }
        function handleChange(event) {
            if (!ignoreChanges) {
                setModel(event.colour);
            }
        }
        function configUI() {
            _filePath = _shell.getPath("stampbook_colourThumb");
            loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            super.configUI();
        }
        function populateUI() {
            if (placeHolder.clip) {
                placeHolder.clip.removeMovieClip();
            }
            placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x:0, _y:0});
            loader.loadClip((_filePath + _data) + ".swf", placeHolder.clip, "ColourCell.as populateUI()");
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ColourCell;
        static var LINKAGE_ID = "ColourCell";
        static var RENDERER_WIDTH = 64;
        static var RENDERER_HEIGHT = 46;
        var ignoreChanges = false;
    }
