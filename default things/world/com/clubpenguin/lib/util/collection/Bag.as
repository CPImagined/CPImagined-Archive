//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util.collection
{
    import flash.utils.Dictionary;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.IVO;
    import flash.utils.getQualifiedClassName;

    public class Bag implements ICollection 
    {

        private var _itemType:Class;
        private var _itemCount:int = 0;
        private var _totalItemCount:int = 0;

        private var _itemLookup:Dictionary = new Dictionary();
        public const itemAdded:Signal = new Signal(IVO);
        public const itemRemoved:Signal = new Signal(IVO);

        public function Bag(_arg_1:Class):void
        {
            this._itemType = _arg_1;
        }

        public function destroy(destroyItems:Boolean=false):void
        {
            this.clear(destroyItems);
            this.itemAdded.removeAll();
            this.itemRemoved.removeAll();
            this._itemLookup = new Dictionary();
        }

        public function toString():String
        {
            var i:int;
            var returnString:String = ((((("itemType:" + this._itemType) + ", itemCount:") + this._itemCount) + ", totalItemCount:") + this._totalItemCount);
            var itemList:Array = this.getAllItems();
            if (itemList)
            {
                returnString = (returnString + ", itemLookup:");
                i = 0;
                while (i < itemList.length)
                {
                    returnString = (returnString + (itemList[i] as IVO).toString());
                    if (i != (itemList.length - 1))
                    {
                        returnString = (returnString + ", ");
                    };
                    i++;
                };
            };
            return (returnString);
        }

        public function getType():Class
        {
            return (this._itemType);
        }

        public function getUniqueSize():int
        {
            return (this._itemCount);
        }

        public function isEmpty():Boolean
        {
            return (this._totalItemCount == 0);
        }

        public function getSize():int
        {
            return (this._totalItemCount);
        }

        public function add(item:IVO):Boolean
        {
            if ((item is this._itemType))
            {
                if (this.contains(item))
                {
                    throw (new Error("Attempt to add an item that's already in collection"));
                };
                if (!this._itemLookup[item.id])
                {
                    this._itemLookup[item.id] = [];
                    this._itemCount++;
                };
                (this._itemLookup[item.id] as Array).push(item);
                this._totalItemCount++;
                this.itemAdded.dispatch(item);
                return (true);
            };
            throw (new Error(((("Attempt to add incompatible type to collection. Was expecting " + getQualifiedClassName(this._itemType)) + " but received an item of type ") + getQualifiedClassName(item))));
        }

        public function numberOfItemInCollection(item:IVO):int
        {
            if (this._itemLookup[item.id])
            {
                if (this._itemLookup[item.id])
                {
                    return ((this._itemLookup[item.id] as Array).length);
                };
            };
            return (0);
        }

        public function removeItem(item:IVO, destroyItem:Boolean=false):void
        {
            var itemList:Array;
            var foundIndex:int;
            if (!(item is this._itemType))
            {
                throw (new Error(((("Attempt to remove incompatible type from collection. Was expecting " + getQualifiedClassName(this._itemType)) + " but received an item of type ") + getQualifiedClassName(item))));
            };
            var id:int = item.id;
            if (this._itemLookup[id])
            {
                itemList = (this._itemLookup[id] as Array);
                foundIndex = this.getItemListArrayIndex(item);
                if (foundIndex != -1)
                {
                    itemList.splice(foundIndex, 1);
                    this.itemRemoved.dispatch(item);
                    if (destroyItem)
                    {
                        item.destroy();
                    };
                    if (itemList.length == 0)
                    {
                        this._itemCount--;
                        delete this._itemLookup[id];
                    };
                    this._totalItemCount--;
                }
                else
                {
                    throw (new Error("Could not find given item in collection!"));
                };
            }
            else
            {
                throw (new Error((("Given item id (" + id) + ") not found in collection!")));
            };
        }

        public function remove(itemList:Array, destroyItems:Boolean=false):void
        {
            var originalLength:int;
            var i:int;
            if (itemList)
            {
                originalLength = itemList.length;
                i = 0;
                while (i < itemList.length)
                {
                    this.removeItem((itemList[i] as IVO), destroyItems);
                    if (((itemList.length > 0) && (itemList.length < originalLength)))
                    {
                        i = 0;
                    }
                    else
                    {
                        i++;
                    };
                };
            };
        }

        public function clear(destroyItems:Boolean=false):void
        {
            var key:Object;
            for (key in this._itemLookup)
            {
                this.remove((this._itemLookup[key] as Array), destroyItems);
            };
            this._itemLookup = new Dictionary();
            this._itemCount = 0;
            this._totalItemCount = 0;
        }

        public function contains(item:IVO):Boolean
        {
            return (!(this.getItemListArrayIndex(item) == -1));
        }

        public function getAllItems():Array
        {
            var value:Object;
            var itemList:Array = new Array();
            for each (value in this._itemLookup)
            {
                itemList = itemList.concat((value as Array));
            };
            return (itemList);
        }

        public function getItem(itemID:int):IVO
        {
            var itemList:Array;
            if (this._itemLookup[itemID])
            {
                itemList = (this._itemLookup[itemID] as Array);
                if (((itemList) && (itemList.length > 0)))
                {
                    return (itemList[0]);
                };
            };
            return (null);
        }

        private function getItemListArrayIndex(item:IVO):int
        {
            var itemList:Array;
            var i:int;
            var currentItem:IVO;
            var id:int = item.id;
            if (this._itemLookup[id])
            {
                itemList = (this._itemLookup[id] as Array);
                if (itemList)
                {
                    i = 0;
                    while (i < itemList.length)
                    {
                        currentItem = (itemList[i] as IVO);
                        if (currentItem == item)
                        {
                            return (i);
                        };
                        i++;
                    };
                };
            };
            return (-1);
        }

        public function getItemAdded():Signal
        {
            return (this.itemAdded);
        }

        public function getItemRemoved():Signal
        {
            return (this.itemRemoved);
        }


    }
}//package com.clubpenguin.lib.util.collection
