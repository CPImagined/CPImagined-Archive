//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.MovieClip;

    public class CardThumbView extends BaseEmbeddedAssetView 
    {

        public const CARD_THUMB_VIEW_INSTANCE_NAME:String = "cardThumbView";

        public function CardThumbView(AssetClass:Class)
        {
            super(AssetClass, this.CARD_THUMB_VIEW_INSTANCE_NAME);
        }

        public function get card():MovieClip
        {
            return (view.getChildByName("card") as MovieClip);
        }

        public function get memberOnly():MovieClip
        {
            return (view.getChildByName("memberOnly") as MovieClip);
        }

        public function get placeholder():MovieClip
        {
            return (view.getChildByName("placeholder") as MovieClip);
        }

        public function get loading():MovieClip
        {
            return (view.getChildByName("loading") as MovieClip);
        }


    }
}//package com.clubpenguin.main.view
