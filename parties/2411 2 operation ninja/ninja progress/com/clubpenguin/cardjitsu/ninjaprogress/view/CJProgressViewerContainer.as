//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import flash.display.MovieClip;

    public class CJProgressViewerContainer extends BaseEmbeddedAssetView 
    {

        private const INSTANCE_NAME:String = "cjProgressViewer";

        public function CJProgressViewerContainer(AssetClass:Class)
        {
            super(AssetClass, this.INSTANCE_NAME);
        }

        public function getView():MovieClip
        {
            return (view as MovieClip);
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
