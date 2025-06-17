//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class PuffleAdoptionView extends BaseEmbeddedAssetView 
    {

        public const PUFFLE_ADOPTION_VIEW:String = "puffleAdoption";

        public function PuffleAdoptionView(AssetClass:Class)
        {
            super(AssetClass, this.PUFFLE_ADOPTION_VIEW);
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
            var btn:MovieClip = (view.getChildByName("close_btn") as MovieClip);
            btn.buttonMode = true;
            return (btn);
        }

        public function get adoptButton():MovieClip
        {
            return (view.getChildByName("lib_party_member2_btn") as MovieClip);
        }

        public function get adoptButtonText():TextField
        {
            var tf:TextField = (this.adoptButton.getChildByName("adopt_button_text") as TextField);
            tf.mouseEnabled = false;
            return (tf);
        }

        public function get inputBackground():MovieClip
        {
            return (view.getChildByName("puffle_name_input") as MovieClip);
        }

        public function get adoptPuffleText():TextField
        {
            return (view.getChildByName("adoptthispuffle_text") as TextField);
        }

        public function get inputTextField():TextField
        {
            return (view.getChildByName("inputfield_text") as TextField);
        }

        public function get inputDefaultText():TextField
        {
            return (this.inputBackground.getChildByName("default_text") as TextField);
        }

        public function get errorField():MovieClip
        {
            return (view.getChildByName("lib_error_text") as MovieClip);
        }

        public function get errorFieldText():ILocalTextField
        {
            return (ILocalTextComponent(this.errorField.getChildByName("error_text")).localTextField);
        }

        public function get coinGraphic():MovieClip
        {
            return (view.getChildByName("coin_graphic") as MovieClip);
        }

        public function get coinAmountText():TextField
        {
            return (view.getChildByName("coin_amount") as TextField);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
