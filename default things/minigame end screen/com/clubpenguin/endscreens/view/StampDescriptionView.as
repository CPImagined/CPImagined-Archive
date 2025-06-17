//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import com.clubpenguin.endscreens.model.StampVO;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;

    public class StampDescriptionView extends BaseEmbeddedAssetView 
    {

        private static var TOOLTIP_RIGHT_SIDE_CLIP_PADDING:Number = -20;
        private static var DESCRIPTION_TEXT_WIDTH_PADDING:Number = 50;
        private static var SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING:Number = 12;
        private static var MIN_DESCRIPTION_WIDTH:Number = 128;
        private static var SINGLE_LINE_DESCRIPTION_TEXT_PADDING:Number = 10;

        private var _stampVO:StampVO;
        private var _localizer:ILocalizationManager;

        public function StampDescriptionView()
        {
            super(EndGameViewAssets.StampDescriptionSkin, MiniGameEndScreensConstants.SKIN_INSTANCE_NAME_DESCRIPTION);
        }

        public function updateDescription(stampVO:StampVO):void
        {
            this._stampVO = stampVO;
            if (view == null)
            {
                onCompleted.addOnce(this.populateUI);
            }
            else
            {
                this.populateUI();
            };
        }

        private function populateUI():void
        {
            LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.STAMP_DESCRIPTION_TITLE_TEXT]).localTextField, this._stampVO.title);
            LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.STAMP_DESCRIPTION_BODY_TEXT]).localTextField, this._stampVO.description);
            view["tooltipRightSideClip"].memberBadge.visible = this._stampVO.member;
        }


    }
}//package com.clubpenguin.endscreens.view
