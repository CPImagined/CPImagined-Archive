//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.view
{
    import flash.display.Sprite;
    import com.clubpenguin.main.overlays.vo.OverlayVO;
    import flash.display.SimpleButton;
    import org.osflash.signals.Signal;
    import flash.display.Loader;
    import flash.display.DisplayObject;
    import com.clubpenguin.lib.module.BaseModule;

    public class OverlayView extends Sprite 
    {

        private static const MODAL_COLOR:Number = 0;
        private static const MODAL_ALPHA:Number = 0.5;

        public var vo:OverlayVO;
        public var closeButton:SimpleButton;
        public var closeClickedSignal:Signal = new Signal();
        public var loader:Loader;
        private var _modalBackground:Sprite;
        private var _overlayObject:DisplayObject;

        public function OverlayView(overlayObject:DisplayObject, hasModal:Boolean=true)
        {
            if (hasModal)
            {
                this.drawModal();
                addChild(this._modalBackground);
            };
            this._overlayObject = overlayObject;
            addChild(overlayObject);
        }

        public function close():void
        {
            removeChild(this._overlayObject);
            if ((this._overlayObject is BaseModule))
            {
                BaseModule(this._overlayObject).destroy();
            };
            this._overlayObject = null;
        }

        public function drawModal():void
        {
            if (!this._modalBackground)
            {
                this._modalBackground = new Sprite();
            };
            this._modalBackground.graphics.beginFill(MODAL_COLOR, MODAL_ALPHA);
            this._modalBackground.graphics.drawRect(0, 0, 760, 480);
            this._modalBackground.graphics.endFill();
        }

        public function isBaseModule():Boolean
        {
            return (this._overlayObject is BaseModule);
        }

        override public function toString():String
        {
            return ("[OverlayView]  object = " + this._overlayObject.toString());
        }


    }
}//package com.clubpenguin.main.overlays.view
