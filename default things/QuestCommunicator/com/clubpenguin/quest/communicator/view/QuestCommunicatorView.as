//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.quest.communicator.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import com.clubpenguin.tools.localtext.core.ILocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import flash.text.TextField;

    public class QuestCommunicatorView extends BaseEmbeddedAssetView 
    {

        public const COMMUNICATOR_VIEW:String = "communicator";

        private var localText:ILocalText;
        private var _message:String;
        private var _expression:Number;

        public function QuestCommunicatorView(AssetClass:Class)
        {
            super(AssetClass, this.COMMUNICATOR_VIEW);
            this.localText = (LocalTextProxy.localText as ILocalText);
            this.onCompleted.addOnce(this.init);
        }

        private function init():void
        {
            MovieClip(view).stop();
        }

        public function getView():DisplayObjectContainer
        {
            return (view);
        }

        public function startViewAnimation(message:String, expression:Number):void
        {
            this._message = message;
            this._expression = expression;
            MovieClip(view).gotoAndPlay(2);
            MovieClip(view).addFrameScript(8, this.setupTheMessage);
			MovieClip(view).addFrameScript(17, this.stopTheMessage);
			MovieClip(view).addFrameScript(31, this.resetCommunicator);
        }

		private function stopChar():void
		{
			MovieClip(view["character"]["char_mc"]).stop();
		}

		private function stopTheMessage():void
		{
			MovieClip(view).stop();
		}

        private function setupTheMessage():void
        {
            this.setExpression();
            this.setBubbleText();
            MovieClip(view["dismiss_speech_btn"]).buttonMode = true;
        }

        private function setBubbleText():void
        {
            var theBubble:TextField = view["text_field_mc"]["text_field"];
            theBubble.text = this._message;
        }

        private function setExpression():void
        {
            var characterMC:MovieClip = (view["character"] as MovieClip);
            characterMC.gotoAndStop(this._expression);
			MovieClip(view["character"]["char_mc"]).addFrameScript(9, this.stopChar);
        }

        public function dismissCommunicator():void
        {
            MovieClip(view).gotoAndPlay(19);
			MovieClip(view["character"]["char_mc"]).gotoAndPlay(10);
        }

        private function resetCommunicator():void
        {
            MovieClip(view).gotoAndStop(1);
        }


    }
}//package com.clubpenguin.quest.communicator.view
