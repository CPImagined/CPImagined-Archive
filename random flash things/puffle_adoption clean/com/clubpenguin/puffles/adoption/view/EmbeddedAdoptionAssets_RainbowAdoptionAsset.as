﻿//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import mx.core.MovieClipLoaderAsset;
    import flash.utils.ByteArray;

    public class EmbeddedAdoptionAssets_RainbowAdoptionAsset extends MovieClipLoaderAsset 
    {

        private static var bytes:ByteArray = null;

        public var dataClass:Class = EmbeddedAdoptionAssets_RainbowAdoptionAsset_dataClass;

        public function EmbeddedAdoptionAssets_RainbowAdoptionAsset()
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
}//package com.clubpenguin.puffles.adoption.view
