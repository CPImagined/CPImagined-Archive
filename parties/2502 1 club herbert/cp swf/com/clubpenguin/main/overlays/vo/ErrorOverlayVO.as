//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.vo
{
    import com.clubpenguin.lib.vo.ErrorVO;
    import flash.display.DisplayObject;

    public class ErrorOverlayVO extends OverlayVO 
    {

        public static const ERROR_OVERLAY_ID:String = "errorOverlayID";

        private var _errorVO:ErrorVO;

        public function ErrorOverlayVO(object:DisplayObject, errorVO:ErrorVO)
        {
            this.object = object;
            this.id = ERROR_OVERLAY_ID;
            this.modalBackgroundEnabled = true;
            this._errorVO = errorVO;
        }

        public function get errorVO():ErrorVO
        {
            return (this._errorVO);
        }


    }
}//package com.clubpenguin.main.overlays.vo
