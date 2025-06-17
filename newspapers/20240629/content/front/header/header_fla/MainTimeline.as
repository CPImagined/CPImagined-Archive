//Created by Action Script Viewer - https://www.buraks.com/asv
package header_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var header:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 597;
            this.visibleHeight = 94;
        }


    }
}//package header_fla
    //force all classes
    import com.clubpenguin.newspaper.models.vo.ContentActionVO; com.clubpenguin.newspaper.models.vo.ContentActionVO;
    import com.disney.disneylearning.OpcodeJournal; com.disney.disneylearning.OpcodeJournal;
    import com.adobe.crypto.MD5; com.adobe.crypto.MD5;
    import com.adobe.utils.IntUtil; com.adobe.utils.IntUtil;
    import com.clubpenguin.newspaper.events.ContentButtonEvent; com.clubpenguin.newspaper.events.ContentButtonEvent;
    import com.disney.disneylearning.events.DLSEvent; com.disney.disneylearning.events.DLSEvent;
    import com.disney.disneylearning.managers.NewsPaperDLSManager; com.disney.disneylearning.managers.NewsPaperDLSManager;
    import com.clubpenguin.newspaper.components.ContentButtonComponent; com.clubpenguin.newspaper.components.ContentButtonComponent;
    import header_fla.Header_1; header_fla.Header_1;
    import header_fla.MainTimeline; header_fla.MainTimeline;
