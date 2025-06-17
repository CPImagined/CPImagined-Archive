//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class CrystalCongratsView extends BaseEmbeddedAssetView 
    {

        public const CRYSTAL_ADOPTION_CERTIFICATE:String = "crystalAdoptionCertificate";

        public function CrystalCongratsView(AssetClass:Class)
        {
            super(AssetClass, this.CRYSTAL_ADOPTION_CERTIFICATE);
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

        public function get okButton():MovieClip
        {
            var mc:MovieClip = (view.getChildByName("okButton_mc") as MovieClip);
            mc.buttonMode = true;
            return (mc);
        }

        public function get okButtonText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("buttonText")).localTextField);
        }

        public function get puffleNameTextBox():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("puffleName_txt")).localTextField);
        }

        public function get crystalAdoptionCertificateTitle():MovieClip
        {
            var mc:MovieClip = (view.getChildByName("adoptionCertificateTitle_mc") as MovieClip);
            return (mc);
        }

        public function get wasAdopted():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("wasAdopted_txt")).localTextField);
        }

        public function get certifiesThat_Text():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("hasChosen_txt")).localTextField);
        }

        public function get dateText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("date_txt")).localTextField);
        }

        public function get locationOfPuffleText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("locationWildText")).localTextField);
        }

        public function get careOfPuffleText():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("careOfPuffle_txt")).localTextField);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
