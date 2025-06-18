//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.DescriptionBox extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
    {
        var _singleLine, __get__singleLine, _data, title_txt, tooltipRightSideClip, descriptionSingleLine_txt, description_txt, tooltipLeftSideClip, tooltipMiddleSideClip;
        function DescriptionBox () {
            super();
            _singleLine = false;
        }
        function set singleLine(flag) {
            _singleLine = flag;
            //return(__get__singleLine());
        }
        function populateUI() {
            var _local_3 = 0;
            var _local_2;
            title_txt.text = _data.getName();
            tooltipRightSideClip.memberBadge._visible = _data.getIsMemberItem();
            if (_singleLine) {
                _local_2 = descriptionSingleLine_txt;
                descriptionSingleLine_txt.text = _data.getDescription();
                descriptionSingleLine_txt._width = descriptionSingleLine_txt.textWidth + SINGLE_LINE_DESCRIPTION_TEXT_PADDING;
                if (descriptionSingleLine_txt._width < (title_txt.textWidth + SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING)) {
                    descriptionSingleLine_txt._width = title_txt.textWidth + SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING;
                }
            } else {
                _local_2 = description_txt;
                description_txt.text = _data.getDescription();
                description_txt._width = title_txt.textWidth + DESCRIPTION_TEXT_WIDTH_PADDING;
                if (description_txt._width < MIN_DESCRIPTION_WIDTH) {
                    description_txt._width = MIN_DESCRIPTION_WIDTH;
                }
            }
            if (tooltipRightSideClip.memberBadge._visible) {
                _local_3 = tooltipRightSideClip.memberBadge._width;
            }
            tooltipRightSideClip._x = ((_local_2._x + _local_2._width) + _local_3) + TOOLTIP_RIGHT_SIDE_CLIP_PADDING;
            tooltipMiddleSideClip._width = (tooltipRightSideClip._x - (tooltipLeftSideClip._x + tooltipLeftSideClip._width)) + 1;
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.DescriptionBox;
        static var LINKAGE_ID = "DescriptionBox";
        static var TOOLTIP_RIGHT_SIDE_CLIP_PADDING = -20;
        static var DESCRIPTION_TEXT_WIDTH_PADDING = 50;
        static var SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING = 12;
        static var MIN_DESCRIPTION_WIDTH = 128;
        static var SINGLE_LINE_DESCRIPTION_TEXT_PADDING = 10;
    }
