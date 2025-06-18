//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.AgentStatusView extends com.clubpenguin.hud.phone.view.AppView
    {
        var localizedAssets, fieldOpStatus, agentStatusTitle, itemExists, insufficientPoints, itemConfirmation, instructions, itemsList, itemsList2, itemsList3, itemsList4, itemsList5, layout, radarAnimation, fieldOpIconAnimation, _visible;
        function AgentStatusView () {
            super();
            localizedAssets = [fieldOpStatus, agentStatusTitle, itemExists.itemExistsText, insufficientPoints.insufficientPointsText, itemConfirmation.itemConfirmationText, instructions.instructionsText, itemsList.content, itemsList2.content, itemsList3.content, itemsList4.content, itemsList5.content, itemsList.content.badge1.member, itemsList.content.badge2.member, itemsList2.content.badge1.member, itemsList2.content.badge2.member, itemsList3.content.badge.member, itemsList4.content.badge.member, itemsList5.content.badge.member];
            layout = com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE_LARGE;
        }
        function open() {
            radarAnimation.gotoAndPlay(2);
            fieldOpIconAnimation.gotoAndPlay(2);
            _visible = true;
        }
        function close() {
            radarAnimation.gotoAndStop(1);
            fieldOpIconAnimation.gotoAndStop(1);
            _visible = false;
        }
    }
