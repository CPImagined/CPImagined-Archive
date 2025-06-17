//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.services
{
    import com.clubpenguin.puffles.adoption.model.AdoptionConstants;
    import com.disney.disneylearning.managers.DLSManager;

    public class PuffleAdoptionDLearningService 
    {

        private var pufflesArray:Array;

        public function PuffleAdoptionDLearningService()
        {
            this.pufflesArray = new Array();
            this.pufflesArray["orange"] = AdoptionConstants.Puffle_Adopted_Orange;
            this.pufflesArray["brown"] = AdoptionConstants.Puffle_Adopted_Brown;
            this.pufflesArray["red"] = AdoptionConstants.Puffle_Adopted_Red;
            this.pufflesArray["purple"] = AdoptionConstants.Puffle_Adopted_Purple;
            this.pufflesArray["pink"] = AdoptionConstants.Puffle_Adopted_Pink;
            this.pufflesArray["black"] = AdoptionConstants.Puffle_Adopted_Black;
            this.pufflesArray["blue"] = AdoptionConstants.Puffle_Adopted_Blue;
            this.pufflesArray["green"] = AdoptionConstants.Puffle_Adopted_Green;
            this.pufflesArray["yellow"] = AdoptionConstants.Puffle_Adopted_Yellow;
            this.pufflesArray["white"] = AdoptionConstants.Puffle_Adopted_White;
            this.pufflesArray["rainbow"] = AdoptionConstants.Puffle_Adopted_Rainbow;
        }

        public function startPuffleAdoption():void
        {
            DLSManager.instance.pushOpcode("START", AdoptionConstants.Puffle_Adoption, this.callBackFunc, "0", "0", "0");
        }

        public function stopPuffleAdoption():void
        {
            DLSManager.instance.pushOpcode("STOP", AdoptionConstants.Puffle_Adoption, this.callBackFunc, "0", "0", "0");
        }

        public function adoptPuffleFromQuiz(fromQuiz:Boolean):void
        {
            if (fromQuiz)
            {
                DLSManager.instance.pushOpcode("SELECTED", AdoptionConstants.Adopt_from_Puffle_Quiz, this.callBackFunc, "0", "0", "0");
            }
            else
            {
                DLSManager.instance.pushOpcode("SELECTED", AdoptionConstants.Adopt_from_Puffle_Pen, this.callBackFunc, "0", "0", "0");
            };
        }

        public function adoptPuffle(colorName:String):void
        {
            DLSManager.instance.pushOpcode("SELECTED", this.pufflesArray[colorName], this.callBackFunc, "0", "0", "0");
        }

        private function callBackFunc(retString:String):void
        {
        }


    }
}//package com.clubpenguin.puffles.adoption.services
