//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist
{
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.mysonglist.context.MySongListContext;

    public class MySongList extends BaseModule 
    {

        public static const INIT_STUDIO_SAVE:String = "init_studio_save";
        public static const INIT_STUDIO_DELETE:String = "init_studio_delete";
        public static const INIT_CLUB:String = "init_club";

        protected var parentContextView:BaseModule;
        private var _initData:String;

        public function MySongList(parentContextView:BaseModule)
        {
            this.parentContextView = parentContextView;
        }

        public function setInitData(initData:String):void
        {
            Log.debug(initData);
            if (initData == null)
            {
                this._initData = INIT_STUDIO_SAVE;
            }
            else
            {
                this._initData = initData;
            };
        }

        override public function init():void
        {
            Log.debug(this._initData);
            context = new MySongListContext(this.parentContextView, injector, this._initData);
        }


    }
}//package com.clubpenguin.music.mysonglist
