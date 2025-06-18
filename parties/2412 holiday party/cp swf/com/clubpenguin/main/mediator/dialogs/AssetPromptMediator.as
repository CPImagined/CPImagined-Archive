//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.mediator.dialogs
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import flash.display.MovieClip;
    import com.clubpenguin.main.vo.AssetPromptVO;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.services.notifications.INotificationService;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.lib.util.Log;
    import flash.display.Loader;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class AssetPromptMediator extends Mediator 
    {

        [Inject]
        public var mainContext:MainContext;
        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var bridge:IAVMBridgeService;
        private var _skinAsset:MovieClip;
        private var _assetPromptVO:AssetPromptVO;
        private var _buttonClipNameToActionFunction:Dictionary;
        private var _buttonClipNameToRoomKey:Dictionary;
        private var _notificationService:INotificationService;
        private var _localText:LocalText;

        public function AssetPromptMediator()
        {
            Log.debug("Creating new AssetPromptMediator");
        }

        public function init(assetPromptVO:AssetPromptVO, notificationService:INotificationService):void
        {
            Log.debug(("[AssetPromptMediator] init with assetPromptVO: " + assetPromptVO));
            this.bridge.getCloseAssetPrompt().addOnce(this.closePrompt);
            this._assetPromptVO = assetPromptVO;
            this._notificationService = notificationService;
            this._buttonClipNameToActionFunction = new Dictionary();
            this._buttonClipNameToRoomKey = new Dictionary();
            var loadedAsset:MovieClip = MovieClip(Loader(assetPromptVO.object).content);
            this._skinAsset = loadedAsset.prompt;
            this.mainContext.contextView.addChild(this._skinAsset);
            this._localText = (LocalTextProxy.localText as LocalText);
            this.localizeText();
            this.setupButtons();
            this.setupFrames();
        }

        public function destroy():void
        {
            this.removeButtonEventListener();
            this._buttonClipNameToActionFunction = null;
            this._buttonClipNameToRoomKey = null;
            this.mainContext.contextView.removeChild(this._skinAsset);
            this._skinAsset = null;
            this._assetPromptVO = null;
        }

        private function localizeText():void
        {
            var name:String;
            if (this._assetPromptVO.textClipStringTokens)
            {
                for (name in this._assetPromptVO.textClipStringTokens)
                {
                    this._localText.setText(ILocalTextComponent(this._skinAsset.getChildByName(name)).localTextField, this.localizationManager.getLocalizedString(this._assetPromptVO.textClipStringTokens[name]));
                };
            };
            if (this._assetPromptVO.textClipLocalizedStrings)
            {
                for (name in this._assetPromptVO.textClipLocalizedStrings)
                {
                    this._localText.setText(ILocalTextComponent(this._skinAsset.getChildByName(name)).localTextField, this._assetPromptVO.textClipLocalizedStrings[name]);
                };
            };
        }

        private function setupButtons():void
        {
            var name:String;
            if (this._assetPromptVO.buttonClipPredefinedActions)
            {
                for (name in this._assetPromptVO.buttonClipPredefinedActions)
                {
                    this.addPredefinedEventListener(MovieClip(this._skinAsset.getChildByName(name)), this._assetPromptVO.buttonClipPredefinedActions[name]);
                };
            };
            if (this._assetPromptVO.buttonClipFunctions)
            {
                for (name in this._assetPromptVO.buttonClipFunctions)
                {
                    this.addButtonEventListener(MovieClip(this._skinAsset.getChildByName(name)), this._assetPromptVO.buttonClipFunctions[name]);
                };
            };
            if (this._assetPromptVO.joinRoomActions)
            {
                for (name in this._assetPromptVO.joinRoomActions)
                {
                    this.addJoinRoomAction(MovieClip(this._skinAsset.getChildByName(name)), this._assetPromptVO.joinRoomActions[name]);
                };
            };
        }

        private function setupFrames():void
        {
            var name:String;
            if (this._assetPromptVO.startFrames)
            {
                for (name in this._assetPromptVO.startFrames)
                {
                    MovieClip(this._skinAsset.getChildByName(name)).gotoAndStop(this._assetPromptVO.startFrames[name]);
                };
            };
        }

        private function addPredefinedEventListener(buttonClip:MovieClip, action:String):void
        {
            switch (action)
            {
                case AssetPromptVO.ACTION_CLOSE:
                    this.addButtonEventListener(buttonClip, this.closePrompt);
                    break;
            };
        }

        private function addButtonEventListener(buttonClip:MovieClip, action:Function):void
        {
            buttonClip.buttonMode = true;
            buttonClip.mouseChildren = false;
            buttonClip.addEventListener(MouseEvent.CLICK, this.onButtonClicked);
            this._buttonClipNameToActionFunction[buttonClip.name] = action;
        }

        private function addJoinRoomAction(buttonClip:MovieClip, roomKey:String):void
        {
            buttonClip.buttonMode = true;
            buttonClip.mouseChildren = false;
            buttonClip.addEventListener(MouseEvent.CLICK, this.onJoinRoomButtonClicked);
            this._buttonClipNameToRoomKey[buttonClip.name] = roomKey;
        }

        private function removeButtonEventListener():void
        {
            var buttonClipName:String;
            var buttonClip:MovieClip;
            for (buttonClipName in this._buttonClipNameToActionFunction)
            {
                buttonClip = MovieClip(this._skinAsset.getChildByName(buttonClipName));
                buttonClip.removeEventListener(MouseEvent.CLICK, this.onButtonClicked);
            };
        }

        private function onButtonClicked(mouseEvent:MouseEvent):void
        {
            var buttonClip:MovieClip = MovieClip(mouseEvent.currentTarget);
            if (this._buttonClipNameToActionFunction[buttonClip.name])
            {
                this._buttonClipNameToActionFunction[buttonClip.name].call();
            };
        }

        private function onJoinRoomButtonClicked(mouseEvent:MouseEvent):void
        {
            var buttonClip:MovieClip = MovieClip(mouseEvent.currentTarget);
            if (this._buttonClipNameToRoomKey[buttonClip.name])
            {
                this.joinRoom(this._buttonClipNameToRoomKey[buttonClip.name]);
            };
        }

        private function closePrompt():void
        {
            this._notificationService.start();
            this.destroy();
        }

        private function joinRoom(roomName:String):void
        {
            var joinRoomMessage:AVMBridgeMessage;
            if (roomName == "igloo")
            {
                joinRoomMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_TELEPORT_TO_MY_IGLOO);
            }
            else
            {
                joinRoomMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_JOIN_ROOM);
                joinRoomMessage.data = new Object();
                joinRoomMessage.data.roomName = roomName;
            };
            this.bridge.send(joinRoomMessage);
            this.closePrompt();
        }


    }
}//package com.clubpenguin.main.mediator.dialogs
