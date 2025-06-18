dynamic class com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound
{
    var attachRef;
    var playForRemoteClients;
    var soundLinkage;

    function HotelCareSound(soundLinkage, attachRef, playForRemoteClients)
    {
        this.soundLinkage = soundLinkage;
        this.attachRef = attachRef;
        this.playForRemoteClients = playForRemoteClients == undefined ? true : playForRemoteClients;
    }

}
