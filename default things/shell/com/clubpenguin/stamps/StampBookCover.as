//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampBookCover implements com.clubpenguin.stamps.IStampBookCover
    {
        var coverItems, colourID, highlightID, patternID, claspIconArtID;
        function StampBookCover (coverItems, colourID, highlightID, patternID, claspIconArtID) {
            this.coverItems = coverItems;
            this.colourID = colourID;
            this.highlightID = highlightID;
            this.patternID = patternID;
            this.claspIconArtID = claspIconArtID;
        }
        function getColourID() {
            return(colourID);
        }
        function setColourID(id) {
            colourID = id;
        }
        function getHighlightID() {
            return(highlightID);
        }
        function setHighlightID(id) {
            highlightID = id;
        }
        function getPatternID() {
            return(patternID);
        }
        function setPatternID(id) {
            patternID = id;
        }
        function getClaspIconArtID() {
            return(claspIconArtID);
        }
        function setClaspIconArtID(id) {
            claspIconArtID = id;
        }
        function getCoverItems() {
            return(coverItems);
        }
        function setCoverItems(coverItems) {
            this.coverItems = coverItems;
        }
    }
