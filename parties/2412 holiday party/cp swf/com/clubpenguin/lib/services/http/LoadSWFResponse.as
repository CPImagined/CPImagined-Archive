//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.http
{
    import flash.display.DisplayObject;
    import flash.display.Loader;

    public class LoadSWFResponse 
    {

        public var status:int;
        public var success:Boolean = false;
        public var errorMessage:String;
        public var data:DisplayObject;
        public var props:Object;
        public var id:String;
        public var service:LoadSWFService;
        public var bytesTotal:int;


        public function get loader():Loader
        {
            return (this.data as Loader);
        }

        public function toString():String
        {
            var str:String;
            str = "[LoadSWFResponse]\n";
            str = (str + (("\tstatus: " + this.status) + "\n"));
            str = (str + (("\tsuccess: " + this.success) + "\n"));
            str = (str + (("\terrorMessage: " + this.errorMessage) + "\n"));
            str = (str + (("\tdata: " + this.data) + "\n"));
            str = (str + (("\tprops: " + this.props) + "\n"));
            str = (str + (("\tid: " + this.id) + "\n"));
            str = (str + (("\tservice: " + this.service) + "\n"));
            str = (str + (("\tbytesTotal: " + this.bytesTotal) + "\n"));
            str = (str + "[/LoadSWFResponse]");
            return (str);
        }

        public function get content():DisplayObject
        {
            return ((this.data as Loader).content);
        }


    }
}//package com.clubpenguin.lib.services.http
