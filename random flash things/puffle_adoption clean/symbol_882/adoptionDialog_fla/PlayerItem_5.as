//Created by Action Script Viewer - https://www.buraks.com/asv
package adoptionDialog_fla
{
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.LocalTextComponent;
    import flash.display.*;
    import flash.text.*;
    import flash.filters.*;
    import flash.utils.*;
    import flash.events.*;
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
    import flash.media.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.text.ime.*;
    import flash.text.engine.*;
    import flash.xml.*;

    public dynamic class PlayerItem_5 extends MovieClip 
    {

        public var errorBubble:MovieClip;//instance name
        public var checkmark:MovieClip;//instance name
        public var spinner:MovieClip;//instance name
        public var defaultText:LocalTextComponent;//instance name
        public var errorText:LocalTextComponent;//instance name
        public var new_mc:MovieClip;//instance name

        public function PlayerItem_5()
        {
            addFrameScript(0, this.frame1, 1, this.frame2, 2, this.frame3, 3, this.frame4);
            this.__setProp_defaultText_PlayerItem_defaulttext_0();
            this.__setProp_errorText_PlayerItem_rejectedtext_0();
        }

        internal function __setProp_defaultText_PlayerItem_defaulttext_0():*
        {
            try
            {
                this.defaultText["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.defaultText.currentLang = "en";
            this.defaultText.debugColor = 0xCC00;
            this.defaultText.enabled = true;
            this.defaultText.font = "cpBurbankSmallBold";
            this.defaultText.globalMinFontSize = 8;
            this.defaultText.globalScaling = true;
            this.defaultText.globalWordWrap = false;
            this.defaultText.groupName = "[none]";
            this.defaultText.langControl = false;
            this.defaultText.ltcFilters = "";
            this.defaultText.minFontSizeData = "";
            this.defaultText.scalingData = "";
            this.defaultText.showBounds = false;
            this.defaultText.text = "#Name puffle";
            this.defaultText.textColor = 9277340;
            this.defaultText.textHorizontalAlignment = "left";
            this.defaultText.textSize = 15;
            this.defaultText.textVerticalAlignment = "center";
            this.defaultText.token = "";
            this.defaultText.visible = true;
            this.defaultText.wordWrapData = "";
            this.defaultText.zrevision = "v2.0.8";
            try
            {
                this.defaultText["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }

        internal function __setProp_errorText_PlayerItem_rejectedtext_0():*
        {
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
            this.errorText.token = "";
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
            stop();
        }


    }
}//package adoptionDialog_fla
