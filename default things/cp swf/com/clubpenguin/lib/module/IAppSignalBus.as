//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.module
{
    import org.osflash.signals.ISignal;

    public interface IAppSignalBus 
    {

        function getLoadModule():ISignal;
        function getCloseView():ISignal;
        function getShowLoading():ISignal;
        function getHideLoading():ISignal;
        function getShowOverlay():ISignal;
        function getSendUserSubmission():ISignal;
        function getSendBI():ISignal;
        function getUnloadAs2World():ISignal;
        function getShowError():ISignal;
        function getLoadMembershipPrompt():ISignal;
        function getLeavingRoom():ISignal;
        function getShowCards():ISignal;
        function getWorldDataReceived():ISignal;
        function getCurrentWorldReceived():ISignal;
        function getLogDimgBiEvent():ISignal;
        function getLogRawBiEvent():ISignal;
        function getSetPlayerStatus():ISignal;
        function getLogOffCleanupComplete():ISignal;
        function getStartTracker():ISignal;
        function getTrackerEvent():ISignal;
        function getLikeModuleLoaded():ISignal;
        function getBridgeError():ISignal;
        function getSyncPlayerData():ISignal;
        function getVideoComplete():ISignal;
        function getPuffleCertificateClosed():ISignal;
        function getClosePopups():ISignal;
        function getUpdateLoadingDialog():ISignal;

    }
}//package com.clubpenguin.lib.module
