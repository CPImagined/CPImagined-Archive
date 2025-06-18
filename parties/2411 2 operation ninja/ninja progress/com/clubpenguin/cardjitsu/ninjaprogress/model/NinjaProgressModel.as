//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.model
{
    import flash.events.EventDispatcher;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.StoryVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.LocalizationVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.ModelUpdateEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.ElementLevelVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.CardVO;

    public class NinjaProgressModel extends EventDispatcher 
    {

        private var _elementLevels:Object;
        private var _storyProgress:Array;
        private var _cardCollection:Array;


        public function setStoryProgress(videosUnlocked:Number):void
        {
            var isLocked:Boolean;
            var videoURL:String;
            var storyVO:StoryVO;
            var storyProgress:Array = [];
            var i:Number = 1;
            while (i <= NinjaConstants.STORY_MAX_LEVELS)
            {
                isLocked = (i > videosUnlocked);
                videoURL = LocalizationVO.LOCALIZED_PATHS_TOKENS[("STORY_CINEMATIC_URL_" + i)];
                storyVO = new StoryVO(i, isLocked, videoURL);
                storyProgress.push(storyVO);
                i++;
            };
            this._storyProgress = storyProgress;
            dispatchEvent(new ModelUpdateEvent(ModelUpdateEvent.MODEL_UPDATED, NinjaConstants.STORY_PROGRESS));
        }

        public function setElementLevels(elementLevels:Object):void
        {
            var storyProgress:Number;
            this._elementLevels = elementLevels;
            var snowLevel:Number = this._elementLevels[NinjaConstants.GAME_TYPE_SNOW].level;
            if (StoryVO.CINEMATIC_9_STATUS[StoryVO.HAS_TUSK_CAPE] == true)
            {
                storyProgress = 9;
            }
            else
            {
                if (snowLevel >= NinjaConstants.CINEMATIC_EIGHT_UNLOCKED_LEVEL)
                {
                    storyProgress = 8;
                }
                else
                {
                    if (snowLevel >= NinjaConstants.CINEMATIC_SEVEN_UNLOCKED_LEVEL)
                    {
                        storyProgress = 7;
                    }
                    else
                    {
                        if (snowLevel >= NinjaConstants.CINEMATIC_SIX_UNLOCKED_LEVEL)
                        {
                            storyProgress = 6;
                        }
                        else
                        {
                            if (snowLevel >= NinjaConstants.CINEMATIC_FIVE_UNLOCKED_LEVEL)
                            {
                                storyProgress = 5;
                            }
                            else
                            {
                                if (snowLevel >= NinjaConstants.CINEMATIC_FOUR_UNLOCKED_LEVEL)
                                {
                                    storyProgress = 4;
                                }
                                else
                                {
                                    if (snowLevel >= NinjaConstants.CINEMATIC_THREE_UNLOCKED_LEVEL)
                                    {
                                        storyProgress = 3;
                                    }
                                    else
                                    {
                                        if (snowLevel >= NinjaConstants.CINEMATIC_TWO_UNLOCKED_LEVEL)
                                        {
                                            storyProgress = 2;
                                        }
                                        else
                                        {
                                            if (snowLevel >= NinjaConstants.CINEMATIC_ONE_UNLOCKED_LEVEL)
                                            {
                                                storyProgress = 1;
                                            }
                                            else
                                            {
                                                storyProgress = 0;
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            this.setStoryProgress(storyProgress);
            dispatchEvent(new ModelUpdateEvent(ModelUpdateEvent.MODEL_UPDATED, NinjaConstants.ELEMENT_LEVELS));
        }

        public function setCardCollection(cardCollection:Array):void
        {
            this._cardCollection = cardCollection;
            dispatchEvent(new ModelUpdateEvent(ModelUpdateEvent.MODEL_UPDATED, NinjaConstants.CARD_COLLECTION));
        }

        public function getStoryProgress():Array
        {
            return (this._storyProgress);
        }

        public function getElementLevel(_arg_1:String):ElementLevelVO
        {
            return (this._elementLevels[_arg_1]);
        }

        public function getCardCollection():Array
        {
            return (this._cardCollection);
        }

        public function destroy():void
        {
            var storyVO:StoryVO;
            var cardVO:CardVO;
            for each (storyVO in this._storyProgress)
            {
                storyVO.destroy();
                storyVO = null;
            };
            this._storyProgress = [];
            for each (cardVO in this._cardCollection)
            {
                cardVO.destroy();
                cardVO = null;
            };
            this._cardCollection = [];
            this._elementLevels = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.model
