//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.vo
{
    import com.clubpenguin.managers.ILoadableAsset;
    import com.clubpenguin.main.overlays.type.OverlayType;
    import flash.display.DisplayObject;
    import flash.display.Loader;

    public class OverlayVO implements ILoadableAsset 
    {

        public var id:String;
        public var dataObject:Object;
        public var type:OverlayType;
        public var object:DisplayObject;
        public var loader:Loader;
        public var modalBackgroundEnabled:Boolean = true;
        public var hideLoadingDialog:Boolean = false;
        public var disableMouse:Boolean = false;
        public var layer:String;
        public var persistent:Boolean = false;
        public var connectClose:Boolean = false;
        private var _url:String;
        private var _isAbsoluteURL:Boolean = false;
        private var _isExternal:Boolean = false;


        public function get url():String
        {
            return (this._url);
        }

        public function set url(value:String):void
        {
            this._url = value;
        }

        public function get isAbsoluteURL():Boolean
        {
            return (this._isAbsoluteURL);
        }

        public function set isAbsoluteURL(value:Boolean):void
        {
            this._isAbsoluteURL = value;
        }

        public function get isExternal():Boolean
        {
            return (this._isExternal);
        }

        public function set isExternal(value:Boolean):void
        {
            this._isExternal = value;
        }

        public function getID():String
        {
            return (this.id);
        }


    }
}//package com.clubpenguin.main.overlays.vo
