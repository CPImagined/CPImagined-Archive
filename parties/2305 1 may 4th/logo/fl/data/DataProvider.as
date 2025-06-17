package fl.data
{
    import fl.events.*;
    import flash.events.*;

    public class DataProvider extends EventDispatcher
    {
        protected var data:Array;

        public function DataProvider(param1:Object = null)
        {
            if (param1 == null)
            {
                this.data = [];
            }
            else
            {
                this.data = this.getDataFromObject(param1);
            }
            return;
        }// end function

        public function get length() : uint
        {
            return this.data.length;
        }// end function

        public function invalidateItemAt(param1:int) : void
        {
            this.checkIndex(param1, (this.data.length - 1));
            this.dispatchChangeEvent(DataChangeType.INVALIDATE, [this.data[param1]], param1, param1);
            return;
        }// end function

        public function invalidateItem(param1:Object) : void
        {
            var _loc_2:* = this.getItemIndex(param1);
            if (_loc_2 == -1)
            {
                return;
            }
            this.invalidateItemAt(_loc_2);
            return;
        }// end function

        public function invalidate() : void
        {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE, DataChangeType.INVALIDATE_ALL, this.data.concat(), 0, this.data.length));
            return;
        }// end function

        public function addItemAt(param1:Object, param2:uint) : void
        {
            this.checkIndex(param2, this.data.length);
            this.dispatchPreChangeEvent(DataChangeType.ADD, [param1], param2, param2);
            this.data.splice(param2, 0, param1);
            this.dispatchChangeEvent(DataChangeType.ADD, [param1], param2, param2);
            return;
        }// end function

        public function addItem(param1:Object) : void
        {
            this.dispatchPreChangeEvent(DataChangeType.ADD, [param1], (this.data.length - 1), (this.data.length - 1));
            this.data.push(param1);
            this.dispatchChangeEvent(DataChangeType.ADD, [param1], (this.data.length - 1), (this.data.length - 1));
            return;
        }// end function

        public function addItemsAt(param1:Object, param2:uint) : void
        {
            this.checkIndex(param2, this.data.length);
            var _loc_3:* = this.getDataFromObject(param1);
            this.dispatchPreChangeEvent(DataChangeType.ADD, _loc_3, param2, param2 + _loc_3.length - 1);
            this.data.splice.apply(this.data, [param2, 0].concat(_loc_3));
            this.dispatchChangeEvent(DataChangeType.ADD, _loc_3, param2, param2 + _loc_3.length - 1);
            return;
        }// end function

        public function addItems(param1:Object) : void
        {
            this.addItemsAt(param1, this.data.length);
            return;
        }// end function

        public function concat(param1:Object) : void
        {
            this.addItems(param1);
            return;
        }// end function

        public function merge(param1:Object) : void
        {
            var _loc_6:* = null;
            var _loc_2:* = this.getDataFromObject(param1);
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = this.data.length;
            this.dispatchPreChangeEvent(DataChangeType.ADD, this.data.slice(_loc_4, this.data.length), _loc_4, (this.data.length - 1));
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2[_loc_5];
                if (this.getItemIndex(_loc_6) == -1)
                {
                    this.data.push(_loc_6);
                }
                _loc_5 = _loc_5 + 1;
            }
            if (this.data.length > _loc_4)
            {
                this.dispatchChangeEvent(DataChangeType.ADD, this.data.slice(_loc_4, this.data.length), _loc_4, (this.data.length - 1));
            }
            else
            {
                this.dispatchChangeEvent(DataChangeType.ADD, [], -1, -1);
            }
            return;
        }// end function

        public function getItemAt(param1:uint) : Object
        {
            this.checkIndex(param1, (this.data.length - 1));
            return this.data[param1];
        }// end function

        public function getItemIndex(param1:Object) : int
        {
            return this.data.indexOf(param1);
        }// end function

        public function removeItemAt(param1:uint) : Object
        {
            this.checkIndex(param1, (this.data.length - 1));
            this.dispatchPreChangeEvent(DataChangeType.REMOVE, this.data.slice(param1, (param1 + 1)), param1, param1);
            var _loc_2:* = this.data.splice(param1, 1);
            this.dispatchChangeEvent(DataChangeType.REMOVE, _loc_2, param1, param1);
            return _loc_2[0];
        }// end function

        public function removeItem(param1:Object) : Object
        {
            var _loc_2:* = this.getItemIndex(param1);
            if (_loc_2 != -1)
            {
                return this.removeItemAt(_loc_2);
            }
            return null;
        }// end function

        public function removeAll() : void
        {
            var _loc_1:* = this.data.concat();
            this.dispatchPreChangeEvent(DataChangeType.REMOVE_ALL, _loc_1, 0, _loc_1.length);
            this.data = [];
            this.dispatchChangeEvent(DataChangeType.REMOVE_ALL, _loc_1, 0, _loc_1.length);
            return;
        }// end function

        public function replaceItem(param1:Object, param2:Object) : Object
        {
            var _loc_3:* = this.getItemIndex(param2);
            if (_loc_3 != -1)
            {
                return this.replaceItemAt(param1, _loc_3);
            }
            return null;
        }// end function

        public function replaceItemAt(param1:Object, param2:uint) : Object
        {
            this.checkIndex(param2, (this.data.length - 1));
            var _loc_3:* = [this.data[param2]];
            this.dispatchPreChangeEvent(DataChangeType.REPLACE, _loc_3, param2, param2);
            this.data[param2] = param1;
            this.dispatchChangeEvent(DataChangeType.REPLACE, _loc_3, param2, param2);
            return _loc_3[0];
        }// end function

        public function sort(... args)
        {
            this.dispatchPreChangeEvent(DataChangeType.SORT, this.data.concat(), 0, (this.data.length - 1));
            args = this.data.sort.apply(this.data, args);
            this.dispatchChangeEvent(DataChangeType.SORT, this.data.concat(), 0, (this.data.length - 1));
            return args;
        }// end function

        public function sortOn(param1:Object, param2:Object = null)
        {
            this.dispatchPreChangeEvent(DataChangeType.SORT, this.data.concat(), 0, (this.data.length - 1));
            var _loc_3:* = this.data.sortOn(param1, param2);
            this.dispatchChangeEvent(DataChangeType.SORT, this.data.concat(), 0, (this.data.length - 1));
            return _loc_3;
        }// end function

        public function clone() : DataProvider
        {
            return new DataProvider(this.data);
        }// end function

        public function toArray() : Array
        {
            return this.data.concat();
        }// end function

        override public function toString() : String
        {
            return "DataProvider [" + this.data.join(" , ") + "]";
        }// end function

        protected function getDataFromObject(param1:Object) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (param1 is Array)
            {
                _loc_3 = param1 as Array;
                if (_loc_3.length > 0)
                {
                    if (_loc_3[0] is String || _loc_3[0] is Number)
                    {
                        _loc_2 = [];
                        _loc_4 = 0;
                        while (_loc_4 < _loc_3.length)
                        {
                            
                            _loc_5 = {label:String(_loc_3[_loc_4]), data:_loc_3[_loc_4]};
                            _loc_2.push(_loc_5);
                            _loc_4 = _loc_4 + 1;
                        }
                        return _loc_2;
                    }
                }
                return param1.concat();
            }
            else
            {
                if (param1 is DataProvider)
                {
                    return param1.toArray();
                }
                if (param1 is XML)
                {
                    _loc_6 = param1 as XML;
                    _loc_2 = [];
                    _loc_7 = _loc_6.*;
                    for each (_loc_8 in _loc_7)
                    {
                        
                        param1 = {};
                        _loc_9 = _loc_8.attributes();
                        for each (_loc_10 in _loc_9)
                        {
                            
                            param1[_loc_10.localName()] = _loc_10.toString();
                        }
                        _loc_11 = _loc_8.*;
                        for each (_loc_12 in _loc_11)
                        {
                            
                            if (_loc_12.hasSimpleContent())
                            {
                                param1[_loc_12.localName()] = _loc_12.toString();
                            }
                        }
                        _loc_2.push(param1);
                    }
                    return _loc_2;
                }
            }
            throw new TypeError("Error: Type Coercion failed: cannot convert " + param1 + " to Array or DataProvider.");
        }// end function

        protected function checkIndex(param1:int, param2:int) : void
        {
            if (param1 > param2 || param1 < 0)
            {
                throw new RangeError("DataProvider index (" + param1 + ") is not in acceptable range (0 - " + param2 + ")");
            }
            return;
        }// end function

        protected function dispatchChangeEvent(param1:String, param2:Array, param3:int, param4:int) : void
        {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE, param1, param2, param3, param4));
            return;
        }// end function

        protected function dispatchPreChangeEvent(param1:String, param2:Array, param3:int, param4:int) : void
        {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE, param1, param2, param3, param4));
            return;
        }// end function

    }
}
