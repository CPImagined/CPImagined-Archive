//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.content.forms
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;
    import com.clubpenguin.lib.event.*;
    import flash.display.*;

    public class News extends MovieClip 
    {

        private const USER_SUBMISSION_EVENT:String = "userSubmissionEvent";

        public var done:MovieClip = new MovieClip();//instance name
        public var wait:MovieClip = new MovieClip();//instance name
        public var comments:MovieClip = new MovieClip();//instance name
        public var category:String = "";

        public function News()
        {
            this.done.visible = false;
            this.wait.visible = false;
            this.comments.send_btn.addEventListener(MouseEvent.MOUSE_UP, onSendClicked);
            this.comments.close_btn.addEventListener(MouseEvent.MOUSE_UP, onCloseClicked);
        }

        private function onSendClicked(_arg_1:MouseEvent):void
        {
            trace("in onsendclicked");
            comments.visible = false;
            wait.visible = false;
            done.visible = true;
            done.ok_btn.addEventListener(MouseEvent.MOUSE_UP, onCloseClicked);
            this.dispatchEvent(new SendUserSubmissionEvent(comments.comment_input.text, category));
            trace(("@@@@@ dispatching user submission to category :" + category));
        }

        private function onSendSuccessful(_arg_1:MouseEvent):void
        {
        }

        private function onCloseClicked(_arg_1:MouseEvent):void
        {
            trace("close clicked");
            this.dispatchEvent(new Event("closeOverlay"));
        }


    }
}//package com.clubpenguin.content.forms
    //force all classes
    import com.clubpenguin.lib.event.SendUserSubmissionEvent; com.clubpenguin.lib.event.SendUserSubmissionEvent;
    import com.clubpenguin.content.forms.News; com.clubpenguin.content.forms.News;
