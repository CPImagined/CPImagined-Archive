//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.FieldOpObjectiveView extends com.clubpenguin.hud.phone.view.AppView
    {
        var initButtons, closeButton, appHolder, closed, memberVictory, mask, victoryButtonsText, agentStatus, portrait, titleBar, medalEarned, totalMedalsEarned, mascotMessage, messageBubbleView, localizedAssets, _visible, gameHolder;
        function FieldOpObjectiveView () {
            super();
            initButtons = new org.osflash.signals.Signal();
            closeButton = appHolder.closeButton;
            closeButton.onRelease = com.clubpenguin.util.Delegate.create(closed, closed.dispatch);
            memberVictory = appHolder.memberVictory;
            mask = appHolder.mask;
            victoryButtonsText = appHolder.victoryButtonsText;
            agentStatus = appHolder.agentStatus;
            portrait = appHolder.portrait;
            titleBar = appHolder.title_bar_txt;
            medalEarned = appHolder.medal_earned_txt;
            totalMedalsEarned = appHolder.total_medals_earned_txt;
            mascotMessage = appHolder.message_bubble.content.message_txt;
            messageBubbleView = appHolder.message_bubble;
            localizedAssets = [memberVictory.text, victoryButtonsText, appHolder.medal_total];
            mask._visible = false;
            victoryButtonsText._visible = false;
            agentStatus._visible = false;
            closeButton._visible = false;
        }
        function open() {
            _visible = true;
        }
        function close() {
            deleteObjectiveMovie();
            _visible = false;
        }
        function deleteObjectiveMovie() {
            if (gameHolder) {
                MovieClip(gameHolder).destroy();
                MovieClip(gameHolder).removeMovieClip();
            }
        }
        function setupPortrait(imageFrame, name, title) {
            portrait.image.gotoAndStop("id_" + imageFrame);
            portrait.name.text = name;
            portrait.title.text = (((title != null) || (title != undefined)) ? (title) : "");
        }
        function showMemberVictory(totalMedals) {
            totalMedalsEarned.text = String(totalMedals);
        }
    }
