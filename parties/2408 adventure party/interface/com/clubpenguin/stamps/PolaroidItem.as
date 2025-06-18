//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.PolaroidItem implements com.clubpenguin.stamps.IPolaroidItem
    {
        var id, numStampsToUnlock, name, description;
        function PolaroidItem (id, numStampsToUnlock, name, description) {
            this.id = id;
            this.numStampsToUnlock = numStampsToUnlock;
            this.name = name;
            this.description = description;
        }
        function getType() {
            return(com.clubpenguin.stamps.StampBookItemType.POLAROID);
        }
        function getID() {
            return(id);
        }
        function setID(id) {
            this.id = id;
        }
        function getNumStampsToUnlock() {
            return(numStampsToUnlock);
        }
        function setNumStampsToUnlock(numStampsToUnlock) {
            this.numStampsToUnlock = numStampsToUnlock;
        }
        function getName() {
            return(name);
        }
        function setName(name) {
            this.name = name;
        }
        function getDescription() {
            return(description);
        }
        function setDescription(description) {
            this.description = description;
        }
        function getIsMemberItem() {
            return(false);
        }
        function setIsMemberItem(isMemberItem) {
        }
    }
