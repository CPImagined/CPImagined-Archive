//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.signals
{
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import flash.display.MovieClip;

    public class AdoptionSignalBus 
    {

        public const setupViewsSignal:ISignal = new Signal();

        public var closeModule:ISignal;
        public var openModule:ISignal;
        public var showError:ISignal;
        public var showOverlay:ISignal;
        public var setChosenPuffle:ISignal = new Signal(PuffleVO);
        public var sendError:ISignal = new Signal(uint);
        public var chosenPuffleChanged:ISignal = new Signal(PuffleVO);
        public var setSpotlight:ISignal = new Signal(MovieClip);
        public var showPuffleSignal:ISignal = new Signal(Number);


    }
}//package com.clubpenguin.puffles.adoption.signals
