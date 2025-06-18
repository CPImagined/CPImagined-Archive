//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import flash.events.MouseEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.NinjaModuleEvent;

    public class StoryProgressScrollView extends EventDispatcher 
    {

        private static const SNOW_VIDEO_THUMBS:String = "snowVideoThumbs";
        private static const SCROLL_PANE:String = "scrollPane";

        private var _skin:MovieClip;
        private var _scrollPane:*;
        private var _videoThumbs:MovieClip;
        private var _storyItems:Array;
        private var _localeTextReplacer:ILocaleTextReplacer;

        public function StoryProgressScrollView(skin:MovieClip, localeTextReplacer:ILocaleTextReplacer)
        {
            this._skin = skin;
            this._videoThumbs = skin[SNOW_VIDEO_THUMBS];
            this._scrollPane = skin[SCROLL_PANE];
            this._scrollPane["init"].call(null, this._videoThumbs, 491.85, 210);
            this._localeTextReplacer = localeTextReplacer;
            skin.visible = false;
        }

        public function show():void
        {
            this._skin.visible = true;
            this.addEventListeners();
        }

        public function hide():void
        {
            this.removeEventListeners();
        }

        private function addEventListeners():void
        {
            var storyItem:StoryProgressItemView;
            for each (storyItem in this._storyItems)
            {
                storyItem.addEventListener(MouseEvent.CLICK, this.storyItemOnMouseClick);
            };
        }

        private function removeEventListeners():void
        {
            var storyItem:StoryProgressItemView;
            for each (storyItem in this._storyItems)
            {
                storyItem.removeEventListener(MouseEvent.CLICK, this.storyItemOnMouseClick);
            };
        }

        public function setStoryItems(storyItems:Array):void
        {
            var index:String;
            var storyItemMC:MovieClip;
            var storyItem:StoryProgressItemView;
            this._storyItems = [];
            for (index in storyItems)
            {
                storyItemMC = this._videoThumbs[("level" + (Number(index) + 1))];
                storyItem = new StoryProgressItemView(storyItems[index], storyItemMC, this._localeTextReplacer);
                storyItem.addEventListener(MouseEvent.CLICK, this.storyItemOnMouseClick);
                this._storyItems.push(storyItem);
            };
        }

        private function storyItemOnMouseClick(event:MouseEvent):void
        {
            var storyItem:StoryProgressItemView = (event.target as StoryProgressItemView);
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.PLAY_VIDEO, null, storyItem.getVideoURL()));
        }

        public function destroy():void
        {
            var storyItem:StoryProgressItemView;
            this.removeEventListeners();
            this._skin;
            this._scrollPane;
            this._videoThumbs = null;
            for each (storyItem in this._storyItems)
            {
                storyItem.destroy();
                storyItem = null;
            };
            this._storyItems = [];
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
