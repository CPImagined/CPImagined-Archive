//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util.collection
{
    import flash.utils.Dictionary;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.IVO;
    import flash.utils.getQualifiedClassName;

    public class Collection implements ICollection 
    {

        private var _itemType:Class;
        private var _itemCount:int = 0;
        private var _totalItemCount:int = 0;

        private var _itemLookup:Dictionary = new Dictionary();
        private const _itemAdded:Signal = new Signal(IVO);
        private const _itemRemoved:Signal = new Signal(IVO);

        public function Collection(_arg_1:Class):void
        {
            this._itemType = _arg_1;
        }

        public function destroy(destroyItems:Boolean=false):void
        {
            this.clear(destroyItems);
            this.itemAdded.removeAll();
            this.itemRemoved.removeAll();
            this._itemLookup = null;
        }

        public function get itemAdded():Signal
        {
            return (this._itemAdded);
        }

        public function get itemRemoved():Signal
        {
            return (this._itemRemoved);
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
                    (this._itemLookup[item.id] as IVO).update(item);
                    return (false);
                };
                this._itemLookup[item.id] = item;
                this._totalItemCount++;
                this.itemAdded.dispatch(item);
                return (true);
            };
            throw (new Error(((("Attempt to add incompatible type to collection. Was expecting " + getQualifiedClassName(this._itemType)) + " but received an item of type ") + getQualifiedClassName(item))));
        }

        public function update(updatedItems:Array):void
        {
        }

        public function numberOfItemInCollection(item:IVO):int
        {
            if (this._itemLookup[item.id])
            {
                return (1);
            };
            return (0);
        }

        public function removeItem(item:IVO, destroyItem:Boolean=false):void
        {
            if (!(item is this._itemType))
            {
                throw (new Error(((("Attempt to remove incompatible type from collection. Was expecting " + getQualifiedClassName(this._itemType)) + " but received an item of type ") + getQualifiedClassName(item))));
            };
            var id:int = item.id;
            if (this._itemLookup[id])
            {
                (this._itemLookup[id] as IVO).destroy();
                delete this._itemLookup[id];
                this._totalItemCount--;
                this.itemRemoved.dispatch(item);
            }
            else
            {
                throw (new Error((("Given item id (" + id) + ") not found in collection!")));
            };
        }

        public function remove(itemList:Array, destroyItems:Boolean=false):void
        {
            var i:int;
            if (itemList)
            {
                i = itemList.length;
                while (i > 0)
                {
                    this.removeItem((itemList[i] as IVO), destroyItems);
                    i--;
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
            this._itemLookup = null;
            this._itemLookup = new Dictionary();
            this._totalItemCount = 0;
        }

        public function contains(item:IVO):Boolean
        {
            return (!(this._itemLookup[item.id] == null));
        }

        public function getAllItems():Array
        {
            var value:Object;
            var itemList:Array = new Array();
            for each (value in this._itemLookup)
            {
                itemList.push(value);
            };
            return (itemList);
        }

        public function getItem(itemID:int):IVO
        {
            if (this._itemLookup[itemID])
            {
                return (this._itemLookup[itemID]);
            };
            return (null);
        }

        public function getItemAdded():Signal
        {
            return (this._itemAdded);
        }

        public function getItemRemoved():Signal
        {
            return (this._itemRemoved);
        }


    }
}//package com.clubpenguin.lib.util.collection
