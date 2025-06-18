//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.view
{
    import mx.core.MovieClipLoaderAsset;
    import flash.utils.ByteArray;

    public class EmbeddedAssets_PromptAssets extends MovieClipLoaderAsset 
    {

        private static var bytes:ByteArray = null;

        public var dataClass:Class = EmbeddedAssets_PromptAssets_dataClass;

        public function EmbeddedAssets_PromptAssets()
        {
            initialWidth = (11000 / 20);
            initialHeight = (8000 / 20);
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
}//package com.clubpenguin.main.view
