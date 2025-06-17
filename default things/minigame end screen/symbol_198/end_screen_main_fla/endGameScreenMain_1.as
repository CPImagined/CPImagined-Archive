//Created by Action Script Viewer - https://www.buraks.com/asv
package end_screen_main_fla
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import com.clubpenguin.tools.localtext.component.LocalTextComponent;
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

    public dynamic class endGameScreenMain_1 extends MovieClip 
    {

        public var pet:SimpleButton;//instance name
        public var gameLogo:MovieClip;//instance name
        public var done_text:LocalTextComponent;//instance name
        public var spend_text:LocalTextComponent;//instance name
        public var igloo:SimpleButton;//instance name
        public var pet_text:LocalTextComponent;//instance name
        public var done:SimpleButton;//instance name
        public var clothes:SimpleButton;//instance name
        public var igloo_text:LocalTextComponent;//instance name
        public var gameTitle_text:LocalTextComponent;//instance name
        public var close:MovieClip;//instance name
        public var clothes_text:LocalTextComponent;//instance name
        public var __setPropDict:Dictionary = new Dictionary(true);

        public function endGameScreenMain_1()
        {
            addFrameScript(0, this.frame1, 2, this.frame3, 4, this.frame5);
        }

        internal function __setProp_gameTitle_text_endGameScreenMain_text_0():*
        {
            if (((this.__setPropDict[this.gameTitle_text] == undefined) || (!(int(this.__setPropDict[this.gameTitle_text]) == 1))))
            {
                this.__setPropDict[this.gameTitle_text] = 1;
                try
                {
                    this.gameTitle_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.gameTitle_text.currentLang = "en";
                this.gameTitle_text.debugColor = 0xCC00;
                this.gameTitle_text.enabled = true;
                this.gameTitle_text.font = "cpBurbankSmallBold";
                this.gameTitle_text.globalMinFontSize = 8;
                this.gameTitle_text.globalScaling = true;
                this.gameTitle_text.globalWordWrap = false;
                this.gameTitle_text.groupName = "[none]";
                this.gameTitle_text.langControl = false;
                this.gameTitle_text.ltcFilters = "dropShadowFilter,45,5,5,,#003567ff,,0,,false,,,false,false,low,,,20,";
                this.gameTitle_text.minFontSizeData = "";
                this.gameTitle_text.scalingData = "";
                this.gameTitle_text.showBounds = false;
                this.gameTitle_text.text = "[PH]Hydro-Hopper";
                this.gameTitle_text.textColor = 0xFFFFFF;
                this.gameTitle_text.textHorizontalAlignment = "center";
                this.gameTitle_text.textSize = 26;
                this.gameTitle_text.textVerticalAlignment = "center";
                this.gameTitle_text.token = "";
                this.gameTitle_text.visible = true;
                this.gameTitle_text.wordWrapData = "";
                this.gameTitle_text.zrevision = "v2.1.1";
                try
                {
                    this.gameTitle_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_done_text_endGameScreenMain_text_0():*
        {
            if (((this.__setPropDict[this.done_text] == undefined) || (!(int(this.__setPropDict[this.done_text]) == 1))))
            {
                this.__setPropDict[this.done_text] = 1;
                try
                {
                    this.done_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.done_text.currentLang = "en";
                this.done_text.debugColor = 0xCC00;
                this.done_text.enabled = true;
                this.done_text.font = "cpBurbankSmallBold";
                this.done_text.globalMinFontSize = 8;
                this.done_text.globalScaling = true;
                this.done_text.globalWordWrap = false;
                this.done_text.groupName = "[none]";
                this.done_text.langControl = false;
                this.done_text.ltcFilters = "dropShadowFilter,45,4,4,,#003567ff,,0,,false,,,false,false,low,,,20,";
                this.done_text.minFontSizeData = "";
                this.done_text.scalingData = "";
                this.done_text.showBounds = false;
                this.done_text.text = "[PH]Done";
                this.done_text.textColor = 0xFFFFFF;
                this.done_text.textHorizontalAlignment = "center";
                this.done_text.textSize = 20;
                this.done_text.textVerticalAlignment = "center";
                this.done_text.token = "";
                this.done_text.visible = true;
                this.done_text.wordWrapData = "";
                this.done_text.zrevision = "v2.1.1";
                try
                {
                    this.done_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_clothes_text_endGameScreenMain_text_0():*
        {
            if (((this.__setPropDict[this.clothes_text] == undefined) || (!(int(this.__setPropDict[this.clothes_text]) == 1))))
            {
                this.__setPropDict[this.clothes_text] = 1;
                try
                {
                    this.clothes_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.clothes_text.currentLang = "en";
                this.clothes_text.debugColor = 0xCC00;
                this.clothes_text.enabled = true;
                this.clothes_text.font = "cpBurbankSmallBold";
                this.clothes_text.globalMinFontSize = 8;
                this.clothes_text.globalScaling = true;
                this.clothes_text.globalWordWrap = false;
                this.clothes_text.groupName = "[none]";
                this.clothes_text.langControl = false;
                this.clothes_text.ltcFilters = "dropShadowFilter,45,4,4,,#0051a0ff,,0,,false,,,false,false,low,,,20,";
                this.clothes_text.minFontSizeData = "";
                this.clothes_text.scalingData = "";
                this.clothes_text.showBounds = false;
                this.clothes_text.text = "[PH]Get New Styles";
                this.clothes_text.textColor = 0xFFFFFF;
                this.clothes_text.textHorizontalAlignment = "center";
                this.clothes_text.textSize = 10;
                this.clothes_text.textVerticalAlignment = "top";
                this.clothes_text.token = "";
                this.clothes_text.visible = true;
                this.clothes_text.wordWrapData = "";
                this.clothes_text.zrevision = "v2.1.1";
                try
                {
                    this.clothes_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_pet_text_endGameScreenMain_text_0():*
        {
            if (((this.__setPropDict[this.pet_text] == undefined) || (!(int(this.__setPropDict[this.pet_text]) == 1))))
            {
                this.__setPropDict[this.pet_text] = 1;
                try
                {
                    this.pet_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.pet_text.currentLang = "en";
                this.pet_text.debugColor = 0xCC00;
                this.pet_text.enabled = true;
                this.pet_text.font = "cpBurbankSmallBold";
                this.pet_text.globalMinFontSize = 8;
                this.pet_text.globalScaling = true;
                this.pet_text.globalWordWrap = false;
                this.pet_text.groupName = "[none]";
                this.pet_text.langControl = false;
                this.pet_text.ltcFilters = "dropShadowFilter,45,4,4,,#0051a0ff,,0,,false,,,false,false,low,,,20,";
                this.pet_text.minFontSizeData = "";
                this.pet_text.scalingData = "";
                this.pet_text.showBounds = false;
                this.pet_text.text = "[PH]Adopt a Pet\n";
                this.pet_text.textColor = 0xFFFFFF;
                this.pet_text.textHorizontalAlignment = "center";
                this.pet_text.textSize = 10;
                this.pet_text.textVerticalAlignment = "top";
                this.pet_text.token = "";
                this.pet_text.visible = true;
                this.pet_text.wordWrapData = "";
                this.pet_text.zrevision = "v2.1.1";
                try
                {
                    this.pet_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_igloo_text_endGameScreenMain_text_0():*
        {
            if (((this.__setPropDict[this.igloo_text] == undefined) || (!(int(this.__setPropDict[this.igloo_text]) == 1))))
            {
                this.__setPropDict[this.igloo_text] = 1;
                try
                {
                    this.igloo_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.igloo_text.currentLang = "en";
                this.igloo_text.debugColor = 0xCC00;
                this.igloo_text.enabled = true;
                this.igloo_text.font = "cpBurbankSmallBold";
                this.igloo_text.globalMinFontSize = 8;
                this.igloo_text.globalScaling = true;
                this.igloo_text.globalWordWrap = false;
                this.igloo_text.groupName = "[none]";
                this.igloo_text.langControl = false;
                this.igloo_text.ltcFilters = "dropShadowFilter,45,4,4,,#0051a0ff,,0,,false,,,false,false,low,,,20,";
                this.igloo_text.minFontSizeData = "";
                this.igloo_text.scalingData = "";
                this.igloo_text.showBounds = false;
                this.igloo_text.text = "[PH]Get New Furniture";
                this.igloo_text.textColor = 0xFFFFFF;
                this.igloo_text.textHorizontalAlignment = "center";
                this.igloo_text.textSize = 10;
                this.igloo_text.textVerticalAlignment = "top";
                this.igloo_text.token = "";
                this.igloo_text.visible = true;
                this.igloo_text.wordWrapData = "";
                this.igloo_text.zrevision = "v2.1.1";
                try
                {
                    this.igloo_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_spend_text_endGameScreenMain_text_0():*
        {
            if (((this.__setPropDict[this.spend_text] == undefined) || (!(int(this.__setPropDict[this.spend_text]) == 1))))
            {
                this.__setPropDict[this.spend_text] = 1;
                try
                {
                    this.spend_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.spend_text.currentLang = "en";
                this.spend_text.debugColor = 0xCC00;
                this.spend_text.enabled = true;
                this.spend_text.font = "cpBurbankSmallBold";
                this.spend_text.globalMinFontSize = 8;
                this.spend_text.globalScaling = true;
                this.spend_text.globalWordWrap = false;
                this.spend_text.groupName = "[none]";
                this.spend_text.textHorizontalAlignment = "center";
                this.spend_text.langControl = false;
                this.spend_text.ltcFilters = "";
                this.spend_text.minFontSizeData = "";
                this.spend_text.scalingData = "";
                this.spend_text.showBounds = false;
                this.spend_text.textSize = 12;
                this.spend_text.text = "[PH]Places to Spend Your Coins";
                this.spend_text.textColor = 0xFFFFFF;
                this.spend_text.token = "";
                this.spend_text.textVerticalAlignment = "center";
                this.spend_text.visible = true;
                this.spend_text.wordWrapData = "";
                this.spend_text.zrevision = "v2.1.1";
                try
                {
                    this.spend_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_gameTitle_text_endGameScreenMain_text_2():*
        {
            if (((this.__setPropDict[this.gameTitle_text] == undefined) || (!(int(this.__setPropDict[this.gameTitle_text]) == 3))))
            {
                this.__setPropDict[this.gameTitle_text] = 3;
                try
                {
                    this.gameTitle_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.gameTitle_text.currentLang = "en";
                this.gameTitle_text.debugColor = 0xCC00;
                this.gameTitle_text.enabled = true;
                this.gameTitle_text.font = "cpBurbankSmallBold";
                this.gameTitle_text.globalMinFontSize = 8;
                this.gameTitle_text.globalScaling = true;
                this.gameTitle_text.globalWordWrap = false;
                this.gameTitle_text.groupName = "[none]";
                this.gameTitle_text.textHorizontalAlignment = "center";
                this.gameTitle_text.langControl = false;
                this.gameTitle_text.ltcFilters = "dropShadowFilter,45,5,5,,#003567ff,,0,,false,,,false,false,low,,,20,";
                this.gameTitle_text.minFontSizeData = "";
                this.gameTitle_text.scalingData = "";
                this.gameTitle_text.showBounds = false;
                this.gameTitle_text.textSize = 26;
                this.gameTitle_text.text = "Hydro-Hopper";
                this.gameTitle_text.textColor = 0xFFFFFF;
                this.gameTitle_text.token = "";
                this.gameTitle_text.textVerticalAlignment = "center";
                this.gameTitle_text.visible = true;
                this.gameTitle_text.wordWrapData = "";
                this.gameTitle_text.zrevision = "v2.1.1";
                try
                {
                    this.gameTitle_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_spend_text_endGameScreenMain_text_2():*
        {
            if (((this.__setPropDict[this.spend_text] == undefined) || (!(int(this.__setPropDict[this.spend_text]) == 3))))
            {
                this.__setPropDict[this.spend_text] = 3;
                try
                {
                    this.spend_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.spend_text.currentLang = "en";
                this.spend_text.debugColor = 0xCC00;
                this.spend_text.enabled = true;
                this.spend_text.font = "cpBurbankSmallBold";
                this.spend_text.globalMinFontSize = 8;
                this.spend_text.globalScaling = true;
                this.spend_text.globalWordWrap = false;
                this.spend_text.groupName = "[none]";
                this.spend_text.textHorizontalAlignment = "center";
                this.spend_text.langControl = false;
                this.spend_text.ltcFilters = "";
                this.spend_text.minFontSizeData = "";
                this.spend_text.scalingData = "";
                this.spend_text.showBounds = false;
                this.spend_text.textSize = 12;
                this.spend_text.text = "Places to Spend Your Coins";
                this.spend_text.textColor = 0xFFFFFF;
                this.spend_text.token = "";
                this.spend_text.textVerticalAlignment = "center";
                this.spend_text.visible = true;
                this.spend_text.wordWrapData = "";
                this.spend_text.zrevision = "v2.1.1";
                try
                {
                    this.spend_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_done_text_endGameScreenMain_text_2():*
        {
            if (((this.__setPropDict[this.done_text] == undefined) || (!(int(this.__setPropDict[this.done_text]) == 3))))
            {
                this.__setPropDict[this.done_text] = 3;
                try
                {
                    this.done_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.done_text.currentLang = "en";
                this.done_text.debugColor = 0xCC00;
                this.done_text.enabled = true;
                this.done_text.font = "cpBurbankSmallBold";
                this.done_text.globalMinFontSize = 8;
                this.done_text.globalScaling = true;
                this.done_text.globalWordWrap = false;
                this.done_text.groupName = "[none]";
                this.done_text.langControl = false;
                this.done_text.ltcFilters = "dropShadowFilter,45,4,4,,#003567ff,,0,,false,,,false,false,low,,,20,";
                this.done_text.minFontSizeData = "";
                this.done_text.scalingData = "";
                this.done_text.showBounds = false;
                this.done_text.text = "Done";
                this.done_text.textColor = 0xFFFFFF;
                this.done_text.textHorizontalAlignment = "center";
                this.done_text.textSize = 20;
                this.done_text.textVerticalAlignment = "center";
                this.done_text.token = "";
                this.done_text.visible = true;
                this.done_text.wordWrapData = "";
                this.done_text.zrevision = "v2.1.1";
                try
                {
                    this.done_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_clothes_text_endGameScreenMain_text_2():*
        {
            if (((this.__setPropDict[this.clothes_text] == undefined) || (!(int(this.__setPropDict[this.clothes_text]) == 3))))
            {
                this.__setPropDict[this.clothes_text] = 3;
                try
                {
                    this.clothes_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.clothes_text.currentLang = "en";
                this.clothes_text.debugColor = 0xCC00;
                this.clothes_text.enabled = true;
                this.clothes_text.font = "cpBurbankSmallBold";
                this.clothes_text.globalMinFontSize = 8;
                this.clothes_text.globalScaling = true;
                this.clothes_text.globalWordWrap = false;
                this.clothes_text.groupName = "[none]";
                this.clothes_text.langControl = false;
                this.clothes_text.ltcFilters = "dropShadowFilter,45,4,4,,#0051a0ff,,0,,false,,,false,false,low,,,20,";
                this.clothes_text.minFontSizeData = "";
                this.clothes_text.scalingData = "";
                this.clothes_text.showBounds = false;
                this.clothes_text.text = "Get New Styles";
                this.clothes_text.textColor = 0xFFFFFF;
                this.clothes_text.textHorizontalAlignment = "center";
                this.clothes_text.textSize = 10;
                this.clothes_text.textVerticalAlignment = "top";
                this.clothes_text.token = "";
                this.clothes_text.visible = true;
                this.clothes_text.wordWrapData = "";
                this.clothes_text.zrevision = "v2.1.1";
                try
                {
                    this.clothes_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_pet_text_endGameScreenMain_text_2():*
        {
            if (((this.__setPropDict[this.pet_text] == undefined) || (!(int(this.__setPropDict[this.pet_text]) == 3))))
            {
                this.__setPropDict[this.pet_text] = 3;
                try
                {
                    this.pet_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.pet_text.currentLang = "en";
                this.pet_text.debugColor = 0xCC00;
                this.pet_text.enabled = true;
                this.pet_text.font = "cpBurbankSmallBold";
                this.pet_text.globalMinFontSize = 8;
                this.pet_text.globalScaling = true;
                this.pet_text.globalWordWrap = false;
                this.pet_text.groupName = "[none]";
                this.pet_text.langControl = false;
                this.pet_text.ltcFilters = "dropShadowFilter,45,4,4,,#0051a0ff,,0,,false,,,false,false,low,,,20,";
                this.pet_text.minFontSizeData = "";
                this.pet_text.scalingData = "";
                this.pet_text.showBounds = false;
                this.pet_text.text = "Adopt a Pet";
                this.pet_text.textColor = 0xFFFFFF;
                this.pet_text.textHorizontalAlignment = "center";
                this.pet_text.textSize = 10;
                this.pet_text.textVerticalAlignment = "top";
                this.pet_text.token = "";
                this.pet_text.visible = true;
                this.pet_text.wordWrapData = "";
                this.pet_text.zrevision = "v2.1.1";
                try
                {
                    this.pet_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_igloo_text_endGameScreenMain_text_2():*
        {
            if (((this.__setPropDict[this.igloo_text] == undefined) || (!(int(this.__setPropDict[this.igloo_text]) == 3))))
            {
                this.__setPropDict[this.igloo_text] = 3;
                try
                {
                    this.igloo_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.igloo_text.currentLang = "en";
                this.igloo_text.debugColor = 0xCC00;
                this.igloo_text.enabled = true;
                this.igloo_text.font = "cpBurbankSmallBold";
                this.igloo_text.globalMinFontSize = 8;
                this.igloo_text.globalScaling = true;
                this.igloo_text.globalWordWrap = false;
                this.igloo_text.groupName = "[none]";
                this.igloo_text.langControl = false;
                this.igloo_text.ltcFilters = "dropShadowFilter,45,4,4,,#0051a0ff,,0,,false,,,false,false,low,,,20,";
                this.igloo_text.minFontSizeData = "";
                this.igloo_text.scalingData = "";
                this.igloo_text.showBounds = false;
                this.igloo_text.text = "Get New Furniture";
                this.igloo_text.textColor = 0xFFFFFF;
                this.igloo_text.textHorizontalAlignment = "center";
                this.igloo_text.textSize = 10;
                this.igloo_text.textVerticalAlignment = "top";
                this.igloo_text.token = "";
                this.igloo_text.visible = true;
                this.igloo_text.wordWrapData = "";
                this.igloo_text.zrevision = "v2.1.1";
                try
                {
                    this.igloo_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_gameTitle_text_endGameScreenMain_text_4():*
        {
            if (((this.__setPropDict[this.gameTitle_text] == undefined) || (!(int(this.__setPropDict[this.gameTitle_text]) == 5))))
            {
                this.__setPropDict[this.gameTitle_text] = 5;
                try
                {
                    this.gameTitle_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.gameTitle_text.currentLang = "en";
                this.gameTitle_text.debugColor = 0xCC00;
                this.gameTitle_text.enabled = true;
                this.gameTitle_text.font = "cpBurbankSmallBold";
                this.gameTitle_text.globalMinFontSize = 8;
                this.gameTitle_text.globalScaling = true;
                this.gameTitle_text.globalWordWrap = false;
                this.gameTitle_text.groupName = "[none]";
                this.gameTitle_text.textHorizontalAlignment = "center";
                this.gameTitle_text.langControl = false;
                this.gameTitle_text.ltcFilters = "dropShadowFilter,45,5,5,,#003567ff,,0,,false,,,false,false,low,,,20,";
                this.gameTitle_text.minFontSizeData = "";
                this.gameTitle_text.scalingData = "";
                this.gameTitle_text.showBounds = false;
                this.gameTitle_text.textSize = 26;
                this.gameTitle_text.text = "Hydro-Hopper";
                this.gameTitle_text.textColor = 0xFFFFFF;
                this.gameTitle_text.token = "";
                this.gameTitle_text.textVerticalAlignment = "center";
                this.gameTitle_text.visible = true;
                this.gameTitle_text.wordWrapData = "";
                this.gameTitle_text.zrevision = "v2.1.1";
                try
                {
                    this.gameTitle_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_done_text_endGameScreenMain_text_4():*
        {
            if (((this.__setPropDict[this.done_text] == undefined) || (!(int(this.__setPropDict[this.done_text]) == 5))))
            {
                this.__setPropDict[this.done_text] = 5;
                try
                {
                    this.done_text["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.done_text.currentLang = "en";
                this.done_text.debugColor = 0xCC00;
                this.done_text.enabled = true;
                this.done_text.font = "cpBurbankSmallBold";
                this.done_text.globalMinFontSize = 8;
                this.done_text.globalScaling = true;
                this.done_text.globalWordWrap = false;
                this.done_text.groupName = "[none]";
                this.done_text.textHorizontalAlignment = "center";
                this.done_text.langControl = false;
                this.done_text.ltcFilters = "dropShadowFilter,45,4,4,,#003567ff,,0,,false,,,false,false,low,,,20,";
                this.done_text.minFontSizeData = "";
                this.done_text.scalingData = "";
                this.done_text.showBounds = false;
                this.done_text.textSize = 20;
                this.done_text.text = "Done";
                this.done_text.textColor = 0xFFFFFF;
                this.done_text.token = "";
                this.done_text.textVerticalAlignment = "center";
                this.done_text.visible = true;
                this.done_text.wordWrapData = "";
                this.done_text.zrevision = "v2.1.1";
                try
                {
                    this.done_text["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function frame1():*
        {
            this.__setProp_spend_text_endGameScreenMain_text_0();
            this.__setProp_igloo_text_endGameScreenMain_text_0();
            this.__setProp_pet_text_endGameScreenMain_text_0();
            this.__setProp_clothes_text_endGameScreenMain_text_0();
            this.__setProp_done_text_endGameScreenMain_text_0();
            this.__setProp_gameTitle_text_endGameScreenMain_text_0();
            stop();
        }

        internal function frame3():*
        {
            this.__setProp_igloo_text_endGameScreenMain_text_2();
            this.__setProp_pet_text_endGameScreenMain_text_2();
            this.__setProp_clothes_text_endGameScreenMain_text_2();
            this.__setProp_done_text_endGameScreenMain_text_2();
            this.__setProp_spend_text_endGameScreenMain_text_2();
            this.__setProp_gameTitle_text_endGameScreenMain_text_2();
        }

        internal function frame5():*
        {
            this.__setProp_done_text_endGameScreenMain_text_4();
            this.__setProp_gameTitle_text_endGameScreenMain_text_4();
        }


    }
}//package end_screen_main_fla
