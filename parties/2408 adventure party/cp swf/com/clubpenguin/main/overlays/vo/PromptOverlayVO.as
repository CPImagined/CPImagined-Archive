//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.vo
{
    import com.clubpenguin.main.vo.PromptVO;
    import flash.display.DisplayObject;

    public class PromptOverlayVO extends OverlayVO 
    {

        public static const PROMPT_OVERLAY_ID:String = "promptOverlayID";

        private var _promptVO:PromptVO;

        public function PromptOverlayVO(object:DisplayObject, promptVO:PromptVO)
        {
            this.object = object;
            this.id = PROMPT_OVERLAY_ID;
            this.modalBackgroundEnabled = false;
            this._promptVO = promptVO;
        }

        public function get promptVO():PromptVO
        {
            return (this._promptVO);
        }


    }
}//package com.clubpenguin.main.overlays.vo
