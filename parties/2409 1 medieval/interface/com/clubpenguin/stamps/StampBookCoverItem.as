//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampBookCoverItem implements com.clubpenguin.stamps.IStampBookCoverItem
    {
        var item, position, rotation, depth;
        function StampBookCoverItem (item, position, rotation, depth) {
            this.item = item;
            this.position = position;
            this.rotation = rotation;
            this.depth = depth;
        }
        function getItem() {
            return(item);
        }
        function setItem(item) {
            this.item = item;
        }
        function getItemPosition() {
            return(position);
        }
        function setItemPosition(position) {
            this.position = position;
        }
        function getItemRotation() {
            return(rotation);
        }
        function setItemRotation(rotation) {
            this.rotation = rotation;
        }
        function getItemDepth() {
            return(depth);
        }
        function setItemDepth(depth) {
            this.depth = depth;
        }
    }
