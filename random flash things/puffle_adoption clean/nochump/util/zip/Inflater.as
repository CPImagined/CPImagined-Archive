//Created by Action Script Viewer - https://www.buraks.com/asv
package nochump.util.zip
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class Inflater 
    {

        private static const MAXBITS:int = 15;
        private static const MAXLCODES:int = 286;
        private static const MAXDCODES:int = 30;
        private static const MAXCODES:int = (MAXLCODES + MAXDCODES);//316
        private static const FIXLCODES:int = 288;
        private static const LENS:Array = [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258];
        private static const LEXT:Array = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0];
        private static const DISTS:Array = [1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 0x0101, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577];
        private static const DEXT:Array = [0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13];

        private var lencode:Object;
        private var bitcnt:int;
        private var bitbuf:int;
        private var incnt:uint;
        private var inbuf:ByteArray;
        private var distcode:Object;


        public function inflate(buf:ByteArray):uint
        {
            var last:*;
            var _local_4:*;
            incnt = (bitbuf = (bitcnt = 0));
            var err:int;
            do 
            {
                last = bits(1);
                _local_4 = bits(2);
                if (_local_4 == 0)
                {
                    stored(buf);
                }
                else
                {
                    if (_local_4 == 3)
                    {
                        throw (new Error("invalid block type (type == 3)", -1));
                    };
                    lencode = {
                        "count":[],
                        "symbol":[]
                    };
                    distcode = {
                        "count":[],
                        "symbol":[]
                    };
                    if (_local_4 == 1)
                    {
                        constructFixedTables();
                    }
                    else
                    {
                        if (_local_4 == 2)
                        {
                            err = constructDynamicTables();
                        };
                    };
                    if (err != 0)
                    {
                        return (err);
                    };
                    err = codes(buf);
                };
                if (err != 0) break;
            } while ((!(last)));
            return (err);
        }

        private function constructFixedTables():void
        {
            var lengths:Array = [];
            var symbol:int;
            while (symbol < 144)
            {
                lengths[symbol] = 8;
                symbol++;
            };
            while (symbol < 0x0100)
            {
                lengths[symbol] = 9;
                symbol++;
            };
            while (symbol < 280)
            {
                lengths[symbol] = 7;
                symbol++;
            };
            while (symbol < FIXLCODES)
            {
                lengths[symbol] = 8;
                symbol++;
            };
            construct(lencode, lengths, FIXLCODES);
            symbol = 0;
            while (symbol < MAXDCODES)
            {
                lengths[symbol] = 5;
                symbol++;
            };
            construct(distcode, lengths, MAXDCODES);
        }

        private function stored(buf:ByteArray):void
        {
            bitbuf = 0;
            bitcnt = 0;
            if ((incnt + 4) > inbuf.length)
            {
                throw (new Error("available inflate data did not terminate", 2));
            };
            var len:uint = inbuf[incnt++];
            len = (len | (inbuf[incnt++] << 8));
            if (((!(inbuf[incnt++] == ((~(len)) & 0xFF))) || (!(inbuf[incnt++] == (((~(len)) >> 8) & 0xFF)))))
            {
                throw (new Error("stored block length did not match one's complement", -2));
            };
            if ((incnt + len) > inbuf.length)
            {
                throw (new Error("available inflate data did not terminate", 2));
            };
            while (len--)
            {
                buf[buf.length] = inbuf[incnt++];
            };
        }

        public function setInput(buf:ByteArray):void
        {
            inbuf = buf;
            inbuf.endian = Endian.LITTLE_ENDIAN;
        }

        private function constructDynamicTables():int
        {
            var symbol:int;
            var len:int;
            var lengths:Array = [];
            var order:Array = [16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];
            var nlen:int = (bits(5) + 0x0101);
            var ndist:int = (bits(5) + 1);
            var ncode:int = (bits(4) + 4);
            if (((nlen > MAXLCODES) || (ndist > MAXDCODES)))
            {
                throw (new Error("dynamic block code description: too many length or distance codes", -3));
            };
            var index:int;
            while (index < ncode)
            {
                lengths[order[index]] = bits(3);
                index++;
            };
            while (index < 19)
            {
                lengths[order[index]] = 0;
                index++;
            };
            var err:int = construct(lencode, lengths, 19);
            if (err != 0)
            {
                throw (new Error("dynamic block code description: code lengths codes incomplete", -4));
            };
            index = 0;
            while (index < (nlen + ndist))
            {
                symbol = decode(lencode);
                if (symbol < 16)
                {
                    var _local_10:* = index++;
                    lengths[_local_10] = symbol;
                }
                else
                {
                    len = 0;
                    if (symbol == 16)
                    {
                        if (index == 0)
                        {
                            throw (new Error("dynamic block code description: repeat lengths with no first length", -5));
                        };
                        len = lengths[(index - 1)];
                        symbol = (3 + bits(2));
                    }
                    else
                    {
                        if (symbol == 17)
                        {
                            symbol = (3 + bits(3));
                        }
                        else
                        {
                            symbol = (11 + bits(7));
                        };
                    };
                    if ((index + symbol) > (nlen + ndist))
                    {
                        throw (new Error("dynamic block code description: repeat more than specified lengths", -6));
                    };
                    while (symbol--)
                    {
                        _local_10 = index++;
                        lengths[_local_10] = len;
                    };
                };
            };
            err = construct(lencode, lengths, nlen);
            if (((err < 0) || ((err > 0) && (!((nlen - lencode.count[0]) == 1)))))
            {
                throw (new Error("dynamic block code description: invalid literal/length code lengths", -7));
            };
            err = construct(distcode, lengths.slice(nlen), ndist);
            if (((err < 0) || ((err > 0) && (!((ndist - distcode.count[0]) == 1)))))
            {
                throw (new Error("dynamic block code description: invalid distance code lengths", -8));
            };
            return (err);
        }

        private function bits(need:int):int
        {
            var val:int = bitbuf;
            while (bitcnt < need)
            {
                if (incnt == inbuf.length)
                {
                    throw (new Error("available inflate data did not terminate", 2));
                };
                val = (val | (inbuf[incnt++] << bitcnt));
                bitcnt = (bitcnt + 8);
            };
            bitbuf = (val >> need);
            bitcnt = (bitcnt - need);
            return (val & ((1 << need) - 1));
        }

        private function construct(h:Object, length:Array, n:int):int
        {
            var offs:Array = [];
            var len:int;
            while (len <= MAXBITS)
            {
                h.count[len] = 0;
                len++;
            };
            var symbol:int;
            while (symbol < n)
            {
                h.count[length[symbol]]++;
                symbol++;
            };
            if (h.count[0] == n)
            {
                return (0);
            };
            var left:int = 1;
            len = 1;
            while (len <= MAXBITS)
            {
                left = (left << 1);
                left = (left - h.count[len]);
                if (left < 0)
                {
                    return (left);
                };
                len++;
            };
            offs[1] = 0;
            len = 1;
            while (len < MAXBITS)
            {
                offs[(len + 1)] = (offs[len] + h.count[len]);
                len++;
            };
            symbol = 0;
            while (symbol < n)
            {
                if (length[symbol] != 0)
                {
                    var _local_8:* = offs[length[symbol]]++;
                    h.symbol[_local_8] = symbol;
                };
                symbol++;
            };
            return (left);
        }

        private function decode(h:Object):int
        {
            var count:int;
            var code:int;
            var first:int;
            var index:int;
            var len:int = 1;
            while (len <= MAXBITS)
            {
                code = (code | bits(1));
                count = h.count[len];
                if (code < (first + count))
                {
                    return (h.symbol[(index + (code - first))]);
                };
                index = (index + count);
                first = (first + count);
                first = (first << 1);
                code = (code << 1);
                len++;
            };
            return (-9);
        }

        private function codes(buf:ByteArray):int
        {
            var symbol:*;
            var len:*;
            var dist:*;
            do 
            {
                symbol = decode(lencode);
                if (symbol < 0)
                {
                    return (symbol);
                };
                if (symbol < 0x0100)
                {
                    buf[buf.length] = symbol;
                }
                else
                {
                    if (symbol > 0x0100)
                    {
                        symbol = (symbol - 0x0101);
                        if (symbol >= 29)
                        {
                            throw (new Error("invalid literal/length or distance code in fixed or dynamic block", -9));
                        };
                        len = (LENS[symbol] + bits(LEXT[symbol]));
                        symbol = decode(distcode);
                        if (symbol < 0)
                        {
                            return (symbol);
                        };
                        dist = (DISTS[symbol] + bits(DEXT[symbol]));
                        if (dist > buf.length)
                        {
                            throw (new Error("distance is too far back in fixed or dynamic block", -10));
                        };
                        while (len--)
                        {
                            buf[buf.length] = buf[(buf.length - dist)];
                        };
                    };
                };
            } while (symbol != 0x0100);
            return (0);
        }


    }
}//package nochump.util.zip
