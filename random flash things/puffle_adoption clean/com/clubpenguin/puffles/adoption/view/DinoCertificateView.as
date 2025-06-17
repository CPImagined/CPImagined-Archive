//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class DinoCertificateView extends BaseEmbeddedAssetView 
    {

        public const DINO_ADOPTION_CERTIFICATE:String = "dinoAdoptionCertificate";

        public function DinoCertificateView(AssetClass:Class)
        {
            super(AssetClass, this.DINO_ADOPTION_CERTIFICATE);
        }

        public function getView():DisplayObjectContainer
        {
            return (view);
        }

        public function get closeButton():MovieClip
        {
            var btn:MovieClip = (view.getChildByName("closeBtn") as MovieClip);
            btn.buttonMode = true;
            return (btn);
        }

        public function get puffleNameTextBox():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("puffleName_txt")).localTextField);
        }

        public function get dinoAdoptionCertificateTitle():MovieClip
        {
            var mc:MovieClip = (view.getChildByName("adoptionCertificateTitle_txt") as MovieClip);
            return (mc);
        }

        public function get hasChosenText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("hasChosen_txt")).localTextField);
        }

        public function get penguinNameText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("penguinName_txt")).localTextField);
        }

        public function get dateText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("date_txt")).localTextField);
        }

        public function get locationOfPuffleText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("locationOfPuffle_txt")).localTextField);
        }

        public function get careOfPuffleText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("careOfPuffle_txt")).localTextField);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
