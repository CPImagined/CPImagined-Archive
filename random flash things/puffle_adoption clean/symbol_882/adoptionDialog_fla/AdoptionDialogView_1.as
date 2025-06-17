//Created by Action Script Viewer - https://www.buraks.com/asv
package adoptionDialog_fla
{
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.LocalTextComponent;
    import flash.text.TextField;
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

    public dynamic class AdoptionDialogView_1 extends MovieClip 
    {

        public var subText:LocalTextComponent;//instance name
        public var inputText:TextField;//instance name
        public var woodHorizontalLg:MovieClip;//instance name
        public var closeButton:MovieClip;//instance name
        public var price:LocalTextComponent;//instance name
        public var clipboardBack:MovieClip;//instance name
        public var adoptButton:MovieClip;//instance name
        public var puffleHolder:MovieClip;//instance name
        public var inputBackground:MovieClip;//instance name

        public function AdoptionDialogView_1()
        {
            this.__setProp_subText_AdoptionDialogView_Adopt();
            this.__setProp_price_AdoptionDialogView_Adopt();
        }

        internal function __setProp_subText_AdoptionDialogView_Adopt():*
        {
            try
            {
                this.subText["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.subText.currentLang = "en";
            this.subText.debugColor = 0xCC00;
            this.subText.enabled = true;
            this.subText.font = "cpBurbankSmall";
            this.subText.globalMinFontSize = 8;
            this.subText.globalScaling = true;
            this.subText.globalWordWrap = true;
            this.subText.groupName = "";
            this.subText.langControl = false;
            this.subText.ltcFilters = "";
            this.subText.minFontSizeData = "";
            this.subText.scalingData = "";
            this.subText.showBounds = false;
            this.subText.text = "Are you ready to adopt \nyour new puffle?";
            this.subText.textColor = 1579564;
            this.subText.textHorizontalAlignment = "center";
            this.subText.textSize = 15;
            this.subText.textVerticalAlignment = "bottom";
            this.subText.token = "";
            this.subText.visible = true;
            this.subText.wordWrapData = "";
            this.subText.zrevision = "v2.0.8";
            try
            {
                this.subText["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }

        internal function __setProp_price_AdoptionDialogView_Adopt():*
        {
            try
            {
                this.price["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.price.currentLang = "en";
            this.price.debugColor = 0xCC00;
            this.price.enabled = true;
            this.price.font = "cpBurbankSmallBoldItal";
            this.price.globalMinFontSize = 8;
            this.price.globalScaling = true;
            this.price.globalWordWrap = true;
            this.price.groupName = "";
            this.price.langControl = false;
            this.price.ltcFilters = "";
            this.price.minFontSizeData = "";
            this.price.scalingData = "";
            this.price.showBounds = false;
            this.price.text = "%0%";
            this.price.textColor = 1579564;
            this.price.textHorizontalAlignment = "left";
            this.price.textSize = 15;
            this.price.textVerticalAlignment = "center";
            this.price.token = "";
            this.price.visible = true;
            this.price.wordWrapData = "";
            this.price.zrevision = "v2.0.8";
            try
            {
                this.price["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }


    }
}//package adoptionDialog_fla
