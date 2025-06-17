//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.party.MayParty_ShellOverrides
    {
        var defaultHandleBuyInventory;
        function MayParty_ShellOverrides () {
        }
        function init() {
            defaultHandleBuyInventory = _global.getCurrentShell().handleBuyInventory;
        }
        function handleBuyInventory(obj) {
            trace("[SHELL] MayParty_ShellOverrides::handleBuyInventory() -> obj: " + obj);
        }
        static var CLASS_NAME = "MayParty_ShellOverrides";
    }
