//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.CommunicationMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
    {
        var context, SHELL, communicationView, mainView, epfService, messageListMediator, communicationModel, delayedServiceCall;
        function CommunicationMediator (view, context) {
            super(view, context.appClosed, context.languageCode);
            this.context = context;
            SHELL = context.SHELL;
            communicationView = view;
            mainView = communicationView._parent;
            epfService = context.epfService;
            communicationView.setDependancies(SHELL);
            communicationView.viewOpened.add(onViewOpened, this);
            var _local_4 = communicationView.messageList;
            messageListMediator = new com.clubpenguin.scrollinglist.ScrollingList(_local_4);
            communicationModel = new com.clubpenguin.hud.phone.model.Communication();
            epfService.comMessagesReceived.add(onComMessagesReceived, this);
            epfService.newComMessageReceived.add(onNewComMessageReceived, this);
            delaySetup();
        }
        function get communication() {
            return(communicationModel);
        }
        function delaySetup() {
            _global.clearTimeout(delayedServiceCall);
            delayedServiceCall = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, delayedSetupCall), 1000);
        }
        function delayedSetupCall() {
            _global.clearTimeout(delayedServiceCall);
            epfService.getComMessages();
        }
        function onComMessagesReceived(messages, isNewMessage) {
            processMessages(messages);
            communicationView.viewOpened.add(setupMessages, this);
            setupMessages();
        }
        function onNewComMessageReceived(messages) {
            processMessages(messages);
            setupMessages();
        }
        function processMessages(messages) {
            var _local_5 = SHELL.getMascotCrumbs();
            var _local_3;
            var _local_2 = 0;
            while (_local_2 < messages.length) {
                _local_3 = messages[_local_2];
                _local_3.mascotName = _local_5.mascots[_local_3.mascotID].name;
                communicationModel.pushNewMessage(messages[_local_2]);
                _local_2++;
            }
        }
        function onViewOpened() {
            setupMessages();
            messageListMediator.refresh();
        }
        function setupMessages() {
            communicationView.clearMessages();
            communicationView.displayMessages(communicationModel.messages);
        }
    }
