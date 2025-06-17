//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.view
{
    import mx.core.MovieClipLoaderAsset;
    import flash.utils.ByteArray;

    public class EndGameViewAssets_ScrollingStampsSkin extends MovieClipLoaderAsset 
    {

        private static var bytes:ByteArray = null;

        public var dataClass:Class = EndGameViewAssets_ScrollingStampsSkin_dataClass;

        public function EndGameViewAssets_ScrollingStampsSkin()
        {
            initialWidth = (15200 / 20);
            initialHeight = (9600 / 20);
        }

        override public function get movieClipData():ByteArray
        {
            if (bytes == null)
            {
                bytes = ByteArray(new this.dataClass());
            };
            return (bytes);
        }


    }
}//package com.clubpenguin.endscreens.view
