//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.ToolBarStampRenderer extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
    {
        var dispatchEvent, _filePath, _shell, stampIconLoader, _data, specificCategoryBG, allStampsLabel, specificCategoryLabel, specificCategoryLabelShadow, _iconHolderClip, stampIconHolder;
        function ToolBarStampRenderer () {
            super();
        }
        function onPress() {
            dispatchEvent({type:"press"});
        }
        function configUI() {
            _filePath = _shell.getPath("stampbook_categoryHeader");
            stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            super.configUI();
        }
        function populateUI() {
            var _local_2 = (_data.getID() ? (_data.getID()) : (com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID));
            var _local_3 = com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID;
            specificCategoryBG._visible = ((_local_2 == _local_3) ? false : true);
            allStampsLabel.text = ((_local_2 == _local_3) ? (_shell.getLocalizedString("all_stamps_category_title")) : "");
            allStampsLabel._visible = ((_local_2 == _local_3) ? true : false);
            specificCategoryLabel.text = ((_local_2 == _local_3) ? "" : (_data.getName()));
            specificCategoryLabel._visible = ((_local_2 == _local_3) ? false : true);
            specificCategoryLabelShadow.text = ((_local_2 == _local_3) ? "" : (_data.getName()));
            specificCategoryLabelShadow._visible = ((_local_2 == _local_3) ? false : true);
            if (_iconHolderClip) {
                _iconHolderClip.removeMovieClip();
            }
            _iconHolderClip = stampIconHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID, "iconHolderClip", 1, {_x:0, _y:0});
            stampIconLoader.loadClip((_filePath + _local_2) + ".swf", _iconHolderClip, "ToolBarStampRenderer.as populateUI()");
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ToolBarStampRenderer;
        static var LINKAGE_ID = "ToolBarStampRenderer";
    }
