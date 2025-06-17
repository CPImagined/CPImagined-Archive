//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class RainbowAdoptionView extends BaseEmbeddedAssetView 
    {

        public const RAINBOW_ADOPTION_VIEW:String = "rainbowAdoption";

        public function RainbowAdoptionView(AssetClass:Class)
        {
            super(AssetClass, this.RAINBOW_ADOPTION_VIEW);
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

        public function get adoptBtn():SimpleButton
        {
            return (view.getChildByName("adoptBtn") as SimpleButton);
        }

        public function get puffleName_txt():TextField
        {
            var it:TextField = (view.getChildByName("puffleName_txt") as TextField);
            return (it);
        }

        public function get modalClip():MovieClip
        {
            return (view.getChildByName("modalClip") as MovieClip);
        }

        public function get adoptionTagline_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("adoptionTagline_txt")).localTextField);
        }

        public function get chooseName_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("chooseName_txt")).localTextField);
        }

        public function get adopt_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("adopt_txt")).localTextField);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
