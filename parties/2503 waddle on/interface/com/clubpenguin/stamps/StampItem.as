//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampItem implements com.clubpenguin.stamps.IStampItem
    {
        var id, mainCategoryID, difficulty, name, description, isMemberItem;
        function StampItem (id, mainCategoryID, difficulty, name, description, isMemberItem) {
            this.id = id;
            this.mainCategoryID = mainCategoryID;
            this.difficulty = difficulty;
            this.name = name;
            this.description = description;
            this.isMemberItem = isMemberItem;
        }
        function getMainCategoryID() {
            return(mainCategoryID);
        }
        function setMainCategoryID(id) {
            mainCategoryID = id;
        }
        function getType() {
            return(com.clubpenguin.stamps.StampBookItemType.STAMP);
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
        function getDifficulty() {
            return(difficulty);
        }
        function setDifficulty(difficulty) {
            this.difficulty = difficulty;
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
