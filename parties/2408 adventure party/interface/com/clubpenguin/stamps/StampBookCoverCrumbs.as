//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampBookCoverCrumbs
    {
        var _coverCrumbs;
        function StampBookCoverCrumbs (webServiceManager) {
            _coverCrumbs = webServiceManager.getCachedServiceData(com.clubpenguin.net.WebServiceType.STAMPBOOK_COVER);
            setColourCrumb();
            var _local_3 = pattern;
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                if (_local_3[_local_2] == com.clubpenguin.stamps.StampManager.COVER_PATTERN_NONE_ID) {
                    _local_3.splice(_local_2, 1);
                    break;
                }
                _local_2++;
            }
        }
        function get pattern() {
            return(_coverCrumbs[CRUMB_CATEGORY_PATTERN]);
        }
        function get clasp() {
            return(_coverCrumbs[CRUMB_CATEGORY_CLASP]);
        }
        function get colour() {
            return(_coverCrumbs[CRUMB_CATEGORY_COLOUR]);
        }
        function getTextHighlightByHighlightID(highlightID) {
            return(Number(_coverCrumbs[CRUMB_CATEGORY_HIGHLIGHT][String(highlightID)]));
        }
        function getHighlightByColourID(colourID) {
            return(_coverCrumbs[CRUMB_CATEGORY_COLOUR_HIGHLIGHT][String(colourID)]);
        }
        function getLogoByColourID(colourID) {
            return(Number(_coverCrumbs[CRUMB_CATEGORY_COLOUR_LOGO][String(colourID)][0]));
        }
        function setColourCrumb() {
            _coverCrumbs[CRUMB_CATEGORY_COLOUR] = [];
            var _local_4 = _coverCrumbs[CRUMB_CATEGORY_COLOUR_HIGHLIGHT];
            var _local_2 = _coverCrumbs[CRUMB_CATEGORY_COLOUR];
            var _local_3 = 0;
            for (var _local_5 in _local_4) {
                _local_2[_local_3++] = _local_5;
            }
        }
        static var CRUMB_CATEGORY_PATTERN = "pattern";
        static var CRUMB_CATEGORY_CLASP = "clasp";
        static var CRUMB_CATEGORY_COLOUR = "color";
        static var CRUMB_CATEGORY_HIGHLIGHT = "highlight";
        static var CRUMB_CATEGORY_COLOUR_HIGHLIGHT = "color_highlight";
        static var CRUMB_CATEGORY_COLOUR_LOGO = "color_logo";
    }
