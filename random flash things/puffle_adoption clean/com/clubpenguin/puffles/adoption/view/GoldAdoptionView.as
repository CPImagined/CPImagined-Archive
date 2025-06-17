//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class GoldAdoptionView extends BaseEmbeddedAssetView 
    {

        public const GOLD_ADOPTION_VIEW:String = "goldAdoption";

        public function GoldAdoptionView(AssetClass:Class)
        {
            super(AssetClass, this.GOLD_ADOPTION_VIEW);
        }

        public function getView():DisplayObjectContainer
        {
            return (view);
        }

        public function get closeButton():MovieClip
        {
            var btn:MovieClip = (view.getChildByName("closeButton") as MovieClip);
            btn.buttonMode = true;
            return (btn);
        }

        public function get titlemc():MovieClip
        {
            return (view.getChildByName("titlemc") as MovieClip);
        }

        public function get puffleName_txt():TextField
        {
            var it:TextField = (view.getChildByName("puffleName_txt") as TextField);
            return (it);
        }

        public function get choosemc():MovieClip
        {
            return (view.getChildByName("choosemc") as MovieClip);
        }

        public function get adoptButton_btn():MovieClip
        {
            var btn:MovieClip = (view.getChildByName("adoptButton_btn") as MovieClip);
            btn.buttonMode = true;
            return (btn);
        }

        public function get adoptButton_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("adoptButton_txt")).localTextField);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
