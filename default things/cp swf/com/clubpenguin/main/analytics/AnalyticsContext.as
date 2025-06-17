//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.analytics
{
    public class AnalyticsContext 
    {

        private var _blockedPrefixes:Array;
        private var _blockedSuffixes:Array;
        private var _blockedOverrides:Array;
        private var _isEnabled:Boolean;
        private var _isBlockingAll:Boolean;

        public function AnalyticsContext()
        {
            this._blockedPrefixes = [];
            this._blockedSuffixes = [];
            this._blockedOverrides = [];
            this._isEnabled = true;
            this._isBlockingAll = false;
        }

        public function initFromConfig(config:Object):void
        {
            this.appendBlockedPrefixes(config.blockedPrefixes);
            this.appendBlockedSuffixes(config.blockedSuffixes);
            this.appendBlockedOverrides(config.blockedOverrides);
            this.isEnabled = ((config.enabled != undefined) ? config.enabled : false);
            this.isBlockingAll = config.blockAll;
        }

        public function get isEnabled():Boolean
        {
            return (this._isEnabled);
        }

        public function set isEnabled(isEnabled:Boolean):void
        {
            this._isEnabled = isEnabled;
        }

        public function get isBlockingAll():Boolean
        {
            return (this._isBlockingAll);
        }

        public function set isBlockingAll(isBlockingAll:Boolean):void
        {
            this._isBlockingAll = isBlockingAll;
        }

        public function get blockedPrefixes():Array
        {
            return (this._blockedPrefixes);
        }

        public function set blockedPrefixes(prefixes:Array):void
        {
            if (prefixes.length >= 0)
            {
                this._blockedPrefixes = prefixes;
            };
        }

        public function get blockedSuffixes():Array
        {
            return (this._blockedSuffixes);
        }

        public function set blockedSuffixes(suffixes:Array):void
        {
            if (suffixes.length >= 0)
            {
                this._blockedSuffixes = suffixes;
            };
        }

        public function get blockedOverrides():Array
        {
            return (this._blockedOverrides);
        }

        public function set blockedOverrides(overrides:Array):void
        {
            if (overrides.length >= 0)
            {
                this._blockedOverrides = overrides;
            };
        }

        public function appendBlockedPrefixes(prefixes:Array):void
        {
            if (!prefixes)
            {
                return;
            };
            this._blockedPrefixes = this._blockedPrefixes.concat(prefixes);
        }

        public function appendBlockedSuffixes(suffixes:Array):void
        {
            if (!suffixes)
            {
                return;
            };
            this._blockedSuffixes = this._blockedSuffixes.concat(suffixes);
        }

        public function appendBlockedOverrides(overrides:Array):void
        {
            if (!overrides)
            {
                return;
            };
            this._blockedOverrides = this._blockedOverrides.concat(overrides);
        }

        public function toString():String
        {
            var str:String = "AnalyticsContext:";
            str = (str + ("\n   isEnabled=" + this.isEnabled));
            str = (str + ("\n   isBlockingAll=" + this.isBlockingAll));
            str = (str + ("\n   _blockedPrefixes=" + this._blockedPrefixes));
            str = (str + ("\n   _blockedSuffixes=" + this._blockedSuffixes));
            str = (str + ("\n   _blockedOverrides=" + this._blockedOverrides));
            return (str);
        }


    }
}//package com.clubpenguin.main.analytics
