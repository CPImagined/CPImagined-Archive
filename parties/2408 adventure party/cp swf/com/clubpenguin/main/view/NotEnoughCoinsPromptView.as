//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.MovieClip;

    public class NotEnoughCoinsPromptView extends BaseEmbeddedAssetView 
    {

        private const INSTANCE_NAME:String = "notEnoughCoinsPromptView";

        public function NotEnoughCoinsPromptView()
        {
            super(EmbeddedAssets.NotEnoughCoinsPromptAsset, this.INSTANCE_NAME);
        }

        public function get assetView():MovieClip
        {
            return (view as MovieClip);
        }


    }
}//package com.clubpenguin.main.view
