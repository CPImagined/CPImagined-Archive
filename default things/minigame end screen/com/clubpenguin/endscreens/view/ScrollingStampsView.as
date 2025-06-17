//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import com.clubpenguin.endscreens.mediator.StampsViewMediator;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;
    import com.clubpenguin.endscreens.model.StampVO;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class ScrollingStampsView extends BaseEmbeddedAssetView 
    {

        private const MAX_VISIBLE_STAMPS:int = 9;

        private var _mediator:StampsViewMediator;
        private var _scrollPane:MovieClip;
        private var _scrollButtonLeft:SimpleButton;
        private var _scrollButtonRight:SimpleButton;
        private var _stamps:Array = new Array();
        private var _frame:String;
        private var _scrollPaneWidth:int;
        private var _scrollPaneMinX:int = 202;

        public function ScrollingStampsView()
        {
            super(EndGameViewAssets.ScrollingStampsSkin, MiniGameEndScreensConstants.SKIN_INSTANCE_NAME_STAMPS_HOLDER);
            instance.visible = false;
        }

        public function initView(mediator:StampsViewMediator):void
        {
            this._mediator = mediator;
        }

        public function setStamps(stamps:Array):void
        {
            var stampView:StampView;
            var stampDescriptionView:StampDescriptionView;
            var stampCount:int;
            while (stampCount < stamps.length)
            {
                stampView = new StampView();
                stampView.updateStamp((stamps[stampCount] as StampVO));
                stampView.x = ((stampCount * MiniGameEndScreensConstants.STAMP_SCROLLPANE_INCREMENT) + (MiniGameEndScreensConstants.STAMP_SCROLLPANE_INCREMENT / 2));
                stampDescriptionView = new StampDescriptionView();
                stampDescriptionView.updateDescription((stamps[stampCount] as StampVO));
                stampView.addDescription(stampDescriptionView);
                this._stamps.push(stampView);
                stampCount++;
            };
        }

        public function showFrame(frame:String):void
        {
            this._frame = frame;
            if (view == null)
            {
                onCompleted.addOnce(this.updateFrameAndText);
            }
            else
            {
                this.updateFrameAndText();
            };
        }

        private function updateFrameAndText():void
        {
            (view as MovieClip).gotoAndStop(this._frame);
            this._scrollPane = view[MiniGameEndScreensConstants.STAMPS_SCROLL_PANE];
            instance.visible = true;
            this.updateText();
            var stampCount:int;
            while (stampCount < this._stamps.length)
            {
                this._scrollPane.addChild(this._stamps[stampCount]);
                stampCount++;
            };
            this.setupScrolling();
        }

        private function updateText():void
        {
            LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.STAMPS_RATIO_TEXT]).localTextField, this._mediator.stampRatio());
        }

        private function setupScrolling():void
        {
            this.updateScrollPaneMinX();
            this._scrollButtonLeft = view[MiniGameEndScreensConstants.STAMPS_SCROLL_LEFT_BUTTON];
            this._scrollButtonRight = view[MiniGameEndScreensConstants.STAMPS_SCROLL_RIGHT_BUTTON];
            if (this._scrollPaneWidth > MiniGameEndScreensConstants.STAMP_SCROLLPANE_VISIBLE_WIDTH)
            {
                view.addEventListener(MouseEvent.MOUSE_WHEEL, this._mediator.mouseScrollWheel);
                this._scrollButtonLeft.addEventListener(MouseEvent.CLICK, this._mediator.mouseClickScrollButtonLeft);
                this._scrollButtonLeft.addEventListener(MouseEvent.MOUSE_DOWN, this._mediator.mouseDownScrollButtonLeft);
                this._scrollButtonLeft.addEventListener(MouseEvent.MOUSE_UP, this._mediator.mouseUpScrollButtonLeft);
                this._scrollButtonRight.addEventListener(MouseEvent.CLICK, this._mediator.mouseClickScrollButtonRight);
                this._scrollButtonRight.addEventListener(MouseEvent.MOUSE_DOWN, this._mediator.mouseDownScrollButtonRight);
                this._scrollButtonRight.addEventListener(MouseEvent.MOUSE_UP, this._mediator.mouseUpScrollButtonRight);
            };
            if (this._stamps.length <= this.MAX_VISIBLE_STAMPS)
            {
                this._scrollButtonLeft.visible = false;
                this._scrollButtonRight.visible = false;
            }
            else
            {
                this._scrollButtonLeft.alpha = 0.5;
            };
        }

        private function updateScrollPaneMinX():void
        {
            this._scrollPaneWidth = (MiniGameEndScreensConstants.STAMP_SCROLLPANE_INCREMENT * this._stamps.length);
            var scrollPaneOverlap:int = (this._scrollPaneWidth - MiniGameEndScreensConstants.STAMP_SCROLLPANE_VISIBLE_WIDTH);
            this._scrollPaneMinX = (MiniGameEndScreensConstants.STAMP_SCROLLPANE_START_X - scrollPaneOverlap);
        }

        public function clearListeners():void
        {
            if (this._scrollPaneWidth > MiniGameEndScreensConstants.STAMP_SCROLLPANE_VISIBLE_WIDTH)
            {
                view.removeEventListener(MouseEvent.MOUSE_WHEEL, this._mediator.mouseScrollWheel);
                this._scrollButtonLeft.removeEventListener(MouseEvent.CLICK, this._mediator.mouseClickScrollButtonLeft);
                this._scrollButtonLeft.removeEventListener(MouseEvent.MOUSE_DOWN, this._mediator.mouseDownScrollButtonLeft);
                this._scrollButtonLeft.removeEventListener(MouseEvent.MOUSE_UP, this._mediator.mouseUpScrollButtonLeft);
                this._scrollButtonRight.removeEventListener(MouseEvent.CLICK, this._mediator.mouseClickScrollButtonRight);
                this._scrollButtonRight.removeEventListener(MouseEvent.MOUSE_DOWN, this._mediator.mouseDownScrollButtonRight);
                this._scrollButtonRight.removeEventListener(MouseEvent.MOUSE_UP, this._mediator.mouseUpScrollButtonRight);
            };
            var i:int;
            while (i < this._stamps.length)
            {
                (this._stamps[i] as StampView).destroy();
                i++;
            };
        }

        public function scrollLeft(event:Event=null):void
        {
            this._scrollButtonRight.alpha = 1;
            if (this._scrollPane.x >= (MiniGameEndScreensConstants.STAMP_SCROLLPANE_START_X - MiniGameEndScreensConstants.STAMP_SCROLLPANE_INCREMENT))
            {
                this._scrollPane.x = MiniGameEndScreensConstants.STAMP_SCROLLPANE_START_X;
                this._scrollButtonLeft.alpha = 0.5;
                return;
            };
            this._scrollPane.x = (this._scrollPane.x + MiniGameEndScreensConstants.STAMP_SCROLLPANE_INCREMENT);
        }

        public function scrollRight(event:Event=null):void
        {
            this._scrollButtonLeft.alpha = 1;
            if (this._scrollPane.x <= (this._scrollPaneMinX + MiniGameEndScreensConstants.STAMP_SCROLLPANE_INCREMENT))
            {
                this._scrollPane.x = this._scrollPaneMinX;
                this._scrollButtonRight.alpha = 0.5;
                return;
            };
            this._scrollPane.x = (this._scrollPane.x - MiniGameEndScreensConstants.STAMP_SCROLLPANE_INCREMENT);
        }


    }
}//package com.clubpenguin.endscreens.view
