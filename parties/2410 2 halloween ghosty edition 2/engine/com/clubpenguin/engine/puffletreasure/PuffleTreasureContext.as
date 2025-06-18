//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffletreasure.PuffleTreasureContext
    {
        var _puffleTreasureHuntService, _puffleTreasureDigMediator, _digSearchEmoteManager;
        function PuffleTreasureContext (puffleTreasureHuntService) {
            _puffleTreasureHuntService = puffleTreasureHuntService;
            _puffleTreasureDigMediator = new com.clubpenguin.engine.puffletreasure.mediator.PuffleTreasureDigMediator(_puffleTreasureHuntService.treasureFound);
            _digSearchEmoteManager = new com.clubpenguin.engine.puffles.emote.manager.DigSearchEmoteManager();
        }
        function destroy() {
            _puffleTreasureDigMediator.destroy();
        }
        function getDigSearchEmoteManager() {
            return(_digSearchEmoteManager);
        }
    }
