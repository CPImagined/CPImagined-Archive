//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import com.clubpenguin.puffles.adoption.SpotlightView;
    import com.clubpenguin.puffles.adoption.SpotlightBottomView;
    import flash.display.MovieClip;

    public class Spotlight 
    {

        private var spotlight:SpotlightView = new SpotlightView();
        private var spotlightBottom:SpotlightBottomView = new SpotlightBottomView();


        public function switchOn(selectedObject:MovieClip):void
        {
            selectedObject.parent.addChildAt(this.spotlightBottom, 0);
            selectedObject.parent.addChild(this.spotlight);
            this.spotlight.animation.gotoAndPlay(2);
            this.spotlightBottom.animation.gotoAndPlay(2);
            selectedObject.parent.mouseChildren = false;
            selectedObject.parent.mouseEnabled = false;
        }

        public function switchOff():void
        {
            if (this.spotlight.parent)
            {
                this.spotlight.parent.mouseChildren = true;
                this.spotlight.parent.mouseEnabled = true;
            };
            this.spotlight.animation.gotoAndPlay("switchOff");
            this.spotlightBottom.animation.gotoAndPlay("switchOff");
        }


    }
}//package com.clubpenguin.puffles.adoption.view
