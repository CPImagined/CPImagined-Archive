//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import flash.display.DisplayObject;

    public class PromptView extends BaseEmbeddedAssetView 
    {

        public const PROMPT_VIEW:String = "promptView";

        public function PromptView(AssetClass:Class)
        {
            super(AssetClass, this.PROMPT_VIEW);
        }

        override public function gotoAndStop(frame:Object, scene:String=null):void
        {
            MovieClip(view).gotoAndStop(frame, scene);
        }

        public function destroy():void
        {
            onCompleted.removeAll();
        }

        public function getView():DisplayObjectContainer
        {
            return (view);
        }

        public function get message():ILocalTextField
        {
            return (this.message_txt);
        }

        public function get text_input():TextField
        {
            return (view.getChildByName("text_input") as TextField);
        }

        public function get message_txt():ILocalTextField
        {
            var ltc:ILocalTextComponent = (view.getChildByName("message_ltc") as ILocalTextComponent);
            return ((ltc != null) ? ltc.localTextField : null);
        }

        public function get message_bottom_txt():ILocalTextField
        {
            var ltc:ILocalTextComponent = (view.getChildByName("message_bottom_ltc") as ILocalTextComponent);
            return ((ltc != null) ? ltc.localTextField : null);
        }

        public function get continue_txt():ILocalTextField
        {
            var ltc:ILocalTextComponent = (view.getChildByName("continue_ltc") as ILocalTextComponent);
            return ((ltc != null) ? ltc.localTextField : null);
        }

        public function get yes_txt():ILocalTextField
        {
            var ltc:ILocalTextComponent = (view.getChildByName("yes_ltc") as ILocalTextComponent);
            return ((ltc != null) ? ltc.localTextField : null);
        }

        public function get no_txt():ILocalTextField
        {
            var ltc:ILocalTextComponent = (view.getChildByName("no_ltc") as ILocalTextComponent);
            return ((ltc != null) ? ltc.localTextField : null);
        }

        public function get ok_txt():ILocalTextField
        {
            var ltc:ILocalTextComponent = (view.getChildByName("ok_ltc") as ILocalTextComponent);
            return ((ltc != null) ? ltc.localTextField : null);
        }

        public function get loading():MovieClip
        {
            return (view.getChildByName("loading") as MovieClip);
        }

        public function get icon_mc():MovieClip
        {
            return (view.getChildByName("icon_mc") as MovieClip);
        }

        public function get close_btn():DisplayObject
        {
            return (view.getChildByName("close_btn") as DisplayObject);
        }

        public function get continue_btn():DisplayObject
        {
            return (view.getChildByName("continue_btn") as DisplayObject);
        }

        public function get yes_btn():DisplayObject
        {
            return (view.getChildByName("yes_btn") as DisplayObject);
        }

        public function get no_btn():DisplayObject
        {
            return (view.getChildByName("no_btn") as DisplayObject);
        }

        public function get ok_btn():DisplayObject
        {
            return (view.getChildByName("ok_btn") as DisplayObject);
        }

        public function get card0():MovieClip
        {
            return (view.getChildByName("card0") as MovieClip);
        }

        public function get card1():MovieClip
        {
            return (view.getChildByName("card1") as MovieClip);
        }

        public function get card2():MovieClip
        {
            return (view.getChildByName("card2") as MovieClip);
        }
		
        public function get card3():MovieClip
        {
            return (view.getChildByName("card0") as MovieClip);
        }

        public function get card4():MovieClip
        {
            return (view.getChildByName("card1") as MovieClip);
        }

        public function get card5():MovieClip
        {
            return (view.getChildByName("card2") as MovieClip);
        }

    }
}//package com.clubpenguin.main.view
