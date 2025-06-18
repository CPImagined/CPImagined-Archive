//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.vo
{
    import flash.display.DisplayObject;

    public class ComplexPromptOverlayVO extends OverlayVO 
    {

        private static const COMPLEX_PROMPT_OVERLAY_ID:String = "complexPromptOverlayID";

        public function ComplexPromptOverlayVO(object:DisplayObject)
        {
            this.object = object;
            this.id = COMPLEX_PROMPT_OVERLAY_ID;
            this.modalBackgroundEnabled = true;
        }

    }
}//package com.clubpenguin.main.overlays.vo
