//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.PinItem implements com.clubpenguin.stamps.IStampBookItem
    {
        var id, name, description, isMemberItem;
        function PinItem (id, name, description, isMemberItem) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.isMemberItem = isMemberItem;
        }
        function getType() {
            return(com.clubpenguin.stamps.StampBookItemType.PIN);
        }
        function getID() {
            return(id);
        }
        function setID(id) {
            this.id = id;
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
            return(isMemberItem);
        }
        function setIsMemberItem(isMemberItem) {
            this.isMemberItem = isMemberItem;
        }
    }
