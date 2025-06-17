class com.clubpenguin.engine.puffletreasure.PuffleTreasureContext
{
    var _puffleTreasureHuntService, _puffleTreasureDigMediator, _digSearchEmoteManager;
    function PuffleTreasureContext(puffleTreasureHuntService)
    {
        _puffleTreasureHuntService = puffleTreasureHuntService;
        _puffleTreasureDigMediator = new com.clubpenguin.engine.puffletreasure.mediator.PuffleTreasureDigMediator(_puffleTreasureHuntService.treasureFound);
        _digSearchEmoteManager = new com.clubpenguin.engine.puffles.emote.manager.DigSearchEmoteManager();
    } // End of the function
    function destroy()
    {
        _puffleTreasureDigMediator.destroy();
    } // End of the function
    function getDigSearchEmoteManager()
    {
        return (_digSearchEmoteManager);
    } // End of the function
} // End of Class
