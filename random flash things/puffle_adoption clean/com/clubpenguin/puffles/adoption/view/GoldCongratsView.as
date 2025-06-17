//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class GoldCongratsView extends BaseEmbeddedAssetView 
    {

        public const GOLD_CONGRATULATIONS_VIEW:String = "goldPuffleCongrats";

        public function GoldCongratsView(AssetClass:Class)
        {
            super(AssetClass, this.GOLD_CONGRATULATIONS_VIEW);
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

        public function get congratsTitle_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("congratsTitle_txt")).localTextField);
        }

        public function get congratsDescription_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("congratsDescription_txt")).localTextField);
        }

        public function get puffleName_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("puffleName_txt")).localTextField);
        }

        public function get adoptionCertificate_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("adoptionCertificate_txt")).localTextField);
        }

        public function get toy_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("toy_txt")).localTextField);
        }

        public function get okButton_txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("okButton_txt")).localTextField);
        }

        public function get okButton():MovieClip
        {
            var btn:MovieClip = (view.getChildByName("okButton") as MovieClip);
            btn.buttonMode = true;
            return (btn);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
