//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.MissionMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
    {
        var context, currentRoomService, roomCrumbs;
        function MissionMediator (view, context) {
            super(view, context.appClosed, context.languageCode);
            view.goThere.onPress = com.clubpenguin.util.Delegate.create(this, onGoTherePressed);
            this.context = context;
            currentRoomService = context.currentRoomService;
            roomCrumbs = context.roomCrumbs;
        }
        function onGoTherePressed() {
            if (context.isUserCurrentlyInRoom(roomCrumbs[com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_KEY].room_id)) {
            } else {
                currentRoomService.joinRoom(roomCrumbs[com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_KEY].room_id, com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_SPAWN_X, com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_SPAWN_Y);
            }
        }
    }
