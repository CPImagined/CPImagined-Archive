//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.vo
{
    import com.clubpenguin.main.overlays.vo.OverlayVO;
    import com.clubpenguin.main.overlays.type.OverlayType;

    public class AssetPromptVO extends OverlayVO 
    {

        public static const ASSETPROMPT_ID:String = "assetPromptID";
        public static const ACTION_CLOSE:String = "close";

        public var textClipStringTokens:Object;
        public var textClipLocalizedStrings:Object;
        public var buttonClipPredefinedActions:Object;
        public var buttonClipFunctions:Object;
        public var joinRoomActions:Object;
        public var startFrames:Object;

        public function AssetPromptVO()
        {
            this.id = ASSETPROMPT_ID;
            this.type = OverlayType.DISPLAY;
            this.modalBackgroundEnabled = false;
            this.isAbsoluteURL = true;
        }

    }
}//package com.clubpenguin.main.vo
