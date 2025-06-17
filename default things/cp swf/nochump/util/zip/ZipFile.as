//Created by Action Script Viewer - https://www.buraks.com/asv
package nochump.util.zip
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import flash.utils.IDataInput;

    public class ZipFile 
    {

        private var entryTable:Dictionary;
        private var entryList:Array;
        private var buf:ByteArray;
        private var locOffsetTable:Dictionary;

        public function ZipFile(data:IDataInput)
        {
            buf = new ByteArray();
            buf.endian = Endian.LITTLE_ENDIAN;
            data.readBytes(buf);
            readEntries();
        }

        public function get size():uint
        {
            return (entryList.length);
        }

        private function findEND():uint
        {
            var i:uint = (buf.length - ZipConstants.ENDHDR);
            var n:uint = Math.max(0, (i - 0xFFFF));
            while (i >= n)
            {
                if (buf[i] == 80)
                {
                    buf.position = i;
                    if (buf.readUnsignedInt() == ZipConstants.ENDSIG)
                    {
                        return (i);
                    };
                };
                i--;
            };
            throw (new ZipError("invalid zip"));
        }

        private function readEND():void
        {
            var b:ByteArray = new ByteArray();
            b.endian = Endian.LITTLE_ENDIAN;
            buf.position = findEND();
            buf.readBytes(b, 0, ZipConstants.ENDHDR);
            b.position = ZipConstants.ENDTOT;
            entryList = new Array(b.readUnsignedShort());
            b.position = ZipConstants.ENDOFF;
            buf.position = b.readUnsignedInt();
        }

        private function readEntries():void
        {
            var tmpbuf:ByteArray;
            var len:uint;
            var e:ZipEntry;
            readEND();
            entryTable = new Dictionary();
            locOffsetTable = new Dictionary();
            var i:uint;
            while (i < entryList.length)
            {
                tmpbuf = new ByteArray();
                tmpbuf.endian = Endian.LITTLE_ENDIAN;
                buf.readBytes(tmpbuf, 0, ZipConstants.CENHDR);
                if (tmpbuf.readUnsignedInt() != ZipConstants.CENSIG)
                {
                    throw (new ZipError("invalid CEN header (bad signature)"));
                };
                tmpbuf.position = ZipConstants.CENNAM;
                len = tmpbuf.readUnsignedShort();
                if (len == 0)
                {
                    throw (new ZipError("missing entry name"));
                };
                e = new ZipEntry(buf.readUTFBytes(len));
                len = tmpbuf.readUnsignedShort();
                e.extra = new ByteArray();
                if (len > 0)
                {
                    buf.readBytes(e.extra, 0, len);
                };
                buf.position = (buf.position + tmpbuf.readUnsignedShort());
                tmpbuf.position = ZipConstants.CENVER;
                e.version = tmpbuf.readUnsignedShort();
                e.flag = tmpbuf.readUnsignedShort();
                if ((e.flag & 0x01) == 1)
                {
                    throw (new ZipError("encrypted ZIP entry not supported"));
                };
                e.method = tmpbuf.readUnsignedShort();
                e.dostime = tmpbuf.readUnsignedInt();
                e.crc = tmpbuf.readUnsignedInt();
                e.compressedSize = tmpbuf.readUnsignedInt();
                e.size = tmpbuf.readUnsignedInt();
                entryList[i] = e;
                entryTable[e.name] = e;
                tmpbuf.position = ZipConstants.CENOFF;
                locOffsetTable[e.name] = tmpbuf.readUnsignedInt();
                i++;
            };
        }

        public function getInput(entry:ZipEntry):ByteArray
        {
            var b2:ByteArray;
            var inflater:Inflater;
            buf.position = ((locOffsetTable[entry.name] + ZipConstants.LOCHDR) - 2);
            var len:uint = buf.readShort();
            buf.position = (buf.position + (entry.name.length + len));
            var b1:ByteArray = new ByteArray();
            if (entry.compressedSize > 0)
            {
                buf.readBytes(b1, 0, entry.compressedSize);
            };
            switch (entry.method)
            {
                case ZipConstants.STORED:
                    return (b1);
                case ZipConstants.DEFLATED:
                    b2 = new ByteArray();
                    inflater = new Inflater();
                    inflater.setInput(b1);
                    inflater.inflate(b2);
                    return (b2);
                default:
                    throw (new ZipError("invalid compression method"));
            };
        }

        public function get entries():Array
        {
            return (entryList);
        }

        public function getEntry(name:String):ZipEntry
        {
            return (entryTable[name]);
        }


    }
}//package nochump.util.zip
