//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;

    public class PufflePenView extends BaseEmbeddedAssetView 
    {

        public const ADOPTION_PEN_VIEW:String = "pufflePen";

        public function PufflePenView(AssetClass:Class)
        {
            super(AssetClass, this.ADOPTION_PEN_VIEW);
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

        public function get modalClip():MovieClip
        {
            return (view.getChildByName("modalClip") as MovieClip);
        }

        public function get btnRainbowPoster():MovieClip
        {
            return (view.getChildByName("btnRainbowPoster") as MovieClip);
        }

        public function get btnGoldPoster():MovieClip
        {
            return (view.getChildByName("btnGoldPoster") as MovieClip);
        }

        public function get statsBoard():MovieClip
        {
            return (view.getChildByName("statsBoard") as MovieClip);
        }

        public function get lightRays():MovieClip
        {
            return (view.getChildByName("lightRays") as MovieClip);
        }

        public function get modalNonMember():MovieClip
        {
            return (view.getChildByName("modalNonMember") as MovieClip);
        }

        public function get memberPuffleRug():MovieClip
        {
            return (view.getChildByName("memberPuffleRug") as MovieClip);
        }

        public function get nonmemberPuffleRug():MovieClip
        {
            return (view.getChildByName("nonmemberPuffleRug") as MovieClip);
        }

        public function getPuffleHolder(index:uint):MovieClip
        {
            return (view.getChildByName(("puffleHolder" + index)) as MovieClip);
        }

        public function getMemberPuffleHolder(index:uint):MovieClip
        {
            return (view.getChildByName(("memberPuffleHolder" + index)) as MovieClip);
        }

        public function getPuffleButton(name:String):MovieClip
        {
            return (MovieClip(this.statsBoard.clipboardDefault).getChildByName((name + "PuffleButton")) as MovieClip);
        }


    }
}//package com.clubpenguin.puffles.adoption.view
