//Created by Action Script Viewer - https://www.buraks.com/asv
package CardJitsuProgressInventoryAssets_fla
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

    public dynamic class ProgressBar_104 extends MovieClip 
    {

        public var pctBar:MovieClip;//instance name
        public var percent:LocalTextComponent;//instance name

        public function ProgressBar_104()
        {
            addFrameScript(0, this.frame1);
            this.__setProp_percent_ProgressBar_Text_0();
        }

        internal function __setProp_percent_ProgressBar_Text_0():*
        {
            try
            {
                this.percent["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.percent.currentLang = "en";
            this.percent.debugColor = 0xCC00;
            this.percent.enabled = true;
            this.percent.font = "cpBurbankSmallBold";
            this.percent.globalMinFontSize = 8;
            this.percent.globalScaling = true;
            this.percent.globalWordWrap = true;
            this.percent.groupName = "[none]";
            this.percent.textHorizontalAlignment = "left";
            this.percent.langControl = false;
            this.percent.ltcFilters = "";
            this.percent.minFontSizeData = "";
            this.percent.scalingData = "";
            this.percent.showBounds = false;
            this.percent.textSize = 8;
            this.percent.text = "-100%";
            this.percent.textColor = 0;
            this.percent.token = "";
            this.percent.textVerticalAlignment = "top";
            this.percent.visible = true;
            this.percent.wordWrapData = "";
            this.percent.zrevision = "v2.0.6";
            try
            {
                this.percent["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }

        internal function frame1():*
        {
            stop();
        }


    }
}//package CardJitsuProgressInventoryAssets_fla
