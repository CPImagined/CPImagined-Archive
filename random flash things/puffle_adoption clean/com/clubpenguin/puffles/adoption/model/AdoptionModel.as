//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.model
{
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.puffles.adoption.services.PuffleAdoptionSocketService;
    import com.clubpenguin.lib.vo.PlayerVO;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.main.signal.SignalBus;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;

    public class AdoptionModel 
    {

        public var signalBus:AdoptionSignalBus;
        public var clientPath:String;
        public var invalidNameSelected:Signal = new Signal();
        public var validNameSelected:Signal = new Signal();
        public var puffleAdopted:Signal = new Signal();
        public var notEnoughCoins:Signal = new Signal();
        public var nameSuggestion:Signal = new Signal(String);
        private var _selectedPuffle:PuffleVO = new PuffleVO();
        private var _localizationManger:ILocalizationManager;
        private var _puffleAdoptionService:PuffleAdoptionSocketService = new PuffleAdoptionSocketService();
        private var _playerVO:PlayerVO;
        private var adoptionBIModel:AdoptionBIModel = new AdoptionBIModel();
        private var _puffleAdoptType:String = "";
        private var _puffleAdoptionTypeId:Number = 0;
        private var _nameSuggestions:PuffleNameSuggestions = new PuffleNameSuggestions();
        private var _testedNames:PuffleNameCache = new PuffleNameCache();


        public function init(socketConnection:IConnection, appSignalBus:SignalBus, tracker:Tracker):void
        {
            this._puffleAdoptionService.init(socketConnection, this, appSignalBus, tracker);
            this.startSession();
        }

        public function destroy():void
        {
            this._puffleAdoptionService.destroy();
        }

        public function adoptSelectedPuffle():void
        {
            this._puffleAdoptionService.adoptPuffle(this._selectedPuffle);
        }

        public function setSelectedNameAsValid(name:String):void
        {
            this._testedNames.cacheTestedName(name, true);
            this.validNameSelected.dispatch();
        }

        public function setSelectedNameAsInvalid(name:String):void
        {
            this._testedNames.cacheTestedName(name, false);
            this.invalidNameSelected.dispatch();
        }

        public function checkValidPuffleName():void
        {
            this._puffleAdoptionService.checkPuffleName(this._selectedPuffle.name);
        }

        public function checkPuffleNameWithResponse():void
        {
            var name:String = this._selectedPuffle.name;
            if (this.isNameCached(name))
            {
                if (this.isNameValid(name))
                {
                    this.validNameSelected.dispatch();
                }
                else
                {
                    this.invalidNameSelected.dispatch();
                };
            }
            else
            {
                this._puffleAdoptionService.checkPuffleNameWithResponse(name);
            };
        }

        public function isNameCached(name:String):Boolean
        {
            return (this._testedNames.isNameCached(name));
        }

        public function isNameValid(name:String):Boolean
        {
            var valid:Boolean = this._testedNames.isNameValid(name);
            if (((!(this._selectedPuffle.name == name)) && (valid)))
            {
                this._selectedPuffle.name = name;
            };
            return (valid);
        }

        public function set selectedPuffle(selectedPuffle:PuffleVO):void
        {
            this._selectedPuffle = selectedPuffle;
            Signal(this.signalBus.chosenPuffleChanged).dispatch(selectedPuffle);
            this._nameSuggestions.resetSuggestionList();
        }

        public function get selectedPuffle():PuffleVO
        {
            return (this._selectedPuffle);
        }

        public function setLocalizationManager(localizationManager:ILocalizationManager):void
        {
            this._localizationManger = localizationManager;
        }

        public function getLocalizationManager():ILocalizationManager
        {
            return (this._localizationManger);
        }

        public function get playerVO():PlayerVO
        {
            return (this._playerVO);
        }

        public function set playerVO(playerVO:PlayerVO):void
        {
            this._playerVO = playerVO;
        }

        public function getPuffleName():String
        {
            return (this._selectedPuffle.name);
        }

        public function setPuffleName(newName:String):void
        {
            this._selectedPuffle.name = newName;
        }

        public function walkPuffle():void
        {
            this._puffleAdoptionService.walkPuffle(this._selectedPuffle.id);
        }

        public function requestNameSuggestion():void
        {
            var subTypeId:uint;
            if (this._nameSuggestions.length > 0)
            {
                this.dispatchNextSuggestion();
            }
            else
            {
                if (this._selectedPuffle.isWild)
                {
                    subTypeId = this._selectedPuffle.subType.id;
                }
                else
                {
                    subTypeId = 0;
                };
                this._puffleAdoptionService.requestNameSuggestion(this._selectedPuffle.type.id, subTypeId);
            };
        }

        public function handleNameSuggestions(suggestionList:String):void
        {
            this._nameSuggestions.parseAndAddSuggestions(suggestionList);
            this.dispatchNextSuggestion();
        }

        public function dispatchNextSuggestion():void
        {
            var suggestion:String = this._nameSuggestions.spliceAndReturnNextSuggestion();
            this.nameSuggestion.dispatch(suggestion);
            this.setSelectedNameAsValid(suggestion);
        }

        public function trackAdoptedByQuiz():void
        {
            this.adoptionBIModel.adoptedByQuiz++;
        }

        public function trackAdoptedWithoutQuiz():void
        {
            this.adoptionBIModel.adoptedWithoutQuiz++;
        }

        public function startSession():void
        {
            this.adoptionBIModel.startTrackingDuration();
        }

        public function endSession():void
        {
            this.adoptionBIModel.endTrackingDuration();
        }

        public function sendTracking():void
        {
            this.endSession();
            this._puffleAdoptionService.sendPuffleAdoptionBI(this.adoptionBIModel.getBIDataString());
        }

        public function set puffleAdoptType(value:String):void
        {
            this._puffleAdoptType = value;
        }

        public function get puffleAdoptType():String
        {
            return (this._puffleAdoptType);
        }

        public function set puffleAdoptionTypeId(value:Number):void
        {
            this._puffleAdoptionTypeId = value;
        }

        public function get puffleAdoptionTypeId():Number
        {
            return (this._puffleAdoptionTypeId);
        }

        public function get isSelectedPuffleMemberOnly():Boolean
        {
            return ((!((this.selectedPuffle.type == PuffleTypeEnum.RED) || (this.selectedPuffle.type == PuffleTypeEnum.BLUE))) || (this.selectedPuffle.isWild));
        }


    }
}//package com.clubpenguin.puffles.adoption.model
