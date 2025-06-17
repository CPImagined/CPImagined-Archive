//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.data
{
    import flash.events.EventDispatcher;
    import fl.events.DataChangeType;
    import fl.events.DataChangeEvent;

    [Event(name="preDataChange", type="fl.events.DataChangeEvent")]
    [Event(name="dataChange", type="fl.events.DataChangeEvent")]
    public class DataProvider extends EventDispatcher 
    {

        protected var data:Array;

        public function DataProvider(_arg_1:Object=null)
        {
            if (_arg_1 == null)
            {
                this.data = [];
            }
            else
            {
                this.data = this.getDataFromObject(_arg_1);
            };
        }

        public function get length():uint
        {
            return (this.data.length);
        }

        public function invalidateItemAt(_arg_1:int):void
        {
            this.checkIndex(_arg_1, (this.data.length - 1));
            this.dispatchChangeEvent(DataChangeType.INVALIDATE, [this.data[_arg_1]], _arg_1, _arg_1);
        }

        public function invalidateItem(_arg_1:Object):void
        {
            var _local_2:uint = this.getItemIndex(_arg_1);
            if (_local_2 == -1)
            {
                return;
            };
            this.invalidateItemAt(_local_2);
        }

        public function invalidate():void
        {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE, DataChangeType.INVALIDATE_ALL, this.data.concat(), 0, this.data.length));
        }

        public function addItemAt(_arg_1:Object, _arg_2:uint):void
        {
            this.checkIndex(_arg_2, this.data.length);
            this.dispatchPreChangeEvent(DataChangeType.ADD, [_arg_1], _arg_2, _arg_2);
            this.data.splice(_arg_2, 0, _arg_1);
            this.dispatchChangeEvent(DataChangeType.ADD, [_arg_1], _arg_2, _arg_2);
        }

        public function addItem(_arg_1:Object):void
        {
            this.dispatchPreChangeEvent(DataChangeType.ADD, [_arg_1], (this.data.length - 1), (this.data.length - 1));
            this.data.push(_arg_1);
            this.dispatchChangeEvent(DataChangeType.ADD, [_arg_1], (this.data.length - 1), (this.data.length - 1));
        }

        public function addItemsAt(_arg_1:Object, _arg_2:uint):void
        {
            this.checkIndex(_arg_2, this.data.length);
            var _local_3:Array = this.getDataFromObject(_arg_1);
            this.dispatchPreChangeEvent(DataChangeType.ADD, _local_3, _arg_2, ((_arg_2 + _local_3.length) - 1));
            this.data.splice.apply(this.data, [_arg_2, 0].concat(_local_3));
            this.dispatchChangeEvent(DataChangeType.ADD, _local_3, _arg_2, ((_arg_2 + _local_3.length) - 1));
        }

        public function addItems(_arg_1:Object):void
        {
            this.addItemsAt(_arg_1, this.data.length);
        }

        public function concat(_arg_1:Object):void
        {
            this.addItems(_arg_1);
        }

        public function merge(_arg_1:Object):void
        {
            var _local_6:Object;
            var _local_2:Array = this.getDataFromObject(_arg_1);
            var _local_3:uint = _local_2.length;
            var _local_4:uint = this.data.length;
            this.dispatchPreChangeEvent(DataChangeType.ADD, this.data.slice(_local_4, this.data.length), _local_4, (this.data.length - 1));
            var _local_5:uint;
            while (_local_5 < _local_3)
            {
                _local_6 = _local_2[_local_5];
                if (this.getItemIndex(_local_6) == -1)
                {
                    this.data.push(_local_6);
                };
                _local_5++;
            };
            if (this.data.length > _local_4)
            {
                this.dispatchChangeEvent(DataChangeType.ADD, this.data.slice(_local_4, this.data.length), _local_4, (this.data.length - 1));
            }
            else
            {
                this.dispatchChangeEvent(DataChangeType.ADD, [], -1, -1);
            };
        }

        public function getItemAt(_arg_1:uint):Object
        {
            this.checkIndex(_arg_1, (this.data.length - 1));
            return (this.data[_arg_1]);
        }

        public function getItemIndex(_arg_1:Object):int
        {
            return (this.data.indexOf(_arg_1));
        }

        public function removeItemAt(_arg_1:uint):Object
        {
            this.checkIndex(_arg_1, (this.data.length - 1));
            this.dispatchPreChangeEvent(DataChangeType.REMOVE, this.data.slice(_arg_1, (_arg_1 + 1)), _arg_1, _arg_1);
            var _local_2:Array = this.data.splice(_arg_1, 1);
            this.dispatchChangeEvent(DataChangeType.REMOVE, _local_2, _arg_1, _arg_1);
            return (_local_2[0]);
        }

        public function removeItem(_arg_1:Object):Object
        {
            var _local_2:int = this.getItemIndex(_arg_1);
            if (_local_2 != -1)
            {
                return (this.removeItemAt(_local_2));
            };
            return (null);
        }

        public function removeAll():void
        {
            var _local_1:Array = this.data.concat();
            this.dispatchPreChangeEvent(DataChangeType.REMOVE_ALL, _local_1, 0, _local_1.length);
            this.data = [];
            this.dispatchChangeEvent(DataChangeType.REMOVE_ALL, _local_1, 0, _local_1.length);
        }

        public function replaceItem(_arg_1:Object, _arg_2:Object):Object
        {
            var _local_3:int = this.getItemIndex(_arg_2);
            if (_local_3 != -1)
            {
                return (this.replaceItemAt(_arg_1, _local_3));
            };
            return (null);
        }

        public function replaceItemAt(_arg_1:Object, _arg_2:uint):Object
        {
            this.checkIndex(_arg_2, (this.data.length - 1));
            var _local_3:Array = [this.data[_arg_2]];
            this.dispatchPreChangeEvent(DataChangeType.REPLACE, _local_3, _arg_2, _arg_2);
            this.data[_arg_2] = _arg_1;
            this.dispatchChangeEvent(DataChangeType.REPLACE, _local_3, _arg_2, _arg_2);
            return (_local_3[0]);
        }

        public function sort(... _args):*
        {
            this.dispatchPreChangeEvent(DataChangeType.SORT, this.data.concat(), 0, (this.data.length - 1));
            var _local_2:Array = this.data.sort.apply(this.data, _args);
            this.dispatchChangeEvent(DataChangeType.SORT, this.data.concat(), 0, (this.data.length - 1));
            return (_local_2);
        }

        public function sortOn(_arg_1:Object, _arg_2:Object=null):*
        {
            this.dispatchPreChangeEvent(DataChangeType.SORT, this.data.concat(), 0, (this.data.length - 1));
            var _local_3:Array = this.data.sortOn(_arg_1, _arg_2);
            this.dispatchChangeEvent(DataChangeType.SORT, this.data.concat(), 0, (this.data.length - 1));
            return (_local_3);
        }

        public function clone():DataProvider
        {
            return (new DataProvider(this.data));
        }

        public function toArray():Array
        {
            return (this.data.concat());
        }

        override public function toString():String
        {
            return (("DataProvider [" + this.data.join(" , ")) + "]");
        }

        protected function getDataFromObject(_arg_1:Object):Array
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:uint;
            var _local_5:Object;
            var _local_6:XML;
            var _local_7:XMLList;
            var _local_8:XML;
            var _local_9:XMLList;
            var _local_10:XML;
            var _local_11:XMLList;
            var _local_12:XML;
            if ((_arg_1 is Array))
            {
                _local_3 = (_arg_1 as Array);
                if (_local_3.length > 0)
                {
                    if (((_local_3[0] is String) || (_local_3[0] is Number)))
                    {
                        _local_2 = [];
                        _local_4 = 0;
                        while (_local_4 < _local_3.length)
                        {
                            _local_5 = {
                                "label":String(_local_3[_local_4]),
                                "data":_local_3[_local_4]
                            };
                            _local_2.push(_local_5);
                            _local_4++;
                        };
                        return (_local_2);
                    };
                };
                return (_arg_1.concat());
            };
            if ((_arg_1 is DataProvider))
            {
                return (_arg_1.toArray());
            };
            if ((_arg_1 is XML))
            {
                _local_6 = (_arg_1 as XML);
                _local_2 = [];
                _local_7 = _local_6.*;
                for each (_local_8 in _local_7)
                {
                    _arg_1 = {};
                    _local_9 = _local_8.attributes();
                    for each (_local_10 in _local_9)
                    {
                        _arg_1[_local_10.localName()] = _local_10.toString();
                    };
                    _local_11 = _local_8.*;
                    for each (_local_12 in _local_11)
                    {
                        if (_local_12.hasSimpleContent())
                        {
                            _arg_1[_local_12.localName()] = _local_12.toString();
                        };
                    };
                    _local_2.push(_arg_1);
                };
                return (_local_2);
            };
            throw (new TypeError((("Error: Type Coercion failed: cannot convert " + _arg_1) + " to Array or DataProvider.")));
        }

        protected function checkIndex(_arg_1:int, _arg_2:int):void
        {
            if (((_arg_1 > _arg_2) || (_arg_1 < 0)))
            {
                throw (new RangeError((((("DataProvider index (" + _arg_1) + ") is not in acceptable range (0 - ") + _arg_2) + ")")));
            };
        }

        protected function dispatchChangeEvent(_arg_1:String, _arg_2:Array, _arg_3:int, _arg_4:int):void
        {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE, _arg_1, _arg_2, _arg_3, _arg_4));
        }

        protected function dispatchPreChangeEvent(_arg_1:String, _arg_2:Array, _arg_3:int, _arg_4:int):void
        {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE, _arg_1, _arg_2, _arg_3, _arg_4));
        }


    }
}//package fl.data
