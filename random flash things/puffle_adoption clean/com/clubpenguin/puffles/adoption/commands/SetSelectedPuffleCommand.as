//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;

    public class SetSelectedPuffleCommand extends SignalCommand 
    {

        [Inject]
        public var mainModel:AdoptionModel;
        [Inject]
        public var puffleVO:PuffleVO;


        override public function execute():void
        {
            this.mainModel.selectedPuffle = this.puffleVO;
        }


    }
}//package com.clubpenguin.puffles.adoption.commands
