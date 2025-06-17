//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world.view
{
    import flash.display.MovieClip;
    import flash.display.Loader;

    public class AS2ContentView extends MovieClip 
    {

        private var _as2Content:Loader;


        public function addContent(as2Content:Loader):void
        {
            if (as2Content == null)
            {
                throw (new Error("AS2ContentView.addContent - as2Content Loader is null."));
            };
            this._as2Content = as2Content;
            addChild(this._as2Content);
        }

        public function unload():void
        {
            if (this._as2Content == null)
            {
                return;
            };
            this._as2Content.unload();
            removeChild(this._as2Content);
            this._as2Content = null;
        }


    }
}//package com.clubpenguin.world.view
