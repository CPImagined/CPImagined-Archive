//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.signal
{
    import com.clubpenguin.lib.module.IAppSignalBus;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.main.overlays.vo.OverlayVO;
    import flash.display.DisplayObject;
    import org.osflash.signals.ISignal;
    import com.clubpenguin.lib.vo.ErrorVO;
    import com.clubpenguin.lib.vo.UserSubmissionVO;
    import com.clubpenguin.lib.vo.BiVO;
    import com.clubpenguin.main.overlays.vo.MembershipOverlayVO;
    import com.clubpenguin.main.overlays.vo.MembershipFAQOverlayVO;

    public class SignalBus implements IAppSignalBus 
    {

        public const showPuffleCertificate:Signal = new Signal(PuffleVO);
        public const puffleCertificateClosed:Signal = new Signal();
        public const music:Signal = new Signal();
        public const loadModule:Signal = new Signal(ModuleVO);
        public const showOverlay:Signal = new Signal(OverlayVO);
        public const closeView:Signal = new Signal(DisplayObject);
        public const hideView:Signal = new Signal(DisplayObject);
        public const unhideView:Signal = new Signal(DisplayObject);
        public const showError:ISignal = new Signal(ErrorVO);
        public const showLoadingDialog:Signal = new Signal();
        public const hideLoadingDialog:Signal = new Signal();
        public const updateLoadingDialog:Signal = new Signal(Number);
        public const sendUserSubmission:Signal = new Signal(UserSubmissionVO);
        public const sendBI:Signal = new Signal(BiVO);
        public const unloadAs2World:Signal = new Signal();
        public const cleanupClient:Signal = new Signal();
        public const moduleLoaded:ISignal = new Signal(DisplayObject);
        public const autoLogin:Signal = new Signal();
        public const loadMembershipPrompt:Signal = new Signal(String, Object);
        public const loadMembershipPufflePrompt:Signal = new Signal(String, Object);
        public const showMembershipPrompt:Signal = new Signal(MembershipOverlayVO);
        public const showMembershipPufflePrompt:Signal = new Signal(MembershipOverlayVO);
        public const loadMembershipFAQ:Signal = new Signal(String, Object);
        public const showMembershipFAQ:Signal = new Signal(MembershipFAQOverlayVO);
        public const onIntroToCP:Signal = new Signal();
        public const joinedWorld:Signal = new Signal();
        public const leavingRoom:Signal = new Signal();
        public const worldDataReceived:Signal = new Signal(Object);
        public const currentWorldRecevied:Signal = new Signal(Object);
        public const idlePlayerTimeout:Signal = new Signal();
        public const showCards:Signal = new Signal();
        public const logDimgBiEvent:Signal = new Signal(Object);
        public const logRawBiEvent:Signal = new Signal(Object);
        public const setPlayerStatus:Signal = new Signal(Object);
        public const logOffCleanupComplete:Signal = new Signal();
        public const startTracker:Signal = new Signal();
        public const trackerEvent:Signal = new Signal(Object, String);
        public const likeModuleLoaded:Signal = new Signal();
        public const bridgeError:Signal = new Signal(ErrorVO);
        public const syncPlayerData:Signal = new Signal(Object);
        public const videoComplete:Signal = new Signal();
        public const closePopups:Signal = new Signal();
        public const showPartyLogin:Signal = new Signal();
        public const highlightPuffle:Signal = new Signal(PuffleVO);


        public function getPuffleCertificateClosed():ISignal
        {
            return (this.puffleCertificateClosed);
        }

        public function getSendBI():ISignal
        {
            return (this.sendBI);
        }

        public function getCloseView():ISignal
        {
            return (this.closeView);
        }

        public function getSendUserSubmission():ISignal
        {
            return (this.sendUserSubmission);
        }

        public function getHideLoading():ISignal
        {
            return (this.hideLoadingDialog);
        }

        public function getShowLoading():ISignal
        {
            return (this.showLoadingDialog);
        }

        public function getShowOverlay():ISignal
        {
            return (this.showOverlay);
        }

        public function getLoadModule():ISignal
        {
            return (this.loadModule);
        }

        public function getShowModule():ISignal
        {
            return (this.showOverlay);
        }

        public function getUnloadAs2World():ISignal
        {
            return (this.unloadAs2World);
        }

        public function getShowError():ISignal
        {
            return (this.showError);
        }

        public function getLeavingRoom():ISignal
        {
            return (this.leavingRoom);
        }

        public function getLoadMembershipPrompt():ISignal
        {
            return (this.loadMembershipPrompt);
        }

        public function getShowCards():ISignal
        {
            return (this.showCards);
        }

        public function getLogDimgBiEvent():ISignal
        {
            return (this.logDimgBiEvent);
        }

        public function getLogRawBiEvent():ISignal
        {
            return (this.logRawBiEvent);
        }

        public function getWorldDataReceived():ISignal
        {
            return (this.worldDataReceived);
        }

        public function getCurrentWorldReceived():ISignal
        {
            return (this.currentWorldRecevied);
        }

        public function getSetPlayerStatus():ISignal
        {
            return (this.setPlayerStatus);
        }

        public function getLogOffCleanupComplete():ISignal
        {
            return (this.logOffCleanupComplete);
        }

        public function getStartTracker():ISignal
        {
            return (this.startTracker);
        }

        public function getTrackerEvent():ISignal
        {
            return (this.trackerEvent);
        }

        public function getLikeModuleLoaded():ISignal
        {
            return (this.likeModuleLoaded);
        }

        public function getBridgeError():ISignal
        {
            return (this.bridgeError);
        }

        public function getSyncPlayerData():ISignal
        {
            return (this.syncPlayerData);
        }

        public function getVideoComplete():ISignal
        {
            return (this.videoComplete);
        }

        public function getClosePopups():ISignal
        {
            return (this.closePopups);
        }

        public function getShowPartyLogin():ISignal
        {
            return (this.showPartyLogin);
        }

        public function getUpdateLoadingDialog():ISignal
        {
            return (this.updateLoadingDialog);
        }


    }
}//package com.clubpenguin.main.signal
