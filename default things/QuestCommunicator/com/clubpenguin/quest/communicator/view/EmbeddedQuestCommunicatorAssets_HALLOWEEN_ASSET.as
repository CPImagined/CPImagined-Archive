//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.quest.communicator.view
{
    import mx.core.MovieClipLoaderAsset;
    import flash.utils.ByteArray;

    public class EmbeddedQuestCommunicatorAssets_HALLOWEEN_ASSET extends MovieClipLoaderAsset 
    {

        private static var bytes:ByteArray = null;

//        [Embed(_resolvedSource="/Users/chenj133/Desktop/SVN/client/1022_halloween_party/modules/quest/communicator/assets/halloween_dialogue_party_icon.swf", mimeType="application/octet-stream")]
        public var dataClass:Class = EmbeddedQuestCommunicatorAssets_HALLOWEEN_ASSET_dataClass;

        public function EmbeddedQuestCommunicatorAssets_HALLOWEEN_ASSET()
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
}//package com.clubpenguin.quest.communicator.view
