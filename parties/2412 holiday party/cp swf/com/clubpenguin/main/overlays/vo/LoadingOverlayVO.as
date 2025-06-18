//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.vo
{
    import com.clubpenguin.main.overlays.type.OverlayType;
    import flash.display.DisplayObject;

    public class LoadingOverlayVO extends OverlayVO 
    {

        public static const LOADING_OVERLAY_ID:String = "loadingOverlayID";

        public function LoadingOverlayVO(object:DisplayObject)
        {
            this.object = object;
            this.id = LOADING_OVERLAY_ID;
            this.type = OverlayType.DISPLAY;
            this.modalBackgroundEnabled = false;
        }

    }
}//package com.clubpenguin.main.overlays.vo
