//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;
    import flash.text.TextField;

    public class PuffleCongratsView extends BaseEmbeddedAssetView 
    {

        public const PUFFLE_CONGRATS_VIEW:String = "puffleAdoptionCongrats";

        public function PuffleCongratsView(AssetClass:Class)
        {
            super(AssetClass, this.PUFFLE_CONGRATS_VIEW);
        }

        public function getView():DisplayObjectContainer
        {
            return (view);
        }

        public function get closeButton():MovieClip
        {
            var mc:MovieClip = (view.getChildByName("closeButton") as MovieClip);
            mc.buttonMode = true;
            return (mc);
        }

        public function get okButton():MovieClip
        {
            var mc:MovieClip = (view.getChildByName("okButton_mc") as MovieClip);
            mc.buttonMode = true;
            return (mc);
        }

        public function get inventoryList():MovieClip
        {
            var mc:MovieClip = (view.getChildByName("inventoryList") as MovieClip);
            return (mc);
        }

        public function get title_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("congratsTitle_txt")).localTextField);
        }

        public function get description_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("congratsDescription_txt")).localTextField);
        }

        public function get adoptionCertificate_Txt():ILocalTextField
        {
            return (ILocalTextComponent(this.inventoryList["adoptionCertificate_txt"]).localTextField);
        }

        public function get item1():MovieClip
        {
            var mc:MovieClip = (this.inventoryList["item1"] as MovieClip);
            return (mc);
        }

        public function get item1Amount_Txt():TextField
        {
            return (TextField(this.inventoryList["item1Amount_txt"]));
        }

        public function get item1_Txt():ILocalTextField
        {
            return (ILocalTextComponent(this.inventoryList["item1_txt"]).localTextField);
        }

        public function get item2():MovieClip
        {
            var mc:MovieClip = (this.inventoryList["item2"] as MovieClip);
            return (mc);
        }

        public function get item2Amount_Txt():TextField
        {
            return (TextField(this.inventoryList["item2Amount_txt"]));
        }

        public function get item2_Txt():ILocalTextField
        {
            return (ILocalTextComponent(this.inventoryList["item2_txt"]).localTextField);
        }

        public function get button_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("buttonText")).localTextField);
        }

        public function get whereRegularPuffle_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("locationText")).localTextField);
        }

        public function get whereWildPuffle_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("locationWildText")).localTextField);
        }

        public function get puffleName_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("puffleNameText")).localTextField);
        }

        public function get careOfPuffle_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("careOfPuffle_txt")).localTextField);
        }

        public function get hasChosen_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("hasChosen_txt")).localTextField);
        }

        public function get wasAdopted_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("wasAdopted_txt")).localTextField);
        }

        public function get date_Txt():ILocalTextField
        {
            return (ILocalTextComponent(view.getChildByName("date_txt")).localTextField);
        }

        public function get adoptionCertificateTitle():MovieClip
        {
            var mc:MovieClip = (view.getChildByName("adoptionCertificateTitle_mc") as MovieClip);
            return (mc);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
