//Created by Action Script Viewer - https://www.buraks.com/asv
package prompt_assets_fla
{
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.LocalTextComponent;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.utils.Dictionary;
    import flash.events.Event;
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

    public dynamic class Prompt_1 extends MovieClip 
    {

        public var continue_ltc:LocalTextComponent;//instance name
        public var ok_btn:SimpleButton;//instance name
        public var icon_mc:MovieClip;//instance name
        public var yes_btn:SimpleButton;//instance name
        public var text_input:TextField;//instance name
        public var card0:MovieClip;//instance name
        public var message_bottom_ltc:LocalTextComponent;//instance name
        public var card1:MovieClip;//instance name
        public var block_mc:MovieClip;//instance name
        public var card2:MovieClip;//instance name
		public var card3:MovieClip;//instance name
		public var card4:MovieClip;//instance name
		public var card5:MovieClip;//instance name
        public var message_ltc:LocalTextComponent;//instance name
        public var no_ltc:LocalTextComponent;//instance name
        public var close_btn:SimpleButton;//instance name
        public var continue_btn:SimpleButton;//instance name
        public var ok_ltc:LocalTextComponent;//instance name
        public var loading:MovieClip;//instance name
        public var yes_ltc:LocalTextComponent;//instance name
        public var no_btn:SimpleButton;//instance name
        public var __setPropDict:Dictionary = new Dictionary(true);
        public var __lastFrameProp:int = -1;

        public function Prompt_1()
        {
            addFrameScript(0, this.frame1, 1, this.frame2, 3, this.frame4, 5, this.frame6, 6, this.frame7, 7, this.frame8, 11, this.frame12, 8, this.frame9, 9, this.frame10, 10, this.frame11, 12, this.frame13);
            addEventListener(Event.FRAME_CONSTRUCTED, this.__setProp_handler, false, 0, true);
        }

        internal function __setProp_message_ltc_Prompt_comptext_1():*
        {
            if (((this.__setPropDict[this.message_ltc] == undefined) || (!(int(this.__setPropDict[this.message_ltc]) == 2))))
            {
                this.__setPropDict[this.message_ltc] = 2;
                try
                {
                    this.message_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_ltc.currentLang = "en";
                this.message_ltc.debugColor = 0xCC00;
                this.message_ltc.enabled = true;
                this.message_ltc.font = "cpBurbankSmall";
                this.message_ltc.globalMinFontSize = 8;
                this.message_ltc.globalScaling = true;
                this.message_ltc.globalWordWrap = true;
                this.message_ltc.groupName = "[none]";
                this.message_ltc.textHorizontalAlignment = "center";
                this.message_ltc.langControl = false;
                this.message_ltc.ltcFilters = "";
                this.message_ltc.minFontSizeData = "";
                this.message_ltc.scalingData = "";
                this.message_ltc.showBounds = false;
                this.message_ltc.textSize = 14;
                this.message_ltc.text = "Message goes here";
                this.message_ltc.textColor = 0;
                this.message_ltc.token = "";
                this.message_ltc.visible = true;
                this.message_ltc.textVerticalAlignment = "top";
                this.message_ltc.wordWrapData = "";
                this.message_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_message_ltc_Prompt_comptext_2(_arg_1:int):*
        {
            if (((((!(this.message_ltc == null)) && (_arg_1 >= 3)) && (_arg_1 <= 4)) && ((this.__setPropDict[this.message_ltc] == undefined) || (!((int(this.__setPropDict[this.message_ltc]) >= 3) && (int(this.__setPropDict[this.message_ltc]) <= 4))))))
            {
                this.__setPropDict[this.message_ltc] = _arg_1;
                try
                {
                    this.message_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_ltc.currentLang = "en";
                this.message_ltc.debugColor = 0xCC00;
                this.message_ltc.enabled = true;
                this.message_ltc.font = "cpBurbankSmall";
                this.message_ltc.globalMinFontSize = 8;
                this.message_ltc.globalScaling = true;
                this.message_ltc.globalWordWrap = true;
                this.message_ltc.groupName = "[none]";
                this.message_ltc.textHorizontalAlignment = "center";
                this.message_ltc.langControl = false;
                this.message_ltc.ltcFilters = "";
                this.message_ltc.minFontSizeData = "";
                this.message_ltc.scalingData = "";
                this.message_ltc.showBounds = false;
                this.message_ltc.textSize = 15;
                this.message_ltc.text = "Message goes here";
                this.message_ltc.textColor = 0;
                this.message_ltc.token = "";
                this.message_ltc.visible = true;
                this.message_ltc.textVerticalAlignment = "top";
                this.message_ltc.wordWrapData = "";
                this.message_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_yes_ltc_Prompt_comptext_1(_arg_1:int):*
        {
            if (((((!(this.yes_ltc == null)) && (_arg_1 >= 2)) && (_arg_1 <= 3)) && ((this.__setPropDict[this.yes_ltc] == undefined) || (!((int(this.__setPropDict[this.yes_ltc]) >= 2) && (int(this.__setPropDict[this.yes_ltc]) <= 3))))))
            {
                this.__setPropDict[this.yes_ltc] = _arg_1;
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.yes_ltc.currentLang = "en";
                this.yes_ltc.debugColor = 0xCC00;
                this.yes_ltc.enabled = true;
                this.yes_ltc.font = "cpBurbankSmallBold";
                this.yes_ltc.globalMinFontSize = 8;
                this.yes_ltc.globalScaling = true;
                this.yes_ltc.globalWordWrap = true;
                this.yes_ltc.groupName = "[none]";
                this.yes_ltc.textHorizontalAlignment = "center";
                this.yes_ltc.langControl = false;
                this.yes_ltc.ltcFilters = "";
                this.yes_ltc.minFontSizeData = "";
                this.yes_ltc.scalingData = "";
                this.yes_ltc.showBounds = false;
                this.yes_ltc.textSize = 18;
                this.yes_ltc.text = "Yes";
                this.yes_ltc.textColor = 0xFFFFFF;
                this.yes_ltc.token = "Yes";
                this.yes_ltc.visible = true;
                this.yes_ltc.textVerticalAlignment = "center";
                this.yes_ltc.wordWrapData = "";
                this.yes_ltc.zrevision = "v2.0.5";
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_no_ltc_Prompt_comptext_1(_arg_1:int):*
        {
            if (((((!(this.no_ltc == null)) && (_arg_1 >= 2)) && (_arg_1 <= 3)) && ((this.__setPropDict[this.no_ltc] == undefined) || (!((int(this.__setPropDict[this.no_ltc]) >= 2) && (int(this.__setPropDict[this.no_ltc]) <= 3))))))
            {
                this.__setPropDict[this.no_ltc] = _arg_1;
                try
                {
                    this.no_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.no_ltc.currentLang = "en";
                this.no_ltc.debugColor = 0xCC00;
                this.no_ltc.enabled = true;
                this.no_ltc.font = "cpBurbankSmallBold";
                this.no_ltc.globalMinFontSize = 8;
                this.no_ltc.globalScaling = true;
                this.no_ltc.globalWordWrap = true;
                this.no_ltc.groupName = "[none]";
                this.no_ltc.textHorizontalAlignment = "center";
                this.no_ltc.langControl = false;
                this.no_ltc.ltcFilters = "";
                this.no_ltc.minFontSizeData = "";
                this.no_ltc.scalingData = "";
                this.no_ltc.showBounds = false;
                this.no_ltc.textSize = 18;
                this.no_ltc.text = "No";
                this.no_ltc.textColor = 0xFFFFFF;
                this.no_ltc.token = "No";
                this.no_ltc.visible = true;
                this.no_ltc.textVerticalAlignment = "center";
                this.no_ltc.wordWrapData = "";
                this.no_ltc.zrevision = "v2.0.5";
                try
                {
                    this.no_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_ok_ltc_Prompt_comptext_3():*
        {
            if (((this.__setPropDict[this.ok_ltc] == undefined) || (!(int(this.__setPropDict[this.ok_ltc]) == 4))))
            {
                this.__setPropDict[this.ok_ltc] = 4;
                try
                {
                    this.ok_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.ok_ltc.currentLang = "en";
                this.ok_ltc.debugColor = 0xCC00;
                this.ok_ltc.enabled = true;
                this.ok_ltc.font = "cpBurbankSmallBold";
                this.ok_ltc.globalMinFontSize = 8;
                this.ok_ltc.globalScaling = true;
                this.ok_ltc.globalWordWrap = true;
                this.ok_ltc.groupName = "[none]";
                this.ok_ltc.textHorizontalAlignment = "center";
                this.ok_ltc.langControl = false;
                this.ok_ltc.ltcFilters = "";
                this.ok_ltc.minFontSizeData = "";
                this.ok_ltc.scalingData = "";
                this.ok_ltc.showBounds = false;
                this.ok_ltc.textSize = 18;
                this.ok_ltc.text = "Ok";
                this.ok_ltc.textColor = 0xFFFFFF;
                this.ok_ltc.token = "Ok";
                this.ok_ltc.visible = true;
                this.ok_ltc.textVerticalAlignment = "center";
                this.ok_ltc.wordWrapData = "";
                this.ok_ltc.zrevision = "v2.0.5";
                try
                {
                    this.ok_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_message_ltc_Prompt_comptext_5():*
        {
            if (((this.__setPropDict[this.message_ltc] == undefined) || (!(int(this.__setPropDict[this.message_ltc]) == 6))))
            {
                this.__setPropDict[this.message_ltc] = 6;
                try
                {
                    this.message_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_ltc.currentLang = "en";
                this.message_ltc.debugColor = 0xCC00;
                this.message_ltc.enabled = true;
                this.message_ltc.font = "cpBurbankSmall";
                this.message_ltc.globalMinFontSize = 8;
                this.message_ltc.globalScaling = true;
                this.message_ltc.globalWordWrap = true;
                this.message_ltc.groupName = "[none]";
                this.message_ltc.textHorizontalAlignment = "center";
                this.message_ltc.langControl = false;
                this.message_ltc.ltcFilters = "";
                this.message_ltc.minFontSizeData = "";
                this.message_ltc.scalingData = "";
                this.message_ltc.showBounds = false;
                this.message_ltc.textSize = 14;
                this.message_ltc.text = "Line Goes Here";
                this.message_ltc.textColor = 0;
                this.message_ltc.token = "";
                this.message_ltc.visible = true;
                this.message_ltc.textVerticalAlignment = "center";
                this.message_ltc.wordWrapData = "";
                this.message_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_message_ltc_Prompt_comptext_6():*
        {
            if (((this.__setPropDict[this.message_ltc] == undefined) || (!(int(this.__setPropDict[this.message_ltc]) == 7))))
            {
                this.__setPropDict[this.message_ltc] = 7;
                try
                {
                    this.message_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_ltc.currentLang = "en";
                this.message_ltc.debugColor = 0xCC00;
                this.message_ltc.enabled = true;
                this.message_ltc.font = "cpBurbankSmall";
                this.message_ltc.globalMinFontSize = 8;
                this.message_ltc.globalScaling = true;
                this.message_ltc.globalWordWrap = true;
                this.message_ltc.groupName = "[none]";
                this.message_ltc.textHorizontalAlignment = "center";
                this.message_ltc.langControl = false;
                this.message_ltc.ltcFilters = "";
                this.message_ltc.minFontSizeData = "";
                this.message_ltc.scalingData = "";
                this.message_ltc.showBounds = false;
                this.message_ltc.textSize = 15;
                this.message_ltc.text = "You found a party hat.\\nWould you like to pick it up?";
                this.message_ltc.textColor = 0;
                this.message_ltc.token = "";
                this.message_ltc.visible = true;
                this.message_ltc.textVerticalAlignment = "center";
                this.message_ltc.wordWrapData = "";
                this.message_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_message_ltc_Prompt_comptext_7():*
        {
            if (((this.__setPropDict[this.message_ltc] == undefined) || (!(int(this.__setPropDict[this.message_ltc]) == 8))))
            {
                this.__setPropDict[this.message_ltc] = 8;
                try
                {
                    this.message_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_ltc.currentLang = "en";
                this.message_ltc.debugColor = 0xCC00;
                this.message_ltc.enabled = true;
                this.message_ltc.font = "cpBurbankSmall";
                this.message_ltc.globalMinFontSize = 8;
                this.message_ltc.globalScaling = true;
                this.message_ltc.globalWordWrap = true;
                this.message_ltc.groupName = "[none]";
                this.message_ltc.textHorizontalAlignment = "center";
                this.message_ltc.langControl = false;
                this.message_ltc.ltcFilters = "";
                this.message_ltc.minFontSizeData = "";
                this.message_ltc.scalingData = "";
                this.message_ltc.showBounds = false;
                this.message_ltc.textSize = 15;
                this.message_ltc.text = "You found a party hat.\\nWould you like to pick it up?";
                this.message_ltc.textColor = 0;
                this.message_ltc.token = "";
                this.message_ltc.visible = true;
                this.message_ltc.textVerticalAlignment = "center";
                this.message_ltc.wordWrapData = "";
                this.message_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_message_ltc_Prompt_comptext_8(_arg_1:int):*
        {
            if (((((!(this.message_ltc == null)) && (_arg_1 >= 9)) && (_arg_1 <= 11)) && ((this.__setPropDict[this.message_ltc] == undefined) || (!((int(this.__setPropDict[this.message_ltc]) >= 9) && (int(this.__setPropDict[this.message_ltc]) <= 11))))))
            {
                this.__setPropDict[this.message_ltc] = _arg_1;
                try
                {
                    this.message_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_ltc.currentLang = "en";
                this.message_ltc.debugColor = 0xCC00;
                this.message_ltc.enabled = true;
                this.message_ltc.font = "cpBurbankSmall";
                this.message_ltc.globalMinFontSize = 8;
                this.message_ltc.globalScaling = true;
                this.message_ltc.globalWordWrap = true;
                this.message_ltc.groupName = "[none]";
                this.message_ltc.textHorizontalAlignment = "center";
                this.message_ltc.langControl = false;
                this.message_ltc.ltcFilters = "";
                this.message_ltc.minFontSizeData = "";
                this.message_ltc.scalingData = "";
                this.message_ltc.showBounds = false;
                this.message_ltc.textSize = 15;
                this.message_ltc.text = "Message goes here";
                this.message_ltc.textColor = 0;
                this.message_ltc.token = "";
                this.message_ltc.visible = true;
                this.message_ltc.textVerticalAlignment = "center";
                this.message_ltc.wordWrapData = "";
                this.message_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_message_ltc_Prompt_comptext_11():*
        {
            if (((this.__setPropDict[this.message_ltc] == undefined) || (!(int(this.__setPropDict[this.message_ltc]) == 12))))
            {
                this.__setPropDict[this.message_ltc] = 12;
                try
                {
                    this.message_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_ltc.currentLang = "en";
                this.message_ltc.debugColor = 0xCC00;
                this.message_ltc.enabled = true;
                this.message_ltc.font = "cpBurbankSmallBold";
                this.message_ltc.globalMinFontSize = 8;
                this.message_ltc.globalScaling = true;
                this.message_ltc.globalWordWrap = true;
                this.message_ltc.groupName = "[none]";
                this.message_ltc.textHorizontalAlignment = "center";
                this.message_ltc.langControl = false;
                this.message_ltc.ltcFilters = "";
                this.message_ltc.minFontSizeData = "";
                this.message_ltc.scalingData = "";
                this.message_ltc.showBounds = false;
                this.message_ltc.textSize = 15;
                this.message_ltc.text = "Would you like to buy 3 Power Cards for %cost% coins? You currently have %num% coins.";
                this.message_ltc.textColor = 0xFFFFFF;
                this.message_ltc.token = "";
                this.message_ltc.visible = true;
                this.message_ltc.textVerticalAlignment = "center";
                this.message_ltc.wordWrapData = "";
                this.message_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_yes_ltc_Prompt_comptext_5():*
        {
            if (((this.__setPropDict[this.yes_ltc] == undefined) || (!(int(this.__setPropDict[this.yes_ltc]) == 6))))
            {
                this.__setPropDict[this.yes_ltc] = 6;
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.yes_ltc.currentLang = "en";
                this.yes_ltc.debugColor = 0xCC00;
                this.yes_ltc.enabled = true;
                this.yes_ltc.font = "cpBurbankSmallBold";
                this.yes_ltc.globalMinFontSize = 8;
                this.yes_ltc.globalScaling = true;
                this.yes_ltc.globalWordWrap = true;
                this.yes_ltc.groupName = "[none]";
                this.yes_ltc.textHorizontalAlignment = "center";
                this.yes_ltc.langControl = false;
                this.yes_ltc.ltcFilters = "";
                this.yes_ltc.minFontSizeData = "";
                this.yes_ltc.scalingData = "";
                this.yes_ltc.showBounds = false;
                this.yes_ltc.textSize = 18;
                this.yes_ltc.text = "Yes";
                this.yes_ltc.textColor = 0xFFFFFF;
                this.yes_ltc.token = "Yes";
                this.yes_ltc.visible = true;
                this.yes_ltc.textVerticalAlignment = "center";
                this.yes_ltc.wordWrapData = "";
                this.yes_ltc.zrevision = "v2.0.5";
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_yes_ltc_Prompt_comptext_6():*
        {
            if (((this.__setPropDict[this.yes_ltc] == undefined) || (!(int(this.__setPropDict[this.yes_ltc]) == 7))))
            {
                this.__setPropDict[this.yes_ltc] = 7;
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.yes_ltc.currentLang = "en";
                this.yes_ltc.debugColor = 0xCC00;
                this.yes_ltc.enabled = true;
                this.yes_ltc.font = "cpBurbankSmallBold";
                this.yes_ltc.globalMinFontSize = 8;
                this.yes_ltc.globalScaling = true;
                this.yes_ltc.globalWordWrap = true;
                this.yes_ltc.groupName = "[none]";
                this.yes_ltc.textHorizontalAlignment = "center";
                this.yes_ltc.langControl = false;
                this.yes_ltc.ltcFilters = "";
                this.yes_ltc.minFontSizeData = "";
                this.yes_ltc.scalingData = "";
                this.yes_ltc.showBounds = false;
                this.yes_ltc.textSize = 18;
                this.yes_ltc.text = "Yes";
                this.yes_ltc.textColor = 0xFFFFFF;
                this.yes_ltc.token = "Yes";
                this.yes_ltc.visible = true;
                this.yes_ltc.textVerticalAlignment = "center";
                this.yes_ltc.wordWrapData = "";
                this.yes_ltc.zrevision = "v2.0.5";
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_no_ltc_Prompt_comptext_5():*
        {
            if (((this.__setPropDict[this.no_ltc] == undefined) || (!(int(this.__setPropDict[this.no_ltc]) == 6))))
            {
                this.__setPropDict[this.no_ltc] = 6;
                try
                {
                    this.no_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.no_ltc.currentLang = "en";
                this.no_ltc.debugColor = 0xCC00;
                this.no_ltc.enabled = true;
                this.no_ltc.font = "cpBurbankSmallBold";
                this.no_ltc.globalMinFontSize = 8;
                this.no_ltc.globalScaling = true;
                this.no_ltc.globalWordWrap = true;
                this.no_ltc.groupName = "[none]";
                this.no_ltc.textHorizontalAlignment = "center";
                this.no_ltc.langControl = false;
                this.no_ltc.ltcFilters = "";
                this.no_ltc.minFontSizeData = "";
                this.no_ltc.scalingData = "";
                this.no_ltc.showBounds = false;
                this.no_ltc.textSize = 18;
                this.no_ltc.text = "No";
                this.no_ltc.textColor = 0xFFFFFF;
                this.no_ltc.token = "No";
                this.no_ltc.visible = true;
                this.no_ltc.textVerticalAlignment = "center";
                this.no_ltc.wordWrapData = "";
                this.no_ltc.zrevision = "v2.0.5";
                try
                {
                    this.no_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_no_ltc_Prompt_comptext_6():*
        {
            if (((this.__setPropDict[this.no_ltc] == undefined) || (!(int(this.__setPropDict[this.no_ltc]) == 7))))
            {
                this.__setPropDict[this.no_ltc] = 7;
                try
                {
                    this.no_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.no_ltc.currentLang = "en";
                this.no_ltc.debugColor = 0xCC00;
                this.no_ltc.enabled = true;
                this.no_ltc.font = "cpBurbankSmallBold";
                this.no_ltc.globalMinFontSize = 8;
                this.no_ltc.globalScaling = true;
                this.no_ltc.globalWordWrap = true;
                this.no_ltc.groupName = "[none]";
                this.no_ltc.textHorizontalAlignment = "center";
                this.no_ltc.langControl = false;
                this.no_ltc.ltcFilters = "";
                this.no_ltc.minFontSizeData = "";
                this.no_ltc.scalingData = "";
                this.no_ltc.showBounds = false;
                this.no_ltc.textSize = 18;
                this.no_ltc.text = "No";
                this.no_ltc.textColor = 0xFFFFFF;
                this.no_ltc.token = "No";
                this.no_ltc.visible = true;
                this.no_ltc.textVerticalAlignment = "center";
                this.no_ltc.wordWrapData = "";
                this.no_ltc.zrevision = "v2.0.5";
                try
                {
                    this.no_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_ok_ltc_Prompt_comptext_7():*
        {
            if (((this.__setPropDict[this.ok_ltc] == undefined) || (!(int(this.__setPropDict[this.ok_ltc]) == 8))))
            {
                this.__setPropDict[this.ok_ltc] = 8;
                try
                {
                    this.ok_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.ok_ltc.currentLang = "en";
                this.ok_ltc.debugColor = 0xCC00;
                this.ok_ltc.enabled = true;
                this.ok_ltc.font = "cpBurbankSmallBold";
                this.ok_ltc.globalMinFontSize = 8;
                this.ok_ltc.globalScaling = true;
                this.ok_ltc.globalWordWrap = true;
                this.ok_ltc.groupName = "[none]";
                this.ok_ltc.textHorizontalAlignment = "center";
                this.ok_ltc.langControl = false;
                this.ok_ltc.ltcFilters = "";
                this.ok_ltc.minFontSizeData = "";
                this.ok_ltc.scalingData = "";
                this.ok_ltc.showBounds = false;
                this.ok_ltc.textSize = 18;
                this.ok_ltc.text = "Ok";
                this.ok_ltc.textColor = 0xFFFFFF;
                this.ok_ltc.token = "Ok";
                this.ok_ltc.visible = true;
                this.ok_ltc.textVerticalAlignment = "center";
                this.ok_ltc.wordWrapData = "";
                this.ok_ltc.zrevision = "v2.0.5";
                try
                {
                    this.ok_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_continue_ltc_Prompt_comptext_8():*
        {
            if (((this.__setPropDict[this.continue_ltc] == undefined) || (!(int(this.__setPropDict[this.continue_ltc]) == 9))))
            {
                this.__setPropDict[this.continue_ltc] = 9;
                try
                {
                    this.continue_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.continue_ltc.currentLang = "en";
                this.continue_ltc.debugColor = 0xCC00;
                this.continue_ltc.enabled = true;
                this.continue_ltc.font = "cpBurbankSmallBold";
                this.continue_ltc.globalMinFontSize = 8;
                this.continue_ltc.globalScaling = true;
                this.continue_ltc.globalWordWrap = true;
                this.continue_ltc.groupName = "[none]";
                this.continue_ltc.textHorizontalAlignment = "center";
                this.continue_ltc.langControl = false;
                this.continue_ltc.ltcFilters = "";
                this.continue_ltc.minFontSizeData = "";
                this.continue_ltc.scalingData = "";
                this.continue_ltc.showBounds = false;
                this.continue_ltc.textSize = 18;
                this.continue_ltc.text = "Continue";
                this.continue_ltc.textColor = 0xFFFFFF;
                this.continue_ltc.token = "Continue";
                this.continue_ltc.visible = true;
                this.continue_ltc.textVerticalAlignment = "center";
                this.continue_ltc.wordWrapData = "";
                this.continue_ltc.zrevision = "v2.0.5";
                try
                {
                    this.continue_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_ok_ltc_Prompt_comptext_9():*
        {
            if (((this.__setPropDict[this.ok_ltc] == undefined) || (!(int(this.__setPropDict[this.ok_ltc]) == 10))))
            {
                this.__setPropDict[this.ok_ltc] = 10;
                try
                {
                    this.ok_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.ok_ltc.currentLang = "en";
                this.ok_ltc.debugColor = 0xCC00;
                this.ok_ltc.enabled = true;
                this.ok_ltc.font = "cpBurbankSmallBold";
                this.ok_ltc.globalMinFontSize = 8;
                this.ok_ltc.globalScaling = true;
                this.ok_ltc.globalWordWrap = true;
                this.ok_ltc.groupName = "[none]";
                this.ok_ltc.textHorizontalAlignment = "center";
                this.ok_ltc.langControl = false;
                this.ok_ltc.ltcFilters = "";
                this.ok_ltc.minFontSizeData = "";
                this.ok_ltc.scalingData = "";
                this.ok_ltc.showBounds = false;
                this.ok_ltc.textSize = 18;
                this.ok_ltc.text = "Ok";
                this.ok_ltc.textColor = 0xFFFFFF;
                this.ok_ltc.token = "Ok";
                this.ok_ltc.visible = true;
                this.ok_ltc.textVerticalAlignment = "center";
                this.ok_ltc.wordWrapData = "";
                this.ok_ltc.zrevision = "v2.0.5";
                try
                {
                    this.ok_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_yes_ltc_Prompt_comptext_10():*
        {
            if (((this.__setPropDict[this.yes_ltc] == undefined) || (!(int(this.__setPropDict[this.yes_ltc]) == 11))))
            {
                this.__setPropDict[this.yes_ltc] = 11;
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.yes_ltc.currentLang = "en";
                this.yes_ltc.debugColor = 0xCC00;
                this.yes_ltc.enabled = true;
                this.yes_ltc.font = "cpBurbankSmallBold";
                this.yes_ltc.globalMinFontSize = 8;
                this.yes_ltc.globalScaling = true;
                this.yes_ltc.globalWordWrap = true;
                this.yes_ltc.groupName = "[none]";
                this.yes_ltc.textHorizontalAlignment = "center";
                this.yes_ltc.langControl = false;
                this.yes_ltc.ltcFilters = "";
                this.yes_ltc.minFontSizeData = "";
                this.yes_ltc.scalingData = "";
                this.yes_ltc.showBounds = false;
                this.yes_ltc.textSize = 18;
                this.yes_ltc.text = "Yes";
                this.yes_ltc.textColor = 0xFFFFFF;
                this.yes_ltc.token = "Yes";
                this.yes_ltc.visible = true;
                this.yes_ltc.textVerticalAlignment = "center";
                this.yes_ltc.wordWrapData = "";
                this.yes_ltc.zrevision = "v2.0.5";
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_no_ltc_Prompt_comptext_10():*
        {
            if (((this.__setPropDict[this.no_ltc] == undefined) || (!(int(this.__setPropDict[this.no_ltc]) == 11))))
            {
                this.__setPropDict[this.no_ltc] = 11;
                try
                {
                    this.no_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.no_ltc.currentLang = "en";
                this.no_ltc.debugColor = 0xCC00;
                this.no_ltc.enabled = true;
                this.no_ltc.font = "cpBurbankSmallBold";
                this.no_ltc.globalMinFontSize = 8;
                this.no_ltc.globalScaling = true;
                this.no_ltc.globalWordWrap = true;
                this.no_ltc.groupName = "[none]";
                this.no_ltc.textHorizontalAlignment = "center";
                this.no_ltc.langControl = false;
                this.no_ltc.ltcFilters = "";
                this.no_ltc.minFontSizeData = "";
                this.no_ltc.scalingData = "";
                this.no_ltc.showBounds = false;
                this.no_ltc.textSize = 18;
                this.no_ltc.text = "No";
                this.no_ltc.textColor = 0xFFFFFF;
                this.no_ltc.token = "No";
                this.no_ltc.visible = true;
                this.no_ltc.textVerticalAlignment = "center";
                this.no_ltc.wordWrapData = "";
                this.no_ltc.zrevision = "v2.0.5";
                try
                {
                    this.no_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_message_bottom_ltc_Prompt_comptext_10():*
        {
            if (((this.__setPropDict[this.message_bottom_ltc] == undefined) || (!(int(this.__setPropDict[this.message_bottom_ltc]) == 11))))
            {
                this.__setPropDict[this.message_bottom_ltc] = 11;
                try
                {
                    this.message_bottom_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_bottom_ltc.currentLang = "en";
                this.message_bottom_ltc.debugColor = 0xCC00;
                this.message_bottom_ltc.enabled = true;
                this.message_bottom_ltc.font = "cpBurbankSmall";
                this.message_bottom_ltc.globalMinFontSize = 8;
                this.message_bottom_ltc.globalScaling = true;
                this.message_bottom_ltc.globalWordWrap = true;
                this.message_bottom_ltc.groupName = "[none]";
                this.message_bottom_ltc.textHorizontalAlignment = "center";
                this.message_bottom_ltc.langControl = false;
                this.message_bottom_ltc.ltcFilters = "";
                this.message_bottom_ltc.minFontSizeData = "";
                this.message_bottom_ltc.scalingData = "";
                this.message_bottom_ltc.showBounds = false;
                this.message_bottom_ltc.textSize = 15;
                this.message_bottom_ltc.text = "Message goes here";
                this.message_bottom_ltc.textColor = 0;
                this.message_bottom_ltc.token = "";
                this.message_bottom_ltc.visible = true;
                this.message_bottom_ltc.textVerticalAlignment = "center";
                this.message_bottom_ltc.wordWrapData = "";
                this.message_bottom_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_bottom_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_yes_ltc_Prompt_comptext_11():*
        {
            if (((this.__setPropDict[this.yes_ltc] == undefined) || (!(int(this.__setPropDict[this.yes_ltc]) == 12))))
            {
                this.__setPropDict[this.yes_ltc] = 12;
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.yes_ltc.currentLang = "en";
                this.yes_ltc.debugColor = 0xCC00;
                this.yes_ltc.enabled = true;
                this.yes_ltc.font = "cpBurbankSmallBold";
                this.yes_ltc.globalMinFontSize = 8;
                this.yes_ltc.globalScaling = true;
                this.yes_ltc.globalWordWrap = true;
                this.yes_ltc.groupName = "[none]";
                this.yes_ltc.textHorizontalAlignment = "center";
                this.yes_ltc.langControl = false;
                this.yes_ltc.ltcFilters = "";
                this.yes_ltc.minFontSizeData = "";
                this.yes_ltc.scalingData = "";
                this.yes_ltc.showBounds = false;
                this.yes_ltc.textSize = 18;
                this.yes_ltc.text = "Yes";
                this.yes_ltc.textColor = 0xFFFFFF;
                this.yes_ltc.token = "Yes";
                this.yes_ltc.visible = true;
                this.yes_ltc.textVerticalAlignment = "center";
                this.yes_ltc.wordWrapData = "";
                this.yes_ltc.zrevision = "v2.0.5";
                try
                {
                    this.yes_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_no_ltc_Prompt_comptext_11():*
        {
            if (((this.__setPropDict[this.no_ltc] == undefined) || (!(int(this.__setPropDict[this.no_ltc]) == 12))))
            {
                this.__setPropDict[this.no_ltc] = 12;
                try
                {
                    this.no_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.no_ltc.currentLang = "en";
                this.no_ltc.debugColor = 0xCC00;
                this.no_ltc.enabled = true;
                this.no_ltc.font = "cpBurbankSmallBold";
                this.no_ltc.globalMinFontSize = 8;
                this.no_ltc.globalScaling = true;
                this.no_ltc.globalWordWrap = true;
                this.no_ltc.groupName = "[none]";
                this.no_ltc.textHorizontalAlignment = "center";
                this.no_ltc.langControl = false;
                this.no_ltc.ltcFilters = "";
                this.no_ltc.minFontSizeData = "";
                this.no_ltc.scalingData = "";
                this.no_ltc.showBounds = false;
                this.no_ltc.textSize = 18;
                this.no_ltc.text = "No";
                this.no_ltc.textColor = 0xFFFFFF;
                this.no_ltc.token = "No";
                this.no_ltc.visible = true;
                this.no_ltc.textVerticalAlignment = "center";
                this.no_ltc.wordWrapData = "";
                this.no_ltc.zrevision = "v2.0.5";
                try
                {
                    this.no_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_message_ltc_Prompt_Window_12():*
        {
            if (((this.__setPropDict[this.message_ltc] == undefined) || (!(int(this.__setPropDict[this.message_ltc]) == 13))))
            {
                this.__setPropDict[this.message_ltc] = 13;
                try
                {
                    this.message_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.message_ltc.currentLang = "en";
                this.message_ltc.debugColor = 0xCC00;
                this.message_ltc.enabled = true;
                this.message_ltc.font = "cpBurbankSmallBold";
                this.message_ltc.globalMinFontSize = 8;
                this.message_ltc.globalScaling = true;
                this.message_ltc.globalWordWrap = true;
                this.message_ltc.groupName = "[none]";
                this.message_ltc.textHorizontalAlignment = "center";
                this.message_ltc.langControl = false;
                this.message_ltc.ltcFilters = "";
                this.message_ltc.minFontSizeData = "";
                this.message_ltc.scalingData = "";
                this.message_ltc.showBounds = false;
                this.message_ltc.textSize = 15;
                this.message_ltc.text = "These 3 Power Cards have been added to your inventory.";
                this.message_ltc.textColor = 0xFFFFFF;
                this.message_ltc.token = "";
                this.message_ltc.visible = true;
                this.message_ltc.textVerticalAlignment = "center";
                this.message_ltc.wordWrapData = "";
                this.message_ltc.zrevision = "v2.0.5";
                try
                {
                    this.message_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_ok_ltc_Prompt_Icon_12():*
        {
            if (((this.__setPropDict[this.ok_ltc] == undefined) || (!(int(this.__setPropDict[this.ok_ltc]) == 13))))
            {
                this.__setPropDict[this.ok_ltc] = 13;
                try
                {
                    this.ok_ltc["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.ok_ltc.currentLang = "en";
                this.ok_ltc.debugColor = 0xCC00;
                this.ok_ltc.enabled = true;
                this.ok_ltc.font = "cpBurbankSmallBold";
                this.ok_ltc.globalMinFontSize = 8;
                this.ok_ltc.globalScaling = true;
                this.ok_ltc.globalWordWrap = true;
                this.ok_ltc.groupName = "[none]";
                this.ok_ltc.textHorizontalAlignment = "center";
                this.ok_ltc.langControl = false;
                this.ok_ltc.ltcFilters = "";
                this.ok_ltc.minFontSizeData = "";
                this.ok_ltc.scalingData = "";
                this.ok_ltc.showBounds = false;
                this.ok_ltc.textSize = 18;
                this.ok_ltc.text = "Ok";
                this.ok_ltc.textColor = 0xFFFFFF;
                this.ok_ltc.token = "Ok";
                this.ok_ltc.visible = true;
                this.ok_ltc.textVerticalAlignment = "center";
                this.ok_ltc.wordWrapData = "";
                this.ok_ltc.zrevision = "v2.0.5";
                try
                {
                    this.ok_ltc["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_handler(_arg_1:Object):*
        {
            var _local_2:int = currentFrame;
            if (this.__lastFrameProp == _local_2)
            {
                return;
            };
            this.__lastFrameProp = _local_2;
            this.__setProp_message_ltc_Prompt_comptext_2(_local_2);
            this.__setProp_yes_ltc_Prompt_comptext_1(_local_2);
            this.__setProp_no_ltc_Prompt_comptext_1(_local_2);
            this.__setProp_message_ltc_Prompt_comptext_8(_local_2);
        }

        internal function frame1():*
        {
            stop();
        }

        internal function frame2():*
        {
            this.__setProp_message_ltc_Prompt_comptext_1();
        }

        internal function frame4():*
        {
            this.__setProp_ok_ltc_Prompt_comptext_3();
        }

        internal function frame6():*
        {
            this.__setProp_no_ltc_Prompt_comptext_5();
            this.__setProp_yes_ltc_Prompt_comptext_5();
            this.__setProp_message_ltc_Prompt_comptext_5();
        }

        internal function frame7():*
        {
            this.__setProp_no_ltc_Prompt_comptext_6();
            this.__setProp_yes_ltc_Prompt_comptext_6();
            this.__setProp_message_ltc_Prompt_comptext_6();
        }

        internal function frame8():*
        {
            this.__setProp_ok_ltc_Prompt_comptext_7();
            this.__setProp_message_ltc_Prompt_comptext_7();
        }

        internal function frame12():*
        {
            this.__setProp_no_ltc_Prompt_comptext_11();
            this.__setProp_yes_ltc_Prompt_comptext_11();
            this.__setProp_message_ltc_Prompt_comptext_11();
        }

        internal function frame9():*
        {
            this.__setProp_continue_ltc_Prompt_comptext_8();
        }

        internal function frame10():*
        {
            this.__setProp_ok_ltc_Prompt_comptext_9();
        }

        internal function frame11():*
        {
            this.__setProp_message_bottom_ltc_Prompt_comptext_10();
            this.__setProp_no_ltc_Prompt_comptext_10();
            this.__setProp_yes_ltc_Prompt_comptext_10();
        }

        internal function frame13():*
        {
            this.__setProp_ok_ltc_Prompt_Icon_12();
            this.__setProp_message_ltc_Prompt_Window_12();
        }


    }
}//package prompt_assets_fla
