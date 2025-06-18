dynamic class com.clubpenguin.shell.puffle.PuffleHatVO
{
    static var HAT_DATA_DELIMITER: String = "@";
    static var EMPTY_HAT_ID: Number = 0;
    static var HAT: String = "_hat";
    static var FRONT: String = "_front";
    static var BACK: String = "_back";
    static var SWF: String = ".swf";
    var assetLinkage;
    var hatBackAsset;
    var hatFrontAsset;
    var hatType;
    var id;
    var label;
    var name;

    function PuffleHatVO()
    {
    }

    function getAS2AssetPath()
    {
        var __reg2 = this.assetLinkage.indexOf("/") + 1;
        var __reg4 = this.assetLinkage.indexOf(".");
        var __reg3 = this.assetLinkage.substring(__reg2, __reg4);
        return __reg3;
    }

    function setHatFrontAsset()
    {
        var __reg2 = this.getAS2AssetPath() + com.clubpenguin.shell.puffle.PuffleHatVO.HAT + com.clubpenguin.shell.puffle.PuffleHatVO.FRONT;
        __reg2 = __reg2.toLowerCase();
        __reg2 = __reg2 + com.clubpenguin.shell.puffle.PuffleHatVO.SWF;
        this.hatFrontAsset = __reg2;
    }

    function setHatBackAsset()
    {
        var __reg2 = this.getAS2AssetPath() + com.clubpenguin.shell.puffle.PuffleHatVO.HAT + com.clubpenguin.shell.puffle.PuffleHatVO.BACK;
        __reg2 = __reg2.toLowerCase();
        __reg2 = __reg2 + com.clubpenguin.shell.puffle.PuffleHatVO.SWF;
        this.hatBackAsset = __reg2;
    }

    static function getEmptyHatVO()
    {
        var __reg1 = new com.clubpenguin.shell.puffle.PuffleHatVO();
        __reg1.id = com.clubpenguin.shell.puffle.PuffleHatVO.EMPTY_HAT_ID;
        __reg1.name = "";
        __reg1.label = "";
        __reg1.assetLinkage = "";
        __reg1.hatType = com.clubpenguin.shell.puffle.PuffleHatEnum.EMPTY_HAT;
        return __reg1;
    }

    function outputHatVO()
    {
        trace("\n");
        trace("**********************************************************************");
        trace("**********************************************************************");
        trace("outputHatVO");
        trace("id: " + this.id);
        trace("name: " + this.name);
        trace("label: " + this.label);
        trace("assetLinkage: " + this.assetLinkage);
        trace("hatType: " + this.hatType.__get__name());
        trace("**********************************************************************");
        trace("**********************************************************************");
    }

}
