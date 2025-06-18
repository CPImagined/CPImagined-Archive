//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.RoomButtonMediator
    {
        var view, teleportRoom, _pressed;
        function RoomButtonMediator (view, teleportRoom) {
            this.view = view;
            this.teleportRoom = teleportRoom;
            _pressed = new org.osflash.signals.Signal(com.clubpenguin.hud.phone.model.TeleportRoom);
            view.onPress = com.clubpenguin.util.Delegate.create(this, onMouseUp);
            view.name.text = teleportRoom.localizedName;
        }
        function get pressed() {
            return(_pressed);
        }
        function onMouseUp() {
            _pressed.dispatch(teleportRoom);
        }
    }
