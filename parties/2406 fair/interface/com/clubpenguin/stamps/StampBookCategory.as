//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampBookCategory implements com.clubpenguin.stamps.IStampBookCategory
    {
        var id, name, subCategories, stampBookItems, polaroids;
        function StampBookCategory (id, name, subCategories, stampBookItems, polaroids) {
            this.id = id;
            this.name = name;
            this.subCategories = subCategories;
            this.stampBookItems = stampBookItems;
            this.polaroids = polaroids;
        }
        function destroy() {
            var _local_3 = subCategories.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                subCategories[_local_2].destroy();
                _local_2++;
            }
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
        function getSubCategories() {
            return(subCategories);
        }
        function setSubCategories(subCategories) {
            this.subCategories = subCategories;
        }
        function addSubCategory(subCategory) {
            if (subCategories == undefined) {
                subCategories = [];
            }
            subCategories.push(subCategory);
        }
        function getItems() {
            return(stampBookItems);
        }
        function setItems(stampBookItems) {
            this.stampBookItems = stampBookItems;
        }
        function getPolaroids() {
            return(polaroids);
        }
        function setPolaroids(polaroids) {
            this.polaroids = polaroids;
        }
    }
