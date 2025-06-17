//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.map.vo.MapBITrackingVO
    {
        var mapOpenDuration, categoryID, mapLabel, categoryCounts, closeTime, roomID, shouldIgnoreNextTrackingCall;
        function MapBITrackingVO () {
            mapOpenDuration = 0;
            categoryID = 0;
            mapLabel = "";
            categoryCounts = new Array(0, 0, 0, 0);
            closeTime = 0;
            roomID = 0;
            shouldIgnoreNextTrackingCall = false;
        }
        function get categoryLabel() {
            return(_catLabelList[categoryID]);
        }
        function trackCategorySelection(catid) {
            if (catid > 0) {
                categoryCounts[catid - 1]++;
            }
        }
        function getCategoryCountString() {
            return((((((("games:" + categoryCounts[0]) + "|shopping:") + categoryCounts[1]) + "|pets:") + categoryCounts[2]) + "|places:") + categoryCounts[3]);
        }
        function toString() {
            return((((((("[MapBITrackingVO] mapOpenDuration: " + mapOpenDuration) + "  categoryID: ") + categoryID) + "  mapLabel: ") + mapLabel) + "  categoryCount: ") + categoryCounts);
        }
        var _catLabelList = ["default", "games", "shopping", "pets", "places"];
    }
