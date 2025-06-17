//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.PuffleView;
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.puffles.adoption.managers.AnimationSequencer;
    import flash.events.Event;
    import com.clubpenguin.puffles.adoption.managers.AnimationVO;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import org.osflash.signals.Signal;

    public class PuffleMediator extends Mediator 
    {

        [Inject]
        public var view:PuffleView;
        [Inject]
        public var signalBus:AdoptionSignalBus;
        [Inject]
        public var model:AdoptionModel;
        private var animationSequencer:AnimationSequencer;


        override public function onRegister():void
        {
            this.view.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved, false, 0, true);
            this.view.buttonMode = true;
            this.view.deselect.add(this.onDeselect);
            this.animationSequencer = new AnimationSequencer(this.view);
            this.animationSequencer.push(new AnimationVO(this.view.ambientClip, false, false, 1, 1));
            this.animationSequencer.push(new AnimationVO(this.view.ambientClip2, false, false, 1, 1));
            this.animationSequencer.push(new AnimationVO(this.view.attentionClip, false, false, 0.35, 1));
            this.animationSequencer.startSequence();
            this.view.addEventListener(MouseEvent.MOUSE_UP, this.onClick);
        }

        private function onDeselect():void
        {
            this.animationSequencer.resumeAmbient();
        }

        private function onClick(event:MouseEvent):void
        {
            var chosenPuffleVO:PuffleVO = this.view.pufflePenViewEnum.createPuffleVO();
            Signal(this.signalBus.setChosenPuffle).dispatch(chosenPuffleVO);
            this.animationSequencer.push(new AnimationVO(this.view.selectedClip, true, true, 0, 1));
        }

        private function onRemoved(event:Event):void
        {
            this.animationSequencer.destroy();
            this.view.deselect.remove(this.onDeselect);
            this.view.removeEventListener(MouseEvent.MOUSE_UP, this.onClick);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
