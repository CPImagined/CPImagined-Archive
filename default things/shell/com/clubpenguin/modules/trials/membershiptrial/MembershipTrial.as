//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.modules.trials.membershiptrial.MembershipTrial
    {
        var SHELL, AIRTOWER, membershipEventIgnoreList, playerLoadDelegate, membershipDelegate, offerDelegate, expiredDelegate;
        function MembershipTrial (shell, airtower) {
            SHELL = shell;
            AIRTOWER = airtower;
            membershipEventIgnoreList = [com.clubpenguin.shell.events.MembershipEventContext.PLAYER_CARD, com.clubpenguin.shell.events.MembershipEventContext.SCAVENGER_HUNT];
            playerLoadDelegate = com.clubpenguin.util.Delegate.create(this, onLoadPlayerObject);
            membershipDelegate = com.clubpenguin.util.Delegate.create(this, onMembershipEvent);
            offerDelegate = com.clubpenguin.util.Delegate.create(this, onOfferResponse);
            expiredDelegate = com.clubpenguin.util.Delegate.create(this, onExpiredResponse);
            SHELL.addListener(SHELL.LOAD_PLAYER_OBJECT, playerLoadDelegate);
        }
        function onLoadPlayerObject(playerObject) {
            SHELL.removeListener(SHELL.LOAD_PLAYER_OBJECT, com.clubpenguin.util.Delegate.create(this, onLoadPlayerObject));
            SHELL.addListener(com.clubpenguin.shell.events.MembershipEvent.MEMBER_ONLY_ACTIVITY, membershipDelegate);
            if (playerObject.membershipEnum == com.clubpenguin.model.PlayerModel.PLAYER_TRIAL_MEMBER) {
                var _local_2 = new Object();
                _local_2.messageType = com.clubpenguin.modules.trials.membershiptrial.MembershipTrialConstants.MEMBERSHIP_TRIAL_ACTIVE;
                openAS3Module(_local_2);
            } else {
                AIRTOWER.addListener(com.clubpenguin.modules.trials.membershiptrial.MembershipTrialConstants.MEMBERSHIP_TRIAL_OFFER, offerDelegate);
                AIRTOWER.addListener(com.clubpenguin.modules.trials.membershiptrial.MembershipTrialConstants.MEMBERSHIP_TRIAL_EXPIRED, expiredDelegate);
            }
        }
        function onOfferResponse(serverResponse) {
            var _local_2 = new Object();
            _local_2.messageType = com.clubpenguin.modules.trials.membershiptrial.MembershipTrialConstants.MEMBERSHIP_TRIAL_OFFER;
            _local_2.daysLeft = serverResponse[1];
            openAS3Module(_local_2);
        }
        function onExpiredResponse(serverResponse) {
            var _local_2 = new Object();
            _local_2.messageType = com.clubpenguin.modules.trials.membershiptrial.MembershipTrialConstants.MEMBERSHIP_TRIAL_EXPIRED;
            _local_2.daysLeft = serverResponse[1];
            openAS3Module(_local_2);
            AIRTOWER.removeListener(com.clubpenguin.modules.trials.membershiptrial.MembershipTrialConstants.MEMBERSHIP_TRIAL_OFFER, offerDelegate);
            AIRTOWER.removeListener(com.clubpenguin.modules.trials.membershiptrial.MembershipTrialConstants.MEMBERSHIP_TRIAL_EXPIRED, expiredDelegate);
            SHELL.removeListener(com.clubpenguin.shell.events.MembershipEvent.MEMBER_ONLY_ACTIVITY, membershipDelegate);
        }
        function openAS3Module(payload) {
            SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.MEMBERSHIP_TRIAL, payload, {modalBackgroundEnabled:false, hideLoadingDialog:true, blockPuffleNotifications:true});
        }
        function onMembershipEvent(event) {
            if (!isMembershipEventIgnored(event.context)) {
                SHELL.sendDataToAS3(com.clubpenguin.model.BridgePayloadConstants.MEMBERSHIP_PAYLOAD, {action:event.action, context:event.context});
            }
        }
        function isMembershipEventIgnored(context) {
            var _local_2 = 0;
            while (_local_2 < membershipEventIgnoreList.length) {
                if (membershipEventIgnoreList[_local_2] == context) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
    }
