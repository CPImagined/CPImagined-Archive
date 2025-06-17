//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;
    import flash.display.DisplayObject;
    import flash.text.TextField;

    public class ErrorDialogView extends BaseEmbeddedAssetView 
    {

        public const ERROR_DIALOG_VIEW:String = "errorDialogView";

        private var viewMC:MovieClip;

        public function ErrorDialogView(AssetClass:Class)
        {
            super(AssetClass, this.ERROR_DIALOG_VIEW);
        }

        override public function gotoAndStop(frame:Object, scene:String=null):void
        {
            MovieClip(view).gotoAndStop(frame, scene);
        }

        public function getView():DisplayObjectContainer
        {
            return (view);
        }

        public function get messageField():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("messageField")).localTextField);
        }

        public function get buttonField():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("buttonField")).localTextField);
        }

        public function get windowClip():MovieClip
        {
            return (view.getChildByName("windowClip") as MovieClip);
        }

        public function get button():DisplayObject
        {
            return (view.getChildByName("button") as DisplayObject);
        }

        public function get errorCodeField():TextField
        {
            return (view.getChildByName("errorCodeField") as TextField);
        }


    }
}//package com.clubpenguin.main.view
