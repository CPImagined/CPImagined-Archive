//Created by Action Script Viewer - https://www.buraks.com/asv
package puffleCongrats_fla
{
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.LocalTextComponent;
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

    public dynamic class puffleCongrats_ALL_1 extends MovieClip 
    {

        public var hasChosen_txt:LocalTextComponent;//instance name
        public var congratsDescription_txt:LocalTextComponent;//instance name
        public var puffleNameText:LocalTextComponent;//instance name
        public var date_txt:LocalTextComponent;//instance name
        public var wasAdopted_txt:LocalTextComponent;//instance name
        public var locationText:LocalTextComponent;//instance name
        public var tintClip:MovieClip;//instance name
        public var locationWildText:LocalTextComponent;//instance name
        public var adoptionCertificateTitle_mc:MovieClip;//instance name
        public var inventoryList:MovieClip;//instance name
        public var congratsTitle_txt:LocalTextComponent;//instance name
        public var closeButton:MovieClip;//instance name
        public var iconBackyardClean:MovieClip;//instance name
        public var okButton_mc:MovieClip;//instance name
        public var careOfPuffle_txt:LocalTextComponent;//instance name
        public var buttonText:LocalTextComponent;//instance name
        public var __setPropDict:Dictionary = new Dictionary(true);
        public var __lastFrameProp:int = -1;

        public function puffleCongrats_ALL_1()
        {
            addFrameScript(0, this.frame1, 22, this.frame23, 10, this.frame11, 11, this.frame12, 20, this.frame21, 21, this.frame22, 23, this.frame24, 24, this.frame25, 12, this.frame13, 13, this.frame14, 25, this.frame26, 26, this.frame27, 27, this.frame28, 28, this.frame29, 29, this.frame30);
            addEventListener(Event.FRAME_CONSTRUCTED, this.__setProp_handler, false, 0, true);
        }

        internal function __setProp_congratsTitle_txt_puffleCongrats_ALL_tintedcomponents_0(_arg_1:int):*
        {
            if (((((!(this.congratsTitle_txt == null)) && (_arg_1 >= 1)) && (_arg_1 <= 10)) && ((this.__setPropDict[this.congratsTitle_txt] == undefined) || (!((int(this.__setPropDict[this.congratsTitle_txt]) >= 1) && (int(this.__setPropDict[this.congratsTitle_txt]) <= 10))))))
            {
                this.__setPropDict[this.congratsTitle_txt] = _arg_1;
                try
                {
                    this.congratsTitle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.congratsTitle_txt.currentLang = "en";
                this.congratsTitle_txt.debugColor = 0xCC00;
                this.congratsTitle_txt.enabled = true;
                this.congratsTitle_txt.font = "Catseye Cyrillic Bold";
                this.congratsTitle_txt.globalMinFontSize = 8;
                this.congratsTitle_txt.globalScaling = true;
                this.congratsTitle_txt.globalWordWrap = false;
                this.congratsTitle_txt.groupName = "[none]";
                this.congratsTitle_txt.langControl = false;
                this.congratsTitle_txt.ltcFilters = "";
                this.congratsTitle_txt.minFontSizeData = "";
                this.congratsTitle_txt.scalingData = "";
                this.congratsTitle_txt.showBounds = false;
                this.congratsTitle_txt.text = "Congratulations!";
                this.congratsTitle_txt.textColor = 0x333333;
                this.congratsTitle_txt.textHorizontalAlignment = "center";
                this.congratsTitle_txt.textSize = 38;
                this.congratsTitle_txt.textVerticalAlignment = "center";
                this.congratsTitle_txt.token = "w.puffleadoption.gold.congratulations.title";
                this.congratsTitle_txt.visible = true;
                this.congratsTitle_txt.wordWrapData = "";
                this.congratsTitle_txt.zrevision = "v2.1.1";
                try
                {
                    this.congratsTitle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_new_0(_arg_1:int):*
        {
            if (((((!(this.puffleNameText == null)) && (_arg_1 >= 1)) && (_arg_1 <= 10)) && ((this.__setPropDict[this.puffleNameText] == undefined) || (!((int(this.__setPropDict[this.puffleNameText]) >= 1) && (int(this.__setPropDict[this.puffleNameText]) <= 10))))))
            {
                this.__setPropDict[this.puffleNameText] = _arg_1;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "happy";
                this.puffleNameText.textColor = 0x333333;
                this.puffleNameText.textHorizontalAlignment = "center";
                this.puffleNameText.textSize = 18;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_congratsDescription_txt_puffleCongrats_ALL_components_0(_arg_1:int):*
        {
            if (((((!(this.congratsDescription_txt == null)) && (_arg_1 >= 1)) && (_arg_1 <= 10)) && ((this.__setPropDict[this.congratsDescription_txt] == undefined) || (!((int(this.__setPropDict[this.congratsDescription_txt]) >= 1) && (int(this.__setPropDict[this.congratsDescription_txt]) <= 10))))))
            {
                this.__setPropDict[this.congratsDescription_txt] = _arg_1;
                try
                {
                    this.congratsDescription_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.congratsDescription_txt.currentLang = "en";
                this.congratsDescription_txt.debugColor = 0xCC00;
                this.congratsDescription_txt.enabled = true;
                this.congratsDescription_txt.font = "cpBurbankSmall";
                this.congratsDescription_txt.globalMinFontSize = 8;
                this.congratsDescription_txt.globalScaling = true;
                this.congratsDescription_txt.globalWordWrap = false;
                this.congratsDescription_txt.groupName = "[none]";
                this.congratsDescription_txt.textHorizontalAlignment = "left";
                this.congratsDescription_txt.langControl = false;
                this.congratsDescription_txt.ltcFilters = "";
                this.congratsDescription_txt.minFontSizeData = "";
                this.congratsDescription_txt.scalingData = "";
                this.congratsDescription_txt.showBounds = false;
                this.congratsDescription_txt.textSize = 13;
                this.congratsDescription_txt.text = "Your new puffle comes with:";
                this.congratsDescription_txt.textColor = 0;
                this.congratsDescription_txt.token = "w.puffleadoption.congratulations.items";
                this.congratsDescription_txt.visible = true;
                this.congratsDescription_txt.textVerticalAlignment = "top";
                this.congratsDescription_txt.wordWrapData = "";
                this.congratsDescription_txt.zrevision = "v2.1.1";
                try
                {
                    this.congratsDescription_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationText_puffleCongrats_ALL_components_0(_arg_1:int):*
        {
            if (((((!(this.locationText == null)) && (_arg_1 >= 1)) && (_arg_1 <= 10)) && ((this.__setPropDict[this.locationText] == undefined) || (!((int(this.__setPropDict[this.locationText]) >= 1) && (int(this.__setPropDict[this.locationText]) <= 10))))))
            {
                this.__setPropDict[this.locationText] = _arg_1;
                try
                {
                    this.locationText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationText.currentLang = "en";
                this.locationText.debugColor = 0xCC00;
                this.locationText.enabled = true;
                this.locationText.font = "cpBurbankSmall";
                this.locationText.globalMinFontSize = 8;
                this.locationText.globalScaling = true;
                this.locationText.globalWordWrap = true;
                this.locationText.groupName = "[none]";
                this.locationText.langControl = false;
                this.locationText.ltcFilters = "";
                this.locationText.minFontSizeData = "";
                this.locationText.scalingData = "";
                this.locationText.showBounds = false;
                this.locationText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationText.textColor = 0;
                this.locationText.textHorizontalAlignment = "left";
                this.locationText.textSize = 11;
                this.locationText.textVerticalAlignment = "top";
                this.locationText.token = "";
                this.locationText.visible = true;
                this.locationText.wordWrapData = "";
                this.locationText.zrevision = "v2.1.1";
                try
                {
                    this.locationText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_buttonText_puffleCongrats_ALL_components_0(_arg_1:int):*
        {
            if (((((!(this.buttonText == null)) && (_arg_1 >= 1)) && (_arg_1 <= 11)) && ((this.__setPropDict[this.buttonText] == undefined) || (!((int(this.__setPropDict[this.buttonText]) >= 1) && (int(this.__setPropDict[this.buttonText]) <= 11))))))
            {
                this.__setPropDict[this.buttonText] = _arg_1;
                try
                {
                    this.buttonText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.buttonText.currentLang = "en";
                this.buttonText.debugColor = 0xCC00;
                this.buttonText.enabled = true;
                this.buttonText.font = "cpBurbankSmallBold";
                this.buttonText.globalMinFontSize = 8;
                this.buttonText.globalScaling = true;
                this.buttonText.globalWordWrap = false;
                this.buttonText.groupName = "[none]";
                this.buttonText.langControl = false;
                this.buttonText.ltcFilters = "";
                this.buttonText.minFontSizeData = "";
                this.buttonText.scalingData = "";
                this.buttonText.showBounds = false;
                this.buttonText.text = "OK";
                this.buttonText.textColor = 0xFFFFFF;
                this.buttonText.textHorizontalAlignment = "center";
                this.buttonText.textSize = 18;
                this.buttonText.textVerticalAlignment = "center";
                this.buttonText.token = "w.puffleadoption.gold.poster.memberbutton";
                this.buttonText.visible = true;
                this.buttonText.wordWrapData = "";
                this.buttonText.zrevision = "v2.1.1";
                try
                {
                    this.buttonText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_buttonText_puffleCongrats_ALL_components_11(_arg_1:int):*
        {
            if (((((!(this.buttonText == null)) && (_arg_1 >= 12)) && (_arg_1 <= 22)) && ((this.__setPropDict[this.buttonText] == undefined) || (!((int(this.__setPropDict[this.buttonText]) >= 12) && (int(this.__setPropDict[this.buttonText]) <= 22))))))
            {
                this.__setPropDict[this.buttonText] = _arg_1;
                try
                {
                    this.buttonText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.buttonText.currentLang = "en";
                this.buttonText.debugColor = 0xCC00;
                this.buttonText.enabled = true;
                this.buttonText.font = "cpBurbankSmallBold";
                this.buttonText.globalMinFontSize = 8;
                this.buttonText.globalScaling = true;
                this.buttonText.globalWordWrap = false;
                this.buttonText.groupName = "[none]";
                this.buttonText.textHorizontalAlignment = "center";
                this.buttonText.langControl = false;
                this.buttonText.ltcFilters = "";
                this.buttonText.minFontSizeData = "";
                this.buttonText.scalingData = "";
                this.buttonText.showBounds = false;
                this.buttonText.textSize = 18;
                this.buttonText.text = "OK";
                this.buttonText.textColor = 0xFFFFFF;
                this.buttonText.token = "w.puffleadoption.gold.poster.memberbutton";
                this.buttonText.visible = true;
                this.buttonText.textVerticalAlignment = "center";
                this.buttonText.wordWrapData = "";
                this.buttonText.zrevision = "v2.1.1";
                try
                {
                    this.buttonText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_buttonText_puffleCongrats_ALL_components_22():*
        {
            if (((this.__setPropDict[this.buttonText] == undefined) || (!(int(this.__setPropDict[this.buttonText]) == 23))))
            {
                this.__setPropDict[this.buttonText] = 23;
                try
                {
                    this.buttonText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.buttonText.currentLang = "en";
                this.buttonText.debugColor = 0xCC00;
                this.buttonText.enabled = true;
                this.buttonText.font = "cpBurbankSmallBold";
                this.buttonText.globalMinFontSize = 8;
                this.buttonText.globalScaling = true;
                this.buttonText.globalWordWrap = false;
                this.buttonText.groupName = "[none]";
                this.buttonText.langControl = false;
                this.buttonText.ltcFilters = "";
                this.buttonText.minFontSizeData = "";
                this.buttonText.scalingData = "";
                this.buttonText.showBounds = false;
                this.buttonText.text = "OK";
                this.buttonText.textColor = 0xFFFFFF;
                this.buttonText.textHorizontalAlignment = "center";
                this.buttonText.textSize = 18;
                this.buttonText.textVerticalAlignment = "center";
                this.buttonText.token = "w.puffleadoption.gold.poster.memberbutton";
                this.buttonText.visible = true;
                this.buttonText.wordWrapData = "";
                this.buttonText.zrevision = "v2.1.1";
                try
                {
                    this.buttonText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_buttonText_puffleCongrats_ALL_components_23(_arg_1:int):*
        {
            if (((((!(this.buttonText == null)) && (_arg_1 >= 24)) && (_arg_1 <= 25)) && ((this.__setPropDict[this.buttonText] == undefined) || (!((int(this.__setPropDict[this.buttonText]) >= 24) && (int(this.__setPropDict[this.buttonText]) <= 25))))))
            {
                this.__setPropDict[this.buttonText] = _arg_1;
                try
                {
                    this.buttonText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.buttonText.currentLang = "en";
                this.buttonText.debugColor = 0xCC00;
                this.buttonText.enabled = true;
                this.buttonText.font = "cpBurbankSmallBold";
                this.buttonText.globalMinFontSize = 8;
                this.buttonText.globalScaling = true;
                this.buttonText.globalWordWrap = false;
                this.buttonText.groupName = "[none]";
                this.buttonText.textHorizontalAlignment = "center";
                this.buttonText.langControl = false;
                this.buttonText.ltcFilters = "";
                this.buttonText.minFontSizeData = "";
                this.buttonText.scalingData = "";
                this.buttonText.showBounds = false;
                this.buttonText.textSize = 18;
                this.buttonText.text = "OK";
                this.buttonText.textColor = 0xFFFFFF;
                this.buttonText.token = "w.puffleadoption.gold.poster.memberbutton";
                this.buttonText.visible = true;
                this.buttonText.textVerticalAlignment = "center";
                this.buttonText.wordWrapData = "";
                this.buttonText.zrevision = "v2.1.1";
                try
                {
                    this.buttonText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_buttonText_puffleCongrats_ALL_components_25(_arg_1:int):*
        {
            if (((((!(this.buttonText == null)) && (_arg_1 >= 26)) && (_arg_1 <= 30)) && ((this.__setPropDict[this.buttonText] == undefined) || (!((int(this.__setPropDict[this.buttonText]) >= 26) && (int(this.__setPropDict[this.buttonText]) <= 30))))))
            {
                this.__setPropDict[this.buttonText] = _arg_1;
                try
                {
                    this.buttonText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.buttonText.currentLang = "en";
                this.buttonText.debugColor = 0xCC00;
                this.buttonText.enabled = true;
                this.buttonText.font = "cpBurbankSmallBold";
                this.buttonText.globalMinFontSize = 8;
                this.buttonText.globalScaling = true;
                this.buttonText.globalWordWrap = false;
                this.buttonText.groupName = "[none]";
                this.buttonText.langControl = false;
                this.buttonText.ltcFilters = "";
                this.buttonText.minFontSizeData = "";
                this.buttonText.scalingData = "";
                this.buttonText.showBounds = false;
                this.buttonText.text = "OK";
                this.buttonText.textColor = 0xFFFFFF;
                this.buttonText.textHorizontalAlignment = "center";
                this.buttonText.textSize = 18;
                this.buttonText.textVerticalAlignment = "center";
                this.buttonText.token = "w.puffleadoption.gold.poster.memberbutton";
                this.buttonText.visible = true;
                this.buttonText.wordWrapData = "";
                this.buttonText.zrevision = "v2.1.1";
                try
                {
                    this.buttonText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_10():*
        {
            if (((this.__setPropDict[this.locationWildText] == undefined) || (!(int(this.__setPropDict[this.locationWildText]) == 11))))
            {
                this.__setPropDict[this.locationWildText] = 11;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or\nbackyard when you're not walking it!";
                this.locationWildText.textColor = 0x9B3000;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_11():*
        {
            if (((this.__setPropDict[this.locationWildText] == undefined) || (!(int(this.__setPropDict[this.locationWildText]) == 12))))
            {
                this.__setPropDict[this.locationWildText] = 12;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 3494487;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_12(_arg_1:int):*
        {
            if (((((!(this.locationWildText == null)) && (_arg_1 >= 13)) && (_arg_1 <= 14)) && ((this.__setPropDict[this.locationWildText] == undefined) || (!((int(this.__setPropDict[this.locationWildText]) >= 13) && (int(this.__setPropDict[this.locationWildText]) <= 14))))))
            {
                this.__setPropDict[this.locationWildText] = _arg_1;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 0xFF990000;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_14(_arg_1:int):*
        {
            if (((((!(this.locationWildText == null)) && (_arg_1 >= 15)) && (_arg_1 <= 16)) && ((this.__setPropDict[this.locationWildText] == undefined) || (!((int(this.__setPropDict[this.locationWildText]) >= 15) && (int(this.__setPropDict[this.locationWildText]) <= 16))))))
            {
                this.__setPropDict[this.locationWildText] = _arg_1;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 0xFF006600;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_16(_arg_1:int):*
        {
            if (((((!(this.locationWildText == null)) && (_arg_1 >= 17)) && (_arg_1 <= 18)) && ((this.__setPropDict[this.locationWildText] == undefined) || (!((int(this.__setPropDict[this.locationWildText]) >= 17) && (int(this.__setPropDict[this.locationWildText]) <= 18))))))
            {
                this.__setPropDict[this.locationWildText] = _arg_1;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 3494487;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_18(_arg_1:int):*
        {
            if (((((!(this.locationWildText == null)) && (_arg_1 >= 19)) && (_arg_1 <= 20)) && ((this.__setPropDict[this.locationWildText] == undefined) || (!((int(this.__setPropDict[this.locationWildText]) >= 19) && (int(this.__setPropDict[this.locationWildText]) <= 20))))))
            {
                this.__setPropDict[this.locationWildText] = _arg_1;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 4283835720;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_20():*
        {
            if (((this.__setPropDict[this.locationWildText] == undefined) || (!(int(this.__setPropDict[this.locationWildText]) == 21))))
            {
                this.__setPropDict[this.locationWildText] = 21;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 3879231;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_21():*
        {
            if (((this.__setPropDict[this.locationWildText] == undefined) || (!(int(this.__setPropDict[this.locationWildText]) == 22))))
            {
                this.__setPropDict[this.locationWildText] = 22;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 0xAA3E00;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_22():*
        {
            if (((this.__setPropDict[this.locationWildText] == undefined) || (!(int(this.__setPropDict[this.locationWildText]) == 23))))
            {
                this.__setPropDict[this.locationWildText] = 23;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 0x333333;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_23():*
        {
            if (((this.__setPropDict[this.locationWildText] == undefined) || (!(int(this.__setPropDict[this.locationWildText]) == 24))))
            {
                this.__setPropDict[this.locationWildText] = 24;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 5132115;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_locationWildText_puffleCongrats_ALL_components_24(_arg_1:int):*
        {
            if (((((!(this.locationWildText == null)) && (_arg_1 >= 25)) && (_arg_1 <= 30)) && ((this.__setPropDict[this.locationWildText] == undefined) || (!((int(this.__setPropDict[this.locationWildText]) >= 25) && (int(this.__setPropDict[this.locationWildText]) <= 30))))))
            {
                this.__setPropDict[this.locationWildText] = _arg_1;
                try
                {
                    this.locationWildText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.locationWildText.currentLang = "en";
                this.locationWildText.debugColor = 0xCC00;
                this.locationWildText.enabled = true;
                this.locationWildText.font = "cpBurbankSmall";
                this.locationWildText.globalMinFontSize = 8;
                this.locationWildText.globalScaling = false;
                this.locationWildText.globalWordWrap = true;
                this.locationWildText.groupName = "[none]";
                this.locationWildText.langControl = false;
                this.locationWildText.ltcFilters = "";
                this.locationWildText.minFontSizeData = "";
                this.locationWildText.scalingData = "";
                this.locationWildText.showBounds = false;
                this.locationWildText.text = "puffleName will be in your igloo or \nbackyard when you're not walking it!";
                this.locationWildText.textColor = 3299935;
                this.locationWildText.textHorizontalAlignment = "center";
                this.locationWildText.textSize = 12;
                this.locationWildText.textVerticalAlignment = "center";
                this.locationWildText.token = "";
                this.locationWildText.visible = true;
                this.locationWildText.wordWrapData = "";
                this.locationWildText.zrevision = "v2.1.1";
                try
                {
                    this.locationWildText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_10():*
        {
            if (((this.__setPropDict[this.puffleNameText] == undefined) || (!(int(this.__setPropDict[this.puffleNameText]) == 11))))
            {
                this.__setPropDict[this.puffleNameText] = 11;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 0x9C2F00;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_11():*
        {
            if (((this.__setPropDict[this.puffleNameText] == undefined) || (!(int(this.__setPropDict[this.puffleNameText]) == 12))))
            {
                this.__setPropDict[this.puffleNameText] = 12;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 3494487;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_12(_arg_1:int):*
        {
            if (((((!(this.puffleNameText == null)) && (_arg_1 >= 13)) && (_arg_1 <= 14)) && ((this.__setPropDict[this.puffleNameText] == undefined) || (!((int(this.__setPropDict[this.puffleNameText]) >= 13) && (int(this.__setPropDict[this.puffleNameText]) <= 14))))))
            {
                this.__setPropDict[this.puffleNameText] = _arg_1;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 0xFF660000;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_14(_arg_1:int):*
        {
            if (((((!(this.puffleNameText == null)) && (_arg_1 >= 15)) && (_arg_1 <= 16)) && ((this.__setPropDict[this.puffleNameText] == undefined) || (!((int(this.__setPropDict[this.puffleNameText]) >= 15) && (int(this.__setPropDict[this.puffleNameText]) <= 16))))))
            {
                this.__setPropDict[this.puffleNameText] = _arg_1;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 0x3D00;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_16(_arg_1:int):*
        {
            if (((((!(this.puffleNameText == null)) && (_arg_1 >= 17)) && (_arg_1 <= 18)) && ((this.__setPropDict[this.puffleNameText] == undefined) || (!((int(this.__setPropDict[this.puffleNameText]) >= 17) && (int(this.__setPropDict[this.puffleNameText]) <= 18))))))
            {
                this.__setPropDict[this.puffleNameText] = _arg_1;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 3494487;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_18(_arg_1:int):*
        {
            if (((((!(this.puffleNameText == null)) && (_arg_1 >= 19)) && (_arg_1 <= 20)) && ((this.__setPropDict[this.puffleNameText] == undefined) || (!((int(this.__setPropDict[this.puffleNameText]) >= 19) && (int(this.__setPropDict[this.puffleNameText]) <= 20))))))
            {
                this.__setPropDict[this.puffleNameText] = _arg_1;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 3679299;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_20():*
        {
            if (((this.__setPropDict[this.puffleNameText] == undefined) || (!(int(this.__setPropDict[this.puffleNameText]) == 21))))
            {
                this.__setPropDict[this.puffleNameText] = 21;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 4660053;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_21():*
        {
            if (((this.__setPropDict[this.puffleNameText] == undefined) || (!(int(this.__setPropDict[this.puffleNameText]) == 22))))
            {
                this.__setPropDict[this.puffleNameText] = 22;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 6822146;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_22():*
        {
            if (((this.__setPropDict[this.puffleNameText] == undefined) || (!(int(this.__setPropDict[this.puffleNameText]) == 23))))
            {
                this.__setPropDict[this.puffleNameText] = 23;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 2563866;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_23():*
        {
            if (((this.__setPropDict[this.puffleNameText] == undefined) || (!(int(this.__setPropDict[this.puffleNameText]) == 24))))
            {
                this.__setPropDict[this.puffleNameText] = 24;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 5132115;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_24():*
        {
            if (((this.__setPropDict[this.puffleNameText] == undefined) || (!(int(this.__setPropDict[this.puffleNameText]) == 25))))
            {
                this.__setPropDict[this.puffleNameText] = 25;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 3299935;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_25(_arg_1:int):*
        {
            if (((((!(this.puffleNameText == null)) && (_arg_1 >= 26)) && (_arg_1 <= 27)) && ((this.__setPropDict[this.puffleNameText] == undefined) || (!((int(this.__setPropDict[this.puffleNameText]) >= 26) && (int(this.__setPropDict[this.puffleNameText]) <= 27))))))
            {
                this.__setPropDict[this.puffleNameText] = _arg_1;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 0xFFFFFF;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_10():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 11))))
            {
                this.__setPropDict[this.hasChosen_txt] = 11;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 13073212;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_11():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 12))))
            {
                this.__setPropDict[this.hasChosen_txt] = 12;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 7581883;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_12():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 13))))
            {
                this.__setPropDict[this.hasChosen_txt] = 13;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 13864330;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_13():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 14))))
            {
                this.__setPropDict[this.hasChosen_txt] = 14;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 0xFF990000;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_14(_arg_1:int):*
        {
            if (((((!(this.hasChosen_txt == null)) && (_arg_1 >= 15)) && (_arg_1 <= 16)) && ((this.__setPropDict[this.hasChosen_txt] == undefined) || (!((int(this.__setPropDict[this.hasChosen_txt]) >= 15) && (int(this.__setPropDict[this.hasChosen_txt]) <= 16))))))
            {
                this.__setPropDict[this.hasChosen_txt] = _arg_1;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 7914608;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_16(_arg_1:int):*
        {
            if (((((!(this.hasChosen_txt == null)) && (_arg_1 >= 17)) && (_arg_1 <= 18)) && ((this.__setPropDict[this.hasChosen_txt] == undefined) || (!((int(this.__setPropDict[this.hasChosen_txt]) >= 17) && (int(this.__setPropDict[this.hasChosen_txt]) <= 18))))))
            {
                this.__setPropDict[this.hasChosen_txt] = _arg_1;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 7581883;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_18(_arg_1:int):*
        {
            if (((((!(this.hasChosen_txt == null)) && (_arg_1 >= 19)) && (_arg_1 <= 20)) && ((this.__setPropDict[this.hasChosen_txt] == undefined) || (!((int(this.__setPropDict[this.hasChosen_txt]) >= 19) && (int(this.__setPropDict[this.hasChosen_txt]) <= 20))))))
            {
                this.__setPropDict[this.hasChosen_txt] = _arg_1;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 12422319;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_20():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 21))))
            {
                this.__setPropDict[this.hasChosen_txt] = 21;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 11045299;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_21():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 22))))
            {
                this.__setPropDict[this.hasChosen_txt] = 22;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 14195824;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_22():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 23))))
            {
                this.__setPropDict[this.hasChosen_txt] = 23;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 0x9B9B9B;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_23():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 24))))
            {
                this.__setPropDict[this.hasChosen_txt] = 24;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 4288190611;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_24():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 25))))
            {
                this.__setPropDict[this.hasChosen_txt] = 25;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 10995392;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_25():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 26))))
            {
                this.__setPropDict[this.hasChosen_txt] = 26;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 4293459442;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_10():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 11))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 11;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 13073212;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_11():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 12))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 12;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 7581883;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_12():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 13))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 13;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 13864330;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_13():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 14))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 14;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 0xFF990000;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_14(_arg_1:int):*
        {
            if (((((!(this.wasAdopted_txt == null)) && (_arg_1 >= 15)) && (_arg_1 <= 16)) && ((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!((int(this.__setPropDict[this.wasAdopted_txt]) >= 15) && (int(this.__setPropDict[this.wasAdopted_txt]) <= 16))))))
            {
                this.__setPropDict[this.wasAdopted_txt] = _arg_1;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 7914608;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_16(_arg_1:int):*
        {
            if (((((!(this.wasAdopted_txt == null)) && (_arg_1 >= 17)) && (_arg_1 <= 18)) && ((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!((int(this.__setPropDict[this.wasAdopted_txt]) >= 17) && (int(this.__setPropDict[this.wasAdopted_txt]) <= 18))))))
            {
                this.__setPropDict[this.wasAdopted_txt] = _arg_1;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 7581883;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_18(_arg_1:int):*
        {
            if (((((!(this.wasAdopted_txt == null)) && (_arg_1 >= 19)) && (_arg_1 <= 20)) && ((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!((int(this.__setPropDict[this.wasAdopted_txt]) >= 19) && (int(this.__setPropDict[this.wasAdopted_txt]) <= 20))))))
            {
                this.__setPropDict[this.wasAdopted_txt] = _arg_1;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 4290612399;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_20():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 21))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 21;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 11045299;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_21():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 22))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 22;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 14195824;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_22():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 23))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 23;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 0x9B9B9B;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_23():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 24))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 24;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 10000531;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_24():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 25))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 25;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 10995392;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_25():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 26))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 26;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 4292344302;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_26():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 27))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 27;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 4294438609;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_10():*
        {
            if (((this.__setPropDict[this.date_txt] == undefined) || (!(int(this.__setPropDict[this.date_txt]) == 11))))
            {
                this.__setPropDict[this.date_txt] = 11;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 9131306;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_11():*
        {
            if (((this.__setPropDict[this.date_txt] == undefined) || (!(int(this.__setPropDict[this.date_txt]) == 12))))
            {
                this.__setPropDict[this.date_txt] = 12;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.textSize = 12;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 5598062;
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_12(_arg_1:int):*
        {
            if (((((!(this.date_txt == null)) && (_arg_1 >= 13)) && (_arg_1 <= 14)) && ((this.__setPropDict[this.date_txt] == undefined) || (!((int(this.__setPropDict[this.date_txt]) >= 13) && (int(this.__setPropDict[this.date_txt]) <= 14))))))
            {
                this.__setPropDict[this.date_txt] = _arg_1;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 0xFF990000;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_14(_arg_1:int):*
        {
            if (((((!(this.date_txt == null)) && (_arg_1 >= 15)) && (_arg_1 <= 16)) && ((this.__setPropDict[this.date_txt] == undefined) || (!((int(this.__setPropDict[this.date_txt]) >= 15) && (int(this.__setPropDict[this.date_txt]) <= 16))))))
            {
                this.__setPropDict[this.date_txt] = _arg_1;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 0xFF006600;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_16(_arg_1:int):*
        {
            if (((((!(this.date_txt == null)) && (_arg_1 >= 17)) && (_arg_1 <= 18)) && ((this.__setPropDict[this.date_txt] == undefined) || (!((int(this.__setPropDict[this.date_txt]) >= 17) && (int(this.__setPropDict[this.date_txt]) <= 18))))))
            {
                this.__setPropDict[this.date_txt] = _arg_1;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.textSize = 12;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 5598062;
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_18(_arg_1:int):*
        {
            if (((((!(this.date_txt == null)) && (_arg_1 >= 19)) && (_arg_1 <= 20)) && ((this.__setPropDict[this.date_txt] == undefined) || (!((int(this.__setPropDict[this.date_txt]) >= 19) && (int(this.__setPropDict[this.date_txt]) <= 20))))))
            {
                this.__setPropDict[this.date_txt] = _arg_1;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 11550094;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_20():*
        {
            if (((this.__setPropDict[this.date_txt] == undefined) || (!(int(this.__setPropDict[this.date_txt]) == 21))))
            {
                this.__setPropDict[this.date_txt] = 21;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 4282069311;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_21():*
        {
            if (((this.__setPropDict[this.date_txt] == undefined) || (!(int(this.__setPropDict[this.date_txt]) == 22))))
            {
                this.__setPropDict[this.date_txt] = 22;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 0xAA3E00;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_22():*
        {
            if (((this.__setPropDict[this.date_txt] == undefined) || (!(int(this.__setPropDict[this.date_txt]) == 23))))
            {
                this.__setPropDict[this.date_txt] = 23;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 0x333333;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_23():*
        {
            if (((this.__setPropDict[this.date_txt] == undefined) || (!(int(this.__setPropDict[this.date_txt]) == 24))))
            {
                this.__setPropDict[this.date_txt] = 24;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 5132115;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_24(_arg_1:int):*
        {
            if (((((!(this.date_txt == null)) && (_arg_1 >= 25)) && (_arg_1 <= 26)) && ((this.__setPropDict[this.date_txt] == undefined) || (!((int(this.__setPropDict[this.date_txt]) >= 25) && (int(this.__setPropDict[this.date_txt]) <= 26))))))
            {
                this.__setPropDict[this.date_txt] = _arg_1;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 5598062;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_10():*
        {
            if (((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!(int(this.__setPropDict[this.careOfPuffle_txt]) == 11))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = 11;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 0x9B3000;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_11():*
        {
            if (((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!(int(this.__setPropDict[this.careOfPuffle_txt]) == 12))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = 12;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 3494487;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_12(_arg_1:int):*
        {
            if (((((!(this.careOfPuffle_txt == null)) && (_arg_1 >= 13)) && (_arg_1 <= 14)) && ((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!((int(this.__setPropDict[this.careOfPuffle_txt]) >= 13) && (int(this.__setPropDict[this.careOfPuffle_txt]) <= 14))))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = _arg_1;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 0xFF990000;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_14(_arg_1:int):*
        {
            if (((((!(this.careOfPuffle_txt == null)) && (_arg_1 >= 15)) && (_arg_1 <= 16)) && ((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!((int(this.__setPropDict[this.careOfPuffle_txt]) >= 15) && (int(this.__setPropDict[this.careOfPuffle_txt]) <= 16))))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = _arg_1;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 0xFF006600;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_16(_arg_1:int):*
        {
            if (((((!(this.careOfPuffle_txt == null)) && (_arg_1 >= 17)) && (_arg_1 <= 18)) && ((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!((int(this.__setPropDict[this.careOfPuffle_txt]) >= 17) && (int(this.__setPropDict[this.careOfPuffle_txt]) <= 18))))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = _arg_1;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 3494487;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_18(_arg_1:int):*
        {
            if (((((!(this.careOfPuffle_txt == null)) && (_arg_1 >= 19)) && (_arg_1 <= 20)) && ((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!((int(this.__setPropDict[this.careOfPuffle_txt]) >= 19) && (int(this.__setPropDict[this.careOfPuffle_txt]) <= 20))))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = _arg_1;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 5645640;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_20():*
        {
            if (((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!(int(this.__setPropDict[this.careOfPuffle_txt]) == 21))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = 21;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 3879231;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_21():*
        {
            if (((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!(int(this.__setPropDict[this.careOfPuffle_txt]) == 22))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = 22;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 0xAA3E00;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_22():*
        {
            if (((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!(int(this.__setPropDict[this.careOfPuffle_txt]) == 23))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = 23;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 0x333333;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_23():*
        {
            if (((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!(int(this.__setPropDict[this.careOfPuffle_txt]) == 24))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = 24;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 5132115;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_careOfPuffle_txt_puffleCongrats_ALL_components_24(_arg_1:int):*
        {
            if (((((!(this.careOfPuffle_txt == null)) && (_arg_1 >= 25)) && (_arg_1 <= 30)) && ((this.__setPropDict[this.careOfPuffle_txt] == undefined) || (!((int(this.__setPropDict[this.careOfPuffle_txt]) >= 25) && (int(this.__setPropDict[this.careOfPuffle_txt]) <= 30))))))
            {
                this.__setPropDict[this.careOfPuffle_txt] = _arg_1;
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.careOfPuffle_txt.currentLang = "en";
                this.careOfPuffle_txt.debugColor = 0xCC00;
                this.careOfPuffle_txt.enabled = true;
                this.careOfPuffle_txt.font = "cpBurbankSmall";
                this.careOfPuffle_txt.globalMinFontSize = 8;
                this.careOfPuffle_txt.globalScaling = false;
                this.careOfPuffle_txt.globalWordWrap = true;
                this.careOfPuffle_txt.groupName = "[none]";
                this.careOfPuffle_txt.langControl = false;
                this.careOfPuffle_txt.ltcFilters = "";
                this.careOfPuffle_txt.minFontSizeData = "";
                this.careOfPuffle_txt.scalingData = "";
                this.careOfPuffle_txt.showBounds = false;
                this.careOfPuffle_txt.text = "Play with and care for your wild puffles \nat stations around the island! ";
                this.careOfPuffle_txt.textColor = 3299935;
                this.careOfPuffle_txt.textHorizontalAlignment = "center";
                this.careOfPuffle_txt.textSize = 12;
                this.careOfPuffle_txt.textVerticalAlignment = "center";
                this.careOfPuffle_txt.token = "";
                this.careOfPuffle_txt.visible = true;
                this.careOfPuffle_txt.wordWrapData = "";
                this.careOfPuffle_txt.zrevision = "v2.1.1";
                try
                {
                    this.careOfPuffle_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_26():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 27))))
            {
                this.__setPropDict[this.hasChosen_txt] = 27;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 4294172335;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_27():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 28))))
            {
                this.__setPropDict[this.hasChosen_txt] = 28;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 16776127;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_28():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 29))))
            {
                this.__setPropDict[this.hasChosen_txt] = 29;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 4294900474;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_hasChosen_txt_puffleCongrats_ALL_components_29():*
        {
            if (((this.__setPropDict[this.hasChosen_txt] == undefined) || (!(int(this.__setPropDict[this.hasChosen_txt]) == 30))))
            {
                this.__setPropDict[this.hasChosen_txt] = 30;
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.hasChosen_txt.currentLang = "en";
                this.hasChosen_txt.debugColor = 0xCC00;
                this.hasChosen_txt.enabled = true;
                this.hasChosen_txt.font = "cpBurbankSmallBold";
                this.hasChosen_txt.globalMinFontSize = 8;
                this.hasChosen_txt.globalScaling = false;
                this.hasChosen_txt.globalWordWrap = true;
                this.hasChosen_txt.groupName = "[none]";
                this.hasChosen_txt.langControl = false;
                this.hasChosen_txt.ltcFilters = "";
                this.hasChosen_txt.minFontSizeData = "";
                this.hasChosen_txt.scalingData = "";
                this.hasChosen_txt.showBounds = false;
                this.hasChosen_txt.text = "This certifies that";
                this.hasChosen_txt.textColor = 4081283;
                this.hasChosen_txt.textHorizontalAlignment = "left";
                this.hasChosen_txt.textSize = 15;
                this.hasChosen_txt.textVerticalAlignment = "center";
                this.hasChosen_txt.token = "";
                this.hasChosen_txt.visible = true;
                this.hasChosen_txt.wordWrapData = "";
                this.hasChosen_txt.zrevision = "v2.1.1";
                try
                {
                    this.hasChosen_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_26():*
        {
            if (((this.__setPropDict[this.date_txt] == undefined) || (!(int(this.__setPropDict[this.date_txt]) == 27))))
            {
                this.__setPropDict[this.date_txt] = 27;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 5598062;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_27(_arg_1:int):*
        {
            if (((((!(this.puffleNameText == null)) && (_arg_1 >= 28)) && (_arg_1 <= 29)) && ((this.__setPropDict[this.puffleNameText] == undefined) || (!((int(this.__setPropDict[this.puffleNameText]) >= 28) && (int(this.__setPropDict[this.puffleNameText]) <= 29))))))
            {
                this.__setPropDict[this.puffleNameText] = _arg_1;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 0xFFFFFF;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_puffleNameText_puffleCongrats_ALL_components_29():*
        {
            if (((this.__setPropDict[this.puffleNameText] == undefined) || (!(int(this.__setPropDict[this.puffleNameText]) == 30))))
            {
                this.__setPropDict[this.puffleNameText] = 30;
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.puffleNameText.currentLang = "en";
                this.puffleNameText.debugColor = 0xCC00;
                this.puffleNameText.enabled = true;
                this.puffleNameText.font = "cpBurbankSmallBold";
                this.puffleNameText.globalMinFontSize = 8;
                this.puffleNameText.globalScaling = false;
                this.puffleNameText.globalWordWrap = true;
                this.puffleNameText.groupName = "[none]";
                this.puffleNameText.langControl = false;
                this.puffleNameText.ltcFilters = "";
                this.puffleNameText.minFontSizeData = "";
                this.puffleNameText.scalingData = "";
                this.puffleNameText.showBounds = false;
                this.puffleNameText.text = "Pufflename";
                this.puffleNameText.textColor = 2896215;
                this.puffleNameText.textHorizontalAlignment = "left";
                this.puffleNameText.textSize = 30;
                this.puffleNameText.textVerticalAlignment = "center";
                this.puffleNameText.token = "";
                this.puffleNameText.visible = true;
                this.puffleNameText.wordWrapData = "";
                this.puffleNameText.zrevision = "v2.1.1";
                try
                {
                    this.puffleNameText["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_27():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 28))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 28;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 16776127;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_28():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 29))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 29;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 16710394;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_wasAdopted_txt_puffleCongrats_ALL_components_29():*
        {
            if (((this.__setPropDict[this.wasAdopted_txt] == undefined) || (!(int(this.__setPropDict[this.wasAdopted_txt]) == 30))))
            {
                this.__setPropDict[this.wasAdopted_txt] = 30;
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.wasAdopted_txt.currentLang = "en";
                this.wasAdopted_txt.debugColor = 0xCC00;
                this.wasAdopted_txt.enabled = true;
                this.wasAdopted_txt.font = "cpBurbankSmallBold";
                this.wasAdopted_txt.globalMinFontSize = 8;
                this.wasAdopted_txt.globalScaling = false;
                this.wasAdopted_txt.globalWordWrap = true;
                this.wasAdopted_txt.groupName = "[none]";
                this.wasAdopted_txt.langControl = false;
                this.wasAdopted_txt.ltcFilters = "";
                this.wasAdopted_txt.minFontSizeData = "";
                this.wasAdopted_txt.scalingData = "";
                this.wasAdopted_txt.showBounds = false;
                this.wasAdopted_txt.text = "was adopted by PenguinName";
                this.wasAdopted_txt.textColor = 4081283;
                this.wasAdopted_txt.textHorizontalAlignment = "left";
                this.wasAdopted_txt.textSize = 15;
                this.wasAdopted_txt.textVerticalAlignment = "center";
                this.wasAdopted_txt.token = "";
                this.wasAdopted_txt.visible = true;
                this.wasAdopted_txt.wordWrapData = "";
                this.wasAdopted_txt.zrevision = "v2.1.1";
                try
                {
                    this.wasAdopted_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_27(_arg_1:int):*
        {
            if (((((!(this.date_txt == null)) && (_arg_1 >= 28)) && (_arg_1 <= 29)) && ((this.__setPropDict[this.date_txt] == undefined) || (!((int(this.__setPropDict[this.date_txt]) >= 28) && (int(this.__setPropDict[this.date_txt]) <= 29))))))
            {
                this.__setPropDict[this.date_txt] = _arg_1;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 5598062;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_date_txt_puffleCongrats_ALL_components_29():*
        {
            if (((this.__setPropDict[this.date_txt] == undefined) || (!(int(this.__setPropDict[this.date_txt]) == 30))))
            {
                this.__setPropDict[this.date_txt] = 30;
                try
                {
                    this.date_txt["componentInspectorSetting"] = true;
                }
                catch(e:Error)
                {
                };
                this.date_txt.currentLang = "en";
                this.date_txt.debugColor = 0xCC00;
                this.date_txt.enabled = true;
                this.date_txt.font = "cpBurbankSmall";
                this.date_txt.globalMinFontSize = 8;
                this.date_txt.globalScaling = false;
                this.date_txt.globalWordWrap = true;
                this.date_txt.groupName = "[none]";
                this.date_txt.langControl = false;
                this.date_txt.ltcFilters = "";
                this.date_txt.minFontSizeData = "";
                this.date_txt.scalingData = "";
                this.date_txt.showBounds = false;
                this.date_txt.text = "Date: Month, Date Year";
                this.date_txt.textColor = 4081283;
                this.date_txt.textHorizontalAlignment = "left";
                this.date_txt.textSize = 12;
                this.date_txt.textVerticalAlignment = "center";
                this.date_txt.token = "";
                this.date_txt.visible = true;
                this.date_txt.wordWrapData = "";
                this.date_txt.zrevision = "v2.1.1";
                try
                {
                    this.date_txt["componentInspectorSetting"] = false;
                }
                catch(e:Error)
                {
                };
            };
        }

        internal function __setProp_handler(_arg_1:Object):*
        {
            var _local_2:int;
            _local_2 = currentFrame;
            if (this.__lastFrameProp == _local_2)
            {
                return;
            };
            this.__lastFrameProp = _local_2;
            this.__setProp_congratsTitle_txt_puffleCongrats_ALL_tintedcomponents_0(_local_2);
            this.__setProp_puffleNameText_puffleCongrats_ALL_new_0(_local_2);
            this.__setProp_congratsDescription_txt_puffleCongrats_ALL_components_0(_local_2);
            this.__setProp_locationText_puffleCongrats_ALL_components_0(_local_2);
            this.__setProp_buttonText_puffleCongrats_ALL_components_0(_local_2);
            this.__setProp_buttonText_puffleCongrats_ALL_components_11(_local_2);
            this.__setProp_buttonText_puffleCongrats_ALL_components_23(_local_2);
            this.__setProp_buttonText_puffleCongrats_ALL_components_25(_local_2);
            this.__setProp_locationWildText_puffleCongrats_ALL_components_12(_local_2);
            this.__setProp_locationWildText_puffleCongrats_ALL_components_14(_local_2);
            this.__setProp_locationWildText_puffleCongrats_ALL_components_16(_local_2);
            this.__setProp_locationWildText_puffleCongrats_ALL_components_18(_local_2);
            this.__setProp_locationWildText_puffleCongrats_ALL_components_24(_local_2);
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_12(_local_2);
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_14(_local_2);
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_16(_local_2);
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_18(_local_2);
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_25(_local_2);
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_14(_local_2);
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_16(_local_2);
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_18(_local_2);
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_14(_local_2);
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_16(_local_2);
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_18(_local_2);
            this.__setProp_date_txt_puffleCongrats_ALL_components_12(_local_2);
            this.__setProp_date_txt_puffleCongrats_ALL_components_14(_local_2);
            this.__setProp_date_txt_puffleCongrats_ALL_components_16(_local_2);
            this.__setProp_date_txt_puffleCongrats_ALL_components_18(_local_2);
            this.__setProp_date_txt_puffleCongrats_ALL_components_24(_local_2);
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_12(_local_2);
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_14(_local_2);
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_16(_local_2);
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_18(_local_2);
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_24(_local_2);
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_27(_local_2);
            this.__setProp_date_txt_puffleCongrats_ALL_components_27(_local_2);
        }

        internal function frame1():*
        {
            stop();
        }

        internal function frame23():*
        {
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_22();
            this.__setProp_date_txt_puffleCongrats_ALL_components_22();
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_22();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_22();
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_22();
            this.__setProp_locationWildText_puffleCongrats_ALL_components_22();
            this.__setProp_buttonText_puffleCongrats_ALL_components_22();
        }

        internal function frame11():*
        {
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_10();
            this.__setProp_date_txt_puffleCongrats_ALL_components_10();
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_10();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_10();
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_10();
            this.__setProp_locationWildText_puffleCongrats_ALL_components_10();
        }

        internal function frame12():*
        {
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_11();
            this.__setProp_date_txt_puffleCongrats_ALL_components_11();
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_11();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_11();
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_11();
            this.__setProp_locationWildText_puffleCongrats_ALL_components_11();
        }

        internal function frame21():*
        {
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_20();
            this.__setProp_date_txt_puffleCongrats_ALL_components_20();
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_20();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_20();
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_20();
            this.__setProp_locationWildText_puffleCongrats_ALL_components_20();
        }

        internal function frame22():*
        {
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_21();
            this.__setProp_date_txt_puffleCongrats_ALL_components_21();
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_21();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_21();
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_21();
            this.__setProp_locationWildText_puffleCongrats_ALL_components_21();
        }

        internal function frame24():*
        {
            this.__setProp_careOfPuffle_txt_puffleCongrats_ALL_components_23();
            this.__setProp_date_txt_puffleCongrats_ALL_components_23();
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_23();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_23();
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_23();
            this.__setProp_locationWildText_puffleCongrats_ALL_components_23();
        }

        internal function frame25():*
        {
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_24();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_24();
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_24();
        }

        internal function frame13():*
        {
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_12();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_12();
        }

        internal function frame14():*
        {
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_13();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_13();
        }

        internal function frame26():*
        {
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_25();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_25();
        }

        internal function frame27():*
        {
            this.__setProp_date_txt_puffleCongrats_ALL_components_26();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_26();
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_26();
        }

        internal function frame28():*
        {
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_27();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_27();
        }

        internal function frame29():*
        {
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_28();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_28();
        }

        internal function frame30():*
        {
            this.__setProp_date_txt_puffleCongrats_ALL_components_29();
            this.__setProp_wasAdopted_txt_puffleCongrats_ALL_components_29();
            this.__setProp_puffleNameText_puffleCongrats_ALL_components_29();
            this.__setProp_hasChosen_txt_puffleCongrats_ALL_components_29();
        }


    }
}//package puffleCongrats_fla
