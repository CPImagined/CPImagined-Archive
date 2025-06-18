//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.vo.IglooMapPlayerVO implements com.clubpenguin.util.IVO
    {
        var _uniqueVOid, isLocalPlayer, isBestFriend, isOpenListFriend, isFriend, swid, playerID, totalLikes, population, isIglooLocked, name;
        function IglooMapPlayerVO (uniqueVOid) {
            _uniqueVOid = uniqueVOid;
            isLocalPlayer = false;
            isBestFriend = false;
            isOpenListFriend = false;
            isFriend = false;
            swid = "{324324-543252435-432523454532-435253}";
            playerID = "-1";
            totalLikes = 0;
            population = 0;
            isIglooLocked = false;
        }
        function destroy() {
        }
        function getID() {
            return(_uniqueVOid);
        }
        function setID(uniqueVOid) {
            _uniqueVOid = uniqueVOid;
        }
        function update(vo) {
            var _local_2 = com.clubpenguin.world.rooms2013.halloween.iglooMap.vo.IglooMapPlayerVO(vo);
            isBestFriend = _local_2.isBestFriend;
            isFriend = _local_2.isFriend;
            isOpenListFriend = _local_2.isOpenListFriend;
            name = _local_2.name;
            swid = _local_2.swid;
            playerID = _local_2.playerID;
            totalLikes = _local_2.totalLikes;
            population = _local_2.population;
            isIglooLocked = _local_2.isIglooLocked;
        }
        function toString() {
            return((("[IglooMapPlayerVO] " + name) + " - ") + _uniqueVOid);
        }
        function equals(vo) {
            return(getID() == vo.getID());
        }
    }
