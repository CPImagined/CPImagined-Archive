//Created by Action Script Viewer - https://www.buraks.com/asv
package header_fla
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import com.clubpenguin.newspaper.components.ContentButtonComponent;
    import flash.utils.*;
    import flash.events.*;
    import flash.net.*;
    import flash.display.*;
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.globalization.*;
    import flash.media.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.ime.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import flash.xml.*;

    public dynamic class Header_1 extends MovieClip 
    {

        public var weNeedYouButton:SimpleButton;//instance name
        public var boundingBox:MovieClip;//instance name
        public var __id0_:ContentButtonComponent;//instance name

        public function Header_1()
        {
            this.__setProp___id0__Header_ButtonsActions_0();
        }

        internal function __setProp___id0__Header_ButtonsActions_0():*
        {
            try
            {
                this.__id0_["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.__id0_.action = "linkTo";
            this.__id0_.buttonViewInstanceName = "weNeedYouButton";
            this.__id0_.category = "Undefined.";
            this.__id0_.target = "submitYourContent";
            try
            {
                this.__id0_["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }


    }
}//package header_fla
