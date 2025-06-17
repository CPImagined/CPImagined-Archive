//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.Loader;
    import com.clubpenguin.endscreens.model.StampVO;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import fl.motion.Color;

    public class StampView extends BaseEmbeddedAssetView 
    {

        private static const UNAVAILABLE_HEX:Number = 10066397;
        private static const UNAVAILABLE_MULTIPLIER:Number = 0.7;

        private var _loader:Loader = new Loader();
        private var _stampVO:StampVO;
        private var _description:StampDescriptionView;

        public function StampView()
        {
            super(EndGameViewAssets.StampSkin, MiniGameEndScreensConstants.SKIN_INSTANCE_NAME_STAMP);
        }

        public function updateStamp(stampVO:StampVO):void
        {
            this._stampVO = stampVO;
            if (view == null)
            {
                onCompleted.addOnce(this.changeStateOnceLoaded);
            }
            else
            {
                this.changeStateOnceLoaded();
            };
        }

        public function addDescription(stampDescriptionView:StampDescriptionView):void
        {
            this._description = stampDescriptionView;
            this._description.visible = false;
            if (this._description.loaded)
            {
                this.addDescriptionToView();
            }
            else
            {
                this._description.onCompleted.addOnce(this.addDescriptionToView);
            };
        }

        private function addDescriptionToView():void
        {
            if (view == null)
            {
                onCompleted.addOnce(this.addDescriptionToView);
                return;
            };
            (view as MovieClip).addEventListener(MouseEvent.MOUSE_OVER, this.showDescription);
            (view as MovieClip).addEventListener(MouseEvent.MOUSE_OUT, this.hideDescription);
            (view as MovieClip).addChild(this._description);
        }

        private function showDescription(event:Event):void
        {
            (view as MovieClip).addChild(this._description);
            this._description.visible = true;
        }

        private function hideDescription(event:Event):void
        {
            (view as MovieClip).removeChild(this._description);
            this._description.visible = false;
        }

        private function changeStateOnceLoaded():void
        {
            switch (this._stampVO.state)
            {
                case StampVO.STAMP_STATE_DEFAULT:
                    this.shadeStamp();
                    this.hideStarburst();
                    break;
                case StampVO.STAMP_STATE_OWNED:
                    this.hideStarburst();
                    break;
                case StampVO.STAMP_STATE_JUST_EARNED:
                    break;
            };
            this.loadArt();
        }

        public function loadArt():void
        {
            var request:URLRequest = new URLRequest(((StampVO.STAMP_LOADER_DATA[StampVO.ICON_URL] + this._stampVO.id) + ".swf"));
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onArtLoaded);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onArtError);
            this._loader.load(request);
        }

        private function onArtLoaded(event:Event):void
        {
            this._loader.width = (this._loader.width * 0.5);
            this._loader.height = (this._loader.height * 0.5);
            (view as MovieClip).addChild(this._loader);
        }

        private function onArtError(event:IOErrorEvent):void
        {
        }

        private function shadeStamp():void
        {
            var colorTransform:Color = new Color();
            colorTransform.setTint(UNAVAILABLE_HEX, UNAVAILABLE_MULTIPLIER);
            (view as MovieClip).transform.colorTransform = colorTransform;
        }

        private function hideStarburst():void
        {
            (view[MiniGameEndScreensConstants.STAMP_STARBURST] as MovieClip).visible = false;
        }

        public function destroy():void
        {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onArtLoaded);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onArtError);
            this._loader.unloadAndStop();
            if (this._description)
            {
                (view as MovieClip).removeEventListener(MouseEvent.MOUSE_OVER, this.showDescription);
                (view as MovieClip).removeEventListener(MouseEvent.MOUSE_OUT, this.hideDescription);
            };
            view = null;
            this._stampVO = null;
        }


    }
}//package com.clubpenguin.endscreens.view
