dynamic class com.clubpenguin.shell.PuffleModel
{
    var id: Number = -1;
    var typeID: Number = -1;
    var subTypeID: Number = -1;
    var name: String = "";
    var _puffleState: Number = 0;
    var color;
    var hat;
    var mood;
    var stats;

    function PuffleModel()
    {
        this.mood = new com.clubpenguin.shell.PuffleMoodVO();
        this.hat = new com.clubpenguin.shell.puffle.PuffleHatVO();
        this.stats = new com.clubpenguin.shell.PuffleStatsVO();
    }

    function hasHat()
    {
        return this.hat.hatType == com.clubpenguin.shell.puffle.PuffleHatEnum.ACTUAL_HAT ? true : false;
    }

    function updateStats()
    {
        trace("Update stats");
    }

    function updatePuffleState(puffleState)
    {
        this._puffleState = puffleState;
    }

    function getPuffleState()
    {
        return this._puffleState;
    }

    function getFormattedAssetURL(assetURL)
    {
        return com.clubpenguin.shell.PuffleModel.formatAssetURL(assetURL, this.color, this.subTypeID);
    }

    function isWildPuffle()
    {
        return this.subTypeID != null && this.subTypeID != undefined && this.subTypeID != -1 && !isNaN(this.subTypeID);
    }

    static function formatAssetURL(assetURL, puffleColor, puffleSubTypeID)
    {
        var __reg2 = isNaN(puffleSubTypeID) || puffleSubTypeID == 0 ? "" : String(puffleSubTypeID);
        assetURL = com.clubpenguin.util.StringUtils.replaceString("%color%", String(puffleColor), assetURL);
        assetURL = com.clubpenguin.util.StringUtils.replaceString("%wildTypeId%", String(__reg2), assetURL);
        return assetURL;
    }

}
