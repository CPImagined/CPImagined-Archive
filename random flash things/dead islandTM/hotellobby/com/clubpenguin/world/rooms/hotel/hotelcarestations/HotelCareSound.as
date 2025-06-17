//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound
    {
        var soundLinkage, attachRef, playForRemoteClients;
        function HotelCareSound (soundLinkage, attachRef, playForRemoteClients) {
            this.soundLinkage = soundLinkage;
            this.attachRef = attachRef;
            this.playForRemoteClients = ((playForRemoteClients == undefined) ? true : (playForRemoteClients));
        }
    }
