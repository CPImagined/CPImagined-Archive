//Created by Action Script Viewer - https://www.buraks.com/asv
package nochump.util.zip
{
    import flash.utils.ByteArray;

    public class ZipEntry 
    {

        private var _compressedSize:int = -1;
        private var _extra:ByteArray;
        internal var offset:int;
        private var _crc:uint;
        internal var version:int;
        internal var dostime:uint;
        private var _size:int = -1;
        private var _method:int = -1;
        private var _comment:String;
        internal var flag:int;
        private var _name:String;

        public function ZipEntry(name:String)
        {
            _name = name;
        }

        public function set compressedSize(csize:int):void
        {
            _compressedSize = csize;
        }

        public function get size():int
        {
            return (_size);
        }

        public function set size(size:int):void
        {
            _size = size;
        }

        public function get name():String
        {
            return (_name);
        }

        public function get time():Number
        {
            var d:Date = new Date((((dostime >> 25) & 0x7F) + 1980), (((dostime >> 21) & 0x0F) - 1), ((dostime >> 16) & 0x1F), ((dostime >> 11) & 0x1F), ((dostime >> 5) & 0x3F), ((dostime & 0x1F) << 1));
            return (d.time);
        }

        public function get extra():ByteArray
        {
            return (_extra);
        }

        public function set time(time:Number):void
        {
            var d:Date = new Date(time);
            dostime = ((((((((d.fullYear - 1980) & 0x7F) << 25) | ((d.month + 1) << 21)) | (d.day << 16)) | (d.hours << 11)) | (d.minutes << 5)) | (d.seconds >> 1));
        }

        public function get crc():uint
        {
            return (_crc);
        }

        public function get method():int
        {
            return (_method);
        }

        public function isDirectory():Boolean
        {
            return (_name.charAt((_name.length - 1)) == "/");
        }

        public function set method(method:int):void
        {
            _method = method;
        }

        public function set crc(crc:uint):void
        {
            _crc = crc;
        }

        public function get comment():String
        {
            return (_comment);
        }

        public function set extra(extra:ByteArray):void
        {
            _extra = extra;
        }

        public function get compressedSize():int
        {
            return (_compressedSize);
        }

        public function toString():String
        {
            return (_name);
        }

        public function set comment(comment:String):void
        {
            _comment = comment;
        }


    }
}//package nochump.util.zip
