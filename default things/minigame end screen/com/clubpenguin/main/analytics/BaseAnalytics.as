//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.analytics
{
    import com.clubpenguin.lib.util.StringUtils;

    public class BaseAnalytics implements IAnalytics 
    {

        protected var _context:AnalyticsContext;

        public function BaseAnalytics(context:AnalyticsContext)
        {
            this._context = context;
        }

        public function track(name:String, data:Array=null):Boolean
        {
            if (!StringUtils.isValidString(name))
            {
                return (false);
            };
            if (this.isBlocked(name))
            {
                return (false);
            };
            return (this.logItem(name, data));
        }

        public function getContext():AnalyticsContext
        {
            return (this._context);
        }

        public function setContext(context:AnalyticsContext):void
        {
            this._context = context;
        }

        public function containsSuffix(itemName:String, suffix:String):Boolean
        {
            var suffix_index:Number = itemName.lastIndexOf(suffix);
            if (suffix_index == -1)
            {
                return (false);
            };
            var suffix_length:Number = suffix.length;
            if ((suffix_index + suffix_length) == itemName.length)
            {
                return (true);
            };
            return (false);
        }

        public function containsPrefix(itemName:String, prefix:String):Boolean
        {
            if (itemName.indexOf(prefix) == 0)
            {
                return (true);
            };
            return (false);
        }

        public function containsSubString(itemName:String, subString:String):Boolean
        {
            return (!(itemName.indexOf(subString) == -1));
        }

        public function isItemOverriden(itemName:String, overriden:String):Boolean
        {
            return (this.containsPrefix(itemName, overriden));
        }

        public function isBlocked(itemName:String):Boolean
        {
            if (!this.getContext().isEnabled)
            {
                return (true);
            };
            var len:Number = this._context.blockedOverrides.length;
            var i:Number = 0;
            while (i < len)
            {
                if (this.isItemOverriden(itemName, this.getContext().blockedOverrides[i]))
                {
                    return (false);
                };
                i++;
            };
            if (this.getContext().isBlockingAll)
            {
                return (true);
            };
            len = this.getContext().blockedPrefixes.length;
            i = 0;
            while (i < len)
            {
                if (this.containsPrefix(itemName, this.getContext().blockedPrefixes[i]))
                {
                    return (true);
                };
                i++;
            };
            len = this.getContext().blockedSuffixes.length;
            i = 0;
            while (i < len)
            {
                if (this.containsSuffix(itemName, this.getContext().blockedSuffixes[i]))
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        protected function logItem(itemName:String, data:Array=null):Boolean
        {
            throw (new Error("BaseAnalytics: Inheriting classes must implement logItem(itemName:String, data:Array):Boolean"));
        }

        public function toString():String
        {
            return ("[BaseAnalytics]");
        }


    }
}//package com.clubpenguin.main.analytics
