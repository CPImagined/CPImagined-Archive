//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.view
{
    import flash.display.MovieClip;
    import org.osflash.signals.Signal;
    import com.clubpenguin.puffles.adoption.model.PufflePenViewEnum;

    public class PuffleView extends MovieClip 
    {

        public var ambientClip:MovieClip;
        public var ambientClip2:MovieClip;
        public var attentionClip:MovieClip;
        public var selectedClip:MovieClip;
        public var deselect:Signal = new Signal();
        public var pufflePenViewEnum:PufflePenViewEnum;

        public function PuffleView(pufflePenViewEnum:PufflePenViewEnum)
        {
            this.ambientClip = MovieClip(new pufflePenViewEnum.ambientViewClass());
            this.ambientClip2 = MovieClip(new pufflePenViewEnum.ambient2ViewClass());
            this.attentionClip = MovieClip(new pufflePenViewEnum.attentionViewClass());
            this.selectedClip = MovieClip(new pufflePenViewEnum.selectedViewClass());
            this.pufflePenViewEnum = pufflePenViewEnum;
        }

    }
}//package com.clubpenguin.puffles.adoption.view
