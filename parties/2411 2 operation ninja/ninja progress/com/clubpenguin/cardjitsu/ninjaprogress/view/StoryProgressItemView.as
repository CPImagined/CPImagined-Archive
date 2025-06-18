//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.StoryVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.LocalizationVO;
    import fl.motion.Color;
    import flash.events.MouseEvent;

    public class StoryProgressItemView extends EventDispatcher 
    {

        private static const TITLE:String = "titleText";
        private static const LOCK:String = "lockIcon";
        private static const PLAY:String = "playBtn";
        private static const IMAGE:String = "image";
        private static const STILLS:String = "stills";

        private var _skin:MovieClip;
        private var _storyVO:StoryVO;
        private var _localeTextReplacer:ILocaleTextReplacer;

        public function StoryProgressItemView(storyVO:StoryVO, skin:MovieClip, localeTextReplacer:ILocaleTextReplacer)
        {
            this._storyVO = storyVO;
            this._skin = skin;
            this._localeTextReplacer = localeTextReplacer;
            skin[IMAGE][STILLS].gotoAndStop(skin.name);
            this.setLocked(storyVO.isLocked);
            this.localize();
        }

        public function localize():void
        {
            var localizedText:String = "";
            switch (this._storyVO.storyLevel)
            {
                case 1:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_1];
                    break;
                case 2:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_2];
                    break;
                case 3:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_3];
                    break;
                case 4:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_4];
                    break;
                case 5:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_5];
                    break;
                case 6:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_6];
                    break;
                case 7:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_7];
                    break;
                case 8:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_8];
                    break;
                case 9:
                    localizedText = LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_CINEMATIC_TITLE_9];
                    break;
            };
            this._localeTextReplacer.replaceText(this._skin[TITLE], localizedText);
        }

        public function setLocked(locked:Boolean):void
        {
            var enabledColor:Color;
            if (locked)
            {
                this._skin[TITLE].visible = false;
                this._skin[LOCK].visible = true;
                this._skin[PLAY].visible = false;
                this._skin[IMAGE][STILLS].visible = false;
                this.removeEventListeners();
            }
            else
            {
                this._skin[TITLE].visible = true;
                this._skin[LOCK].visible = false;
                this._skin[PLAY].visible = true;
                this._skin[IMAGE][STILLS].visible = true;
                enabledColor = new Color();
                enabledColor.setTint(0, 0);
                this._skin[IMAGE].transform.colorTransform = enabledColor;
                this.addEventListeners();
            };
        }

        public function getVideoURL():String
        {
            return (this._storyVO.videoURL);
        }

        private function addEventListeners():void
        {
            this._skin[PLAY].addEventListener(MouseEvent.CLICK, dispatchEvent);
        }

        private function removeEventListeners():void
        {
            this._skin[PLAY].removeEventListener(MouseEvent.CLICK, dispatchEvent);
        }

        public function destroy():void
        {
            this._skin;
            this._storyVO = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
