
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.common.CloseContentButton extends Button
    {
        var onRelease;
        function CloseContentButton () {
            super();
            onRelease = com.clubpenguin.util.Delegate.create(this, closeContent);
        }
        function closeContent() {
            _global.getCurrentInterface().closeContent();
        }
    }
