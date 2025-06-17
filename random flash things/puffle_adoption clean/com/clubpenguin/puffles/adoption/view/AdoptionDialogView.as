//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class AdoptionDialogView extends BaseEmbeddedAssetView 
    {

        public const ADOPTION_DIALOG_VIEW:String = "adoptionDialog";

        public var puffleAnimClips:Array;

        public function AdoptionDialogView(AssetClass:Class)
        {
            super(AssetClass, this.ADOPTION_DIALOG_VIEW);
            this.puffleAnimClips = new Array();
        }

        public function getView():DisplayObjectContainer
        {
            return (view);
        }

        override public function gotoAndStop(frame:Object, scene:String=null):void
        {
            MovieClip(view).gotoAndStop(frame, scene);
        }

        public function get closeButton():MovieClip
        {
            var btn:MovieClip = (view.getChildByName("closeButton") as MovieClip);
            btn.buttonMode = true;
            return (btn);
        }

        public function get inputText():TextField
        {
            var it:TextField = (view.getChildByName("inputText") as TextField);
            return (it);
        }

        public function get inputBackground():MovieClip
        {
            return (view.getChildByName("inputBackground") as MovieClip);
        }

        public function get dividerLine():MovieClip
        {
            return (view.getChildByName("dividerLine") as MovieClip);
        }

        public function get puffleHolder():MovieClip
        {
            return (view.getChildByName("puffleHolder") as MovieClip);
        }

        public function get price():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("price")).localTextField);
        }

        public function get subText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("subText")).localTextField);
        }

        public function get adoptButton():MovieClip
        {
            return (view.getChildByName("adoptButton") as MovieClip);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
