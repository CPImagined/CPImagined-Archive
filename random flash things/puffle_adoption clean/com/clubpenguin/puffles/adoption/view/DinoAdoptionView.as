//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class DinoAdoptionView extends BaseEmbeddedAssetView 
    {

        public const DINO_ADOPTION_VIEW:String = "dinoAdoption";

        public function DinoAdoptionView(AssetClass:Class)
        {
            super(AssetClass, this.DINO_ADOPTION_VIEW);
        }

        public function getView():DisplayObjectContainer
        {
            return (view);
        }

        public function get getPuffleView():MovieClip
        {
            var mc:MovieClip = (view.getChildByName("puffleView") as MovieClip);
            return (mc);
        }

        public function get closeButton():MovieClip
        {
            var btn:MovieClip = (view.getChildByName("closeBtn") as MovieClip);
            btn.buttonMode = true;
            return (btn);
        }

        public function get adoptButton():MovieClip
        {
            var btn:MovieClip = (view.getChildByName("adoptBtn") as MovieClip);
            btn.buttonMode = true;
            return (btn);
        }

        public function get puffleNameTextBox():TextField
        {
            var it:TextField = (view.getChildByName("puffleName_txt") as TextField);
            return (it);
        }

        public function get dinoAdoptionTitle():ILocalTextField
        {
            return (ILocalTextComponent(this.getPuffleView["dinoAdoption_txt"]).localTextField);
        }

        public function get chooseNameText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("chooseName_txt")).localTextField);
        }

        public function get adoptButtonText():ILocalTextField
        {
            return (ILocalTextComponent(this.adoptButton["adoptButton_txt"]).localTextField);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
