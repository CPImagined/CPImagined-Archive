﻿//Created by Action Script Viewer - https://www.buraks.com/asv
package CardJitsuProgressInventoryAssets_fla
{
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.LocalTextComponent;
    import com.clubpenguin.cardjitsu.ninjaprogress.ScrollPain;
    import flash.utils.Dictionary;
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

    public dynamic class progressWindowSnow_145 extends MovieClip 
    {

        public var bodyText:LocalTextComponent;//instance name
        public var cornerFlipBtn:MovieClip;//instance name
        public var scrollPane:ScrollPain;//instance name
        public var intro_door_snow:MovieClip;//instance name
        public var progressItem:MovieClip;//instance name
        public var progressBar:MovieClip;//instance name
        public var logoClip:MovieClip;//instance name
        public var goBackBtn:MovieClip;//instance name
        public var progressItems:MovieClip;//instance name
        public var myProgressBtn:MovieClip;//instance name
        public var progressText:LocalTextComponent;//instance name
        public var __setPropDict:Dictionary = new Dictionary(true);

        public function progressWindowSnow_145()
        {
            addFrameScript(0, this.frame1, 1, this.frame2, 2, this.frame3, 3, this.frame4);
        }

        internal function __setProp_bodyText_progressWindowSnow_Bodytext_0():*
        {
            if (((this.__setPropDict[this.bodyText] == undefined) || (!(int(this.__setPropDict[this.bodyText]) == 1))))
            {
                this.__setPropDict[this.bodyText] = 1;
                try
                {
                    this.bodyText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.bodyText.currentLang = "en";
                this.bodyText.debugColor = 0xCC00;
                this.bodyText.enabled = true;
                this.bodyText.font = "cpBurbankSmall";
                this.bodyText.globalMinFontSize = 8;
                this.bodyText.globalScaling = true;
                this.bodyText.globalWordWrap = true;
                this.bodyText.groupName = "[none]";
                this.bodyText.textHorizontalAlignment = "center";
                this.bodyText.langControl = false;
                this.bodyText.ltcFilters = "";
                this.bodyText.minFontSizeData = "";
                this.bodyText.scalingData = "";
                this.bodyText.showBounds = false;
                this.bodyText.textSize = 12;
                this.bodyText.text = "Become a Snow Ninja";
                this.bodyText.textColor = 2361859;
                this.bodyText.token = "";
                this.bodyText.textVerticalAlignment = "top";
                this.bodyText.visible = true;
                this.bodyText.wordWrapData = "";
                this.bodyText.zrevision = "v2.0.6";
                try
                {
                    this.bodyText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_progressText_progressWindowSnow_progressText_1():*
        {
            if (((this.__setPropDict[this.progressText] == undefined) || (!(int(this.__setPropDict[this.progressText]) == 2))))
            {
                this.__setPropDict[this.progressText] = 2;
                try
                {
                    this.progressText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.progressText.currentLang = "en";
                this.progressText.debugColor = 0xCC00;
                this.progressText.enabled = true;
                this.progressText.font = "cpBurbankSmall";
                this.progressText.globalMinFontSize = 8;
                this.progressText.globalScaling = true;
                this.progressText.globalWordWrap = true;
                this.progressText.groupName = "[none]";
                this.progressText.textHorizontalAlignment = "center";
                this.progressText.langControl = false;
                this.progressText.ltcFilters = "";
                this.progressText.minFontSizeData = "";
                this.progressText.scalingData = "";
                this.progressText.showBounds = false;
                this.progressText.textSize = 14;
                this.progressText.text = "24/20";
                this.progressText.textColor = 2361859;
                this.progressText.token = "";
                this.progressText.textVerticalAlignment = "top";
                this.progressText.visible = true;
                this.progressText.wordWrapData = "";
                this.progressText.zrevision = "v2.0.6";
                try
                {
                    this.progressText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_bodyText_progressWindowSnow_title_1():*
        {
            if (((this.__setPropDict[this.bodyText] == undefined) || (!(int(this.__setPropDict[this.bodyText]) == 2))))
            {
                this.__setPropDict[this.bodyText] = 2;
                try
                {
                    this.bodyText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.bodyText.currentLang = "en";
                this.bodyText.debugColor = 0xCC00;
                this.bodyText.enabled = true;
                this.bodyText.font = "Candombe Cyr";
                this.bodyText.globalMinFontSize = 8;
                this.bodyText.globalScaling = true;
                this.bodyText.globalWordWrap = true;
                this.bodyText.groupName = "[none]";
                this.bodyText.textHorizontalAlignment = "center";
                this.bodyText.langControl = false;
                this.bodyText.ltcFilters = "";
                this.bodyText.minFontSizeData = "";
                this.bodyText.scalingData = "";
                this.bodyText.showBounds = false;
                this.bodyText.textSize = 20;
                this.bodyText.text = "Next Rewrd";
                this.bodyText.textColor = 2361859;
                this.bodyText.token = "";
                this.bodyText.textVerticalAlignment = "top";
                this.bodyText.visible = true;
                this.bodyText.wordWrapData = "";
                this.bodyText.zrevision = "v2.0.6";
                try
                {
                    this.bodyText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_bodyText_progressWindowSnow_Bodytext_2():*
        {
            if (((this.__setPropDict[this.bodyText] == undefined) || (!(int(this.__setPropDict[this.bodyText]) == 3))))
            {
                this.__setPropDict[this.bodyText] = 3;
                try
                {
                    this.bodyText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.bodyText.currentLang = "en";
                this.bodyText.debugColor = 0xCC00;
                this.bodyText.enabled = true;
                this.bodyText.font = "Candombe Cyr";
                this.bodyText.globalMinFontSize = 8;
                this.bodyText.globalScaling = true;
                this.bodyText.globalWordWrap = true;
                this.bodyText.groupName = "[none]";
                this.bodyText.textHorizontalAlignment = "center";
                this.bodyText.langControl = false;
                this.bodyText.ltcFilters = "";
                this.bodyText.minFontSizeData = "";
                this.bodyText.scalingData = "";
                this.bodyText.showBounds = false;
                this.bodyText.textSize = 28;
                this.bodyText.text = "Snow Ninja";
                this.bodyText.textColor = 2361859;
                this.bodyText.token = "";
                this.bodyText.textVerticalAlignment = "top";
                this.bodyText.visible = true;
                this.bodyText.wordWrapData = "";
                this.bodyText.zrevision = "v2.0.6";
                try
                {
                    this.bodyText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_progressText_progressWindowSnow_progressText_3():*
        {
            if (((this.__setPropDict[this.progressText] == undefined) || (!(int(this.__setPropDict[this.progressText]) == 4))))
            {
                this.__setPropDict[this.progressText] = 4;
                try
                {
                    this.progressText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.progressText.currentLang = "en";
                this.progressText.debugColor = 0xCC00;
                this.progressText.enabled = true;
                this.progressText.font = "cpBurbankSmall";
                this.progressText.globalMinFontSize = 8;
                this.progressText.globalScaling = true;
                this.progressText.globalWordWrap = true;
                this.progressText.groupName = "[none]";
                this.progressText.textHorizontalAlignment = "center";
                this.progressText.langControl = false;
                this.progressText.ltcFilters = "";
                this.progressText.minFontSizeData = "";
                this.progressText.scalingData = "";
                this.progressText.showBounds = false;
                this.progressText.textSize = 12;
                this.progressText.text = "24/20";
                this.progressText.textColor = 2361859;
                this.progressText.token = "";
                this.progressText.textVerticalAlignment = "top";
                this.progressText.visible = true;
                this.progressText.wordWrapData = "";
                this.progressText.zrevision = "v2.0.6";
                try
                {
                    this.progressText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function frame1():*
        {
            this.__setProp_bodyText_progressWindowSnow_Bodytext_0();
            stop();
        }

        internal function frame2():*
        {
            this.__setProp_bodyText_progressWindowSnow_title_1();
            this.__setProp_progressText_progressWindowSnow_progressText_1();
            stop();
        }

        internal function frame3():*
        {
            this.__setProp_bodyText_progressWindowSnow_Bodytext_2();
            stop();
        }

        internal function frame4():*
        {
            this.__setProp_progressText_progressWindowSnow_progressText_3();
            stop();
        }


    }
}//package CardJitsuProgressInventoryAssets_fla
