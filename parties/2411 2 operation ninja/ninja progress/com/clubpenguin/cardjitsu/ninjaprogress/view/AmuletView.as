//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.ElementLevelVO;
    import com.greensock.TweenMax;

    public class AmuletView 
    {

        private static const FIRE_GEM:String = "fireGemClip";
        private static const WATER_GEM:String = "waterGemClip";
        private static const SNOW_GEM:String = "snowGemClip";

        private var _skin:MovieClip;

        public function AmuletView(skin:MovieClip)
        {
            this._skin = skin;
            this._skin.visible = false;
        }

        public function update(fireData:ElementLevelVO, waterData:ElementLevelVO, snowData:ElementLevelVO):void
        {
            this.setGemVisibility(FIRE_GEM, (fireData.level > NinjaConstants.CHALLENGE_SENSEI_LEVEL_FIRE));
            this.setGemVisibility(WATER_GEM, (waterData.level > NinjaConstants.CHALLENGE_SENSEI_LEVEL_WATER));
            this.setGemVisibility(SNOW_GEM, (snowData.level >= NinjaConstants.CHALLENGE_TUSK_LEVEL_SNOW));
        }

        public function show():void
        {
            this._skin.visible = true;
        }

        public function hide():void
        {
        }

        private function setGemVisibility(gemName:String, visible:Boolean):void
        {
            var toAlpha:Number = ((visible) ? 1 : 0);
            TweenMax.to(this._skin[gemName], 0, {"autoAlpha":toAlpha});
        }

        public function destroy():void
        {
            this._skin = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
