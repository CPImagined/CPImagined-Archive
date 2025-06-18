//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.IconToolRenderer extends com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer
    {
        var _data, _initialized, loader, highlightLoader, _shell, highlightHolder, placeHolder;
        function IconToolRenderer () {
            super();
            com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance().addEventListener("highlightChange", handleChange, this);
        }
        function setModel(data) {
            _data = String(data);
            if (_initialized) {
                populateUI();
            }
        }
        function handleChange(event) {
            if (event.highlight) {
                setHighlight(event.highlight);
            }
        }
        function configUI() {
            loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            highlightLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            super.configUI();
        }
        function setHighlight(highlightIndex) {
            var _local_2 = _shell.getPath("stampbook_claspHighlightThumb");
            if (highlightHolder.clip) {
                highlightHolder.clip.removeMovieClip();
            }
            highlightHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x:0, _y:0});
            highlightLoader.loadClip((_local_2 + highlightIndex) + ".swf", highlightHolder.clip, "IconToolRenderer.as setHighlight()");
        }
        function populateUI() {
            var _local_2 = _shell.getPath("stampbook_claspThumb");
            if (placeHolder.clip) {
                placeHolder.clip.removeMovieClip();
            }
            placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x:0, _y:0});
            loader.loadClip((_local_2 + _data) + ".swf", placeHolder.clip, "IconToolRenderer.as populateUI()");
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.IconToolRenderer;
        static var LINKAGE_ID = "IconToolRenderer";
    }
