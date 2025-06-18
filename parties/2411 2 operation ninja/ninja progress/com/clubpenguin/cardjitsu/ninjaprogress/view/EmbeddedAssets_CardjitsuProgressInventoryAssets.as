//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import mx.core.MovieClipLoaderAsset;
    import flash.utils.ByteArray;

    public class EmbeddedAssets_CardjitsuProgressInventoryAssets extends MovieClipLoaderAsset 
    {

        private static var bytes:ByteArray = null;

        public var dataClass:Class = EmbeddedAssets_CardjitsuProgressInventoryAssets_dataClass;

        public function EmbeddedAssets_CardjitsuProgressInventoryAssets()
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
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
