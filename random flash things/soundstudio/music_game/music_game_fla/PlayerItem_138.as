//Created by Action Script Viewer - https://www.buraks.com/asv
package music_game_fla
{
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.LocalTextComponent;
    import flash.utils.Dictionary;
    import flash.display.*;
    import flash.text.*;
    import flash.filters.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.media.*;
    import flash.geom.*;
    import adobe.utils.*;
    import flash.ui.*;
    import flash.system.*;
    import flash.net.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.globalization.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.text.ime.*;
    import flash.text.engine.*;
    import flash.xml.*;

    public dynamic class PlayerItem_138 extends MovieClip 
    {

        public var errorBubble:MovieClip;//instance name
        public var checkmark:MovieClip;//instance name
        public var spinner:MovieClip;//instance name
        public var errorText:LocalTextComponent;//instance name
        public var new_mc:MovieClip;//instance name
        public var __setPropDict:Dictionary = new Dictionary(true);

        public function PlayerItem_138()
        {
            addFrameScript(0, this.frame1, 1, this.frame2, 2, this.frame3, 3, this.frame4);
        }

        internal function __setProp_errorText_PlayerItem_rejectedtext_3():*
        {
            if (((this.__setPropDict[this.errorText] == undefined) || (!(int(this.__setPropDict[this.errorText]) == 4))))
            {
                this.__setPropDict[this.errorText] = 4;
                try
                {
                    this.errorText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.errorText.currentLang = "en";
                this.errorText.debugColor = 0xCC00;
                this.errorText.enabled = true;
                this.errorText.font = "cpBurbankSmall";
                this.errorText.globalMinFontSize = 10;
                this.errorText.globalScaling = true;
                this.errorText.globalWordWrap = true;
                this.errorText.groupName = "[none]";
                this.errorText.langControl = false;
                this.errorText.ltcFilters = "";
                this.errorText.minFontSizeData = "";
                this.errorText.scalingData = "";
                this.errorText.showBounds = false;
                this.errorText.text = "#Please choose another name\n";
                this.errorText.textColor = 0;
                this.errorText.textHorizontalAlignment = "center";
                this.errorText.textSize = 11;
                this.errorText.textVerticalAlignment = "center";
                this.errorText.token = "w.app.music.game.board.prompt.choose.another.name";
                this.errorText.visible = true;
                this.errorText.wordWrapData = "";
                this.errorText.zrevision = "v2.0.8";
                try
                {
                    this.errorText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function frame1():*
        {
            stop();
        }

        internal function frame2():*
        {
            stop();
        }

        internal function frame3():*
        {
            stop();
        }

        internal function frame4():*
        {
            this.__setProp_errorText_PlayerItem_rejectedtext_3();
            stop();
        }


    }
}//package music_game_fla
