//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.PufflePenView;
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.services.socket.puffles.PuffleCareItemsService;
    import com.clubpenguin.puffles.adoption.services.PuffleAdoptionDLearningService;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.puffles.adoption.AdoptionContext;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.main.model.ModuleModel;
    import com.clubpenguin.puffles.adoption.view.Spotlight;
    import com.clubpenguin.puffles.adoption.view.AdoptionDialogView;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import org.osflash.signals.Signal;
    import com.clubpenguin.puffles.adoption.view.PuffleView;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.main.vo.ComplexPromptVO;
    import com.clubpenguin.puffles.adoption.model.AdoptionConstants;
    import com.clubpenguin.puffles.adoption.model.PufflePenViewEnum;
    import com.clubpenguin.puffles.adoption.view.EmbeddedAdoptionAssets;
    import com.clubpenguin.main.vo.AssetPromptVO;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;

    public class PufflePenMediator extends Mediator 
    {

        private static var MEMBER_ONLY_ACTIVITY:String = "membershipPayload";

        private const NON_MEMBER_PUFFLE_LIMIT:int = 2;
        private const NOT_ENOUGH_COINS:uint = 401;
        private const MAX_PUFFLES:uint = 440;
        private const ENGLISH_LANG_CODE:String = "en";

        [Inject]
        public var view:PufflePenView;
        [Inject]
        public var adoptionSignalBus:AdoptionSignalBus;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var injector:IInjector;
        [Inject]
        public var getInventoryService:PuffleCareItemsService;
        [Inject]
        public var dlearningService:PuffleAdoptionDLearningService;
        [Inject]
        public var pathsVO:PathsVO;
        [Inject]
        public var appSignalBus:SignalBus;
        [Inject]
        public var environmentDataVO:EnvironmentDataVO;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var context:AdoptionContext;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var mainModule:ModuleModel;
        private var spotlight:Spotlight = new Spotlight();
        private var puffleViewCollection:Array;
        private var puffleIdCollection:Array;
        private var adoptionDialogView:AdoptionDialogView;
        private var statsClipBoard:MovieClip;
        private var localText:LocalText;
        private var selectedPuffleViewCollectionIndex:uint;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onViewComplete);
        }

        private function onViewComplete():void
        {
            this.view.addEventListener(Event.REMOVED_FROM_STAGE, this.doGarbageCollection, false, 0, true);
            this.adoptionSignalBus.chosenPuffleChanged.add(this.onPuffleChosen);
            this.statsClipBoard = this.view.statsBoard;
            this.view.modalClip.visible = false;
            this.view.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClicked, false, 0, true);
            this.view.lightRays.mouseEnabled = false;
            if (this.mainModel.myPlayerVO.is_member)
            {
                this.view.modalNonMember.visible = false;
                this.view.nonmemberPuffleRug.visible = false;
            }
            else
            {
                this.view.modalNonMember.mouseEnabled = false;
                this.view.memberPuffleRug.visible = false;
            };
            this.localText.setText(ILocalTextComponent(this.statsClipBoard.clipboardDefault.pufflesEveryone).localTextField, this.localizer.getLocalizedString("w.puffleadoption.statsboard.title"));
            this.localText.setText(ILocalTextComponent(this.statsClipBoard.clipboardDefault.pufflesMembers).localTextField, this.localizer.getLocalizedString("w.puffleadoption.statsboard.members"));
            this.localText.setText(ILocalTextComponent(this.statsClipBoard.clipboardDefault.puffleCount).localTextField, this.localizer.getLocalizedString("w.puffleadoption.statsboard.pufflecount", String(this.adoptionModel.playerVO.puffles.getSize())));
            this.localText.setText(ILocalTextComponent(this.statsClipBoard.clipboardBack.coinTotal.yourCoins).localTextField, this.localizer.getLocalizedString("w.puffleadoption.statsboard.totalcoins", this.mainModel.getCoins()));
            this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.buttonContent.txtAdoptButtonMember).localTextField, this.localizer.getLocalizedString("w.puffleadoption.buttontext"));
            this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.txtAdoptButtonNonMember).localTextField, this.localizer.getLocalizedString("w.puffleadoption.buttontext"));
            this.adoptionModel.puffleAdopted.add(this.onPuffleAdopted);
            this.adoptionModel.notEnoughCoins.add(this.onPuffleAdoptionNotEnoughCoins);
            this.view.btnRainbowPoster.buttonMode = true;
            this.view.btnRainbowPoster.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverRainbowPufflePoster);
            this.view.btnRainbowPoster.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutRainbowPufflePoster);
            this.view.btnRainbowPoster.addEventListener(MouseEvent.MOUSE_UP, this.onClickRainbowPufflePoster);
            this.view.btnGoldPoster.buttonMode = true;
            this.view.btnGoldPoster.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverGoldPufflePoster);
            this.view.btnGoldPoster.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutGoldPufflePoster);
            this.view.btnGoldPoster.addEventListener(MouseEvent.MOUSE_UP, this.onClickGoldPufflePoster);
            this.hideStatsBoard();
            this.setupPuffleViews();
            this.setupPuffleButtons();
            this.setInitiallySelectedPuffle();
            Signal(this.appSignalBus.getClosePopups()).add(this.onClosePopups);
        }

        private function onPuffleAdoptionNotEnoughCoins():void
        {
            this.view.modalClip.visible = false;
        }

        private function onPuffleAdopted():void
        {
            this.getInventoryService.requestInventory();
        }

        private function onPuffleChosen(puffleVO:PuffleVO):void
        {
            this.spotlight.switchOff();
            this.statsClipBoard.clipboardDefault.visible = false;
            var i:int;
            while (i < this.puffleViewCollection.length)
            {
                if (PuffleView(this.puffleViewCollection[i]).pufflePenViewEnum.ID == puffleVO.uniqueId)
                {
                    this.selectedPuffleViewCollectionIndex = i;
                    this.spotlight.switchOn(this.puffleViewCollection[i]);
                    this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.colorText).localTextField, puffleVO.description);
                    this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.statTitle0).localTextField, this.localizer.getLocalizedString("w.puffleadoption.selected.stats.attitude"));
                    this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.statDescription0).localTextField, this.localizer.getLocalizedString(("w.pufflecare.manual.description.value.personality." + puffleVO.typeName)));
                    if (puffleVO.isWild)
                    {
                        this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.statTitle1).localTextField, this.localizer.getLocalizedString("w.pufflecare.manual.description.label.coolfact"));
                        this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.statDescription1).localTextField, this.localizer.getLocalizedString(("w.pufflecare.manual.description.value.coolfact." + puffleVO.typeName)));
                        this.statsClipBoard.puffleFacts.statTitle2.visible = false;
                        this.statsClipBoard.puffleFacts.statDescription2.visible = false;
                    }
                    else
                    {
                        this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.statTitle1).localTextField, this.localizer.getLocalizedString("w.pufflecare.manual.description.label.favoritesnacks"));
                        this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.statDescription1).localTextField, this.localizer.getLocalizedString(("w.pufflecare.manual.description.value.favoritesnacks." + puffleVO.typeName)));
                        this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.statTitle2).localTextField, this.localizer.getLocalizedString("w.pufflecare.manual.description.label.coolfact"));
                        this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.statDescription2).localTextField, this.localizer.getLocalizedString(("w.pufflecare.manual.description.value.coolfact." + puffleVO.typeName)));
                        this.statsClipBoard.puffleFacts.statTitle2.visible = true;
                        this.statsClipBoard.puffleFacts.statDescription2.visible = true;
                    };
                    this.localText.setText(ILocalTextComponent(this.statsClipBoard.puffleFacts.price).localTextField, String(puffleVO.price));
                    this.statsClipBoard.puffleFacts.visible = true;
                    this.statsClipBoard.puffleFacts.colorBlotch.gotoAndStop(puffleVO.typeName);
                    this.statsClipBoard.puffleFacts.buttonContent.visible = true;
                    this.statsClipBoard.puffleFacts.buttonContent.mouseChildren = false;
                    this.statsClipBoard.puffleFacts.buttonContent.mouseEnabled = false;
                    if (this.adoptionModel.isSelectedPuffleMemberOnly)
                    {
                        this.statsClipBoard.puffleFacts.txtAdoptButtonNonMember.visible = false;
                        this.statsClipBoard.puffleFacts.buttonContent.visible = true;
                    }
                    else
                    {
                        this.statsClipBoard.puffleFacts.txtAdoptButtonNonMember.visible = true;
                        this.statsClipBoard.puffleFacts.buttonContent.visible = false;
                    };
                    this.statsClipBoard.puffleFacts.adoptButton.buttonMode = true;
                    this.statsClipBoard.puffleFacts.adoptButton.mouseChildren = false;
                    if (!this.statsClipBoard.puffleFacts.adoptButton.hasEventListener(MouseEvent.MOUSE_UP))
                    {
                        this.statsClipBoard.puffleFacts.adoptButton.addEventListener(MouseEvent.MOUSE_UP, this.onAdoptClick);
                    };
                }
                else
                {
                    PuffleView(this.puffleViewCollection[i]).deselect.dispatch();
                };
                i++;
            };
        }

        private function onMouseOverRainbowPufflePoster(event:MouseEvent):void
        {
            this.view.btnRainbowPoster.nextFrame();
        }

        private function onMouseOutRainbowPufflePoster(event:MouseEvent):void
        {
            this.view.btnRainbowPoster.prevFrame();
        }

        private function onClickRainbowPufflePoster(event:MouseEvent):void
        {
            this.showRainbowPufflePoster();
        }

        private function onMouseOverGoldPufflePoster(event:MouseEvent):void
        {
            this.view.btnGoldPoster.nextFrame();
        }

        private function onMouseOutGoldPufflePoster(event:MouseEvent):void
        {
            this.view.btnGoldPoster.prevFrame();
        }

        private function onClickGoldPufflePoster(event:MouseEvent):void
        {
            this.showGoldPufflePoster();
        }

        private function onAdoptClick(event:MouseEvent):void
        {
            var numPuffles:uint;
            var data:Object;
            var complexPromptVO:ComplexPromptVO;
            var payload:Object;
            var isMember:Boolean = this.adoptionModel.playerVO.is_member;
            numPuffles = this.adoptionModel.playerVO.puffles.getSize();
            var overPuffleLimit:* = (numPuffles >= AdoptionConstants.MEMBER_PUFFLE_LIMIT);
            var isFreePuffle:* = (!(this.adoptionModel.isSelectedPuffleMemberOnly));
            if (this.adoptionModel.playerVO.coins < this.adoptionModel.selectedPuffle.price)
            {
                data = {
                    "hasPuffle":(numPuffles > 0),
                    "error_code":this.NOT_ENOUGH_COINS
                };
                complexPromptVO = new ComplexPromptVO("not_enough_coins", data);
                this.mainModel.getAVMBridge().getShowComplexPrompt().dispatch(complexPromptVO);
                return;
            };
            if (isMember)
            {
                payload = new Object();
                if (numPuffles >= this.NON_MEMBER_PUFFLE_LIMIT)
                {
                    payload.context = "pufflePen";
                    payload.action = "buyOver2Puffles";
                    this.mainModel.getAVMBridge().getAS2DataReceived().dispatch(MEMBER_ONLY_ACTIVITY, payload);
                }
                else
                {
                    if (!isFreePuffle)
                    {
                        payload.context = "pufflePen";
                        payload.action = "buyColoredPuffle";
                        this.mainModel.getAVMBridge().getAS2DataReceived().dispatch(MEMBER_ONLY_ACTIVITY, payload);
                    };
                };
                if (!overPuffleLimit)
                {
                    this.showAdoptionDialog();
                }
                else
                {
                    (this.adoptionSignalBus.sendError as Signal).dispatch(this.MAX_PUFFLES);
                };
            }
            else
            {
                if (!isFreePuffle)
                {
                    this.showAdoptionOopsDialog();
                }
                else
                {
                    if (numPuffles >= this.NON_MEMBER_PUFFLE_LIMIT)
                    {
                        this.showAdoptionOops2PufflesDialog();
                    }
                    else
                    {
                        this.showAdoptionDialog();
                    };
                };
            };
        }

        private function showAdoptionDialog():void
        {
            var selectedPufflePenViewEnum:PufflePenViewEnum = (this.puffleIdCollection[this.selectedPuffleViewCollectionIndex] as PufflePenViewEnum);
            this.statsClipBoard.visible = false;
            this.view.modalClip.visible = true;
            this.adoptionDialogView = new AdoptionDialogView(EmbeddedAdoptionAssets.AdoptionDialogAsset);
            this.adoptionDialogView.puffleAnimClips = new Array(MovieClip(new selectedPufflePenViewEnum.ambientViewClass()), MovieClip(new selectedPufflePenViewEnum.ambient2ViewClass()), MovieClip(new selectedPufflePenViewEnum.selectedViewClass()));
            this.adoptionDialogView.onCompleted.addOnce(this.onAdoptionDialogLoaded);
            this.view.addChild(this.adoptionDialogView);
        }

        private function onAdoptionDialogLoaded():void
        {
            (mediatorMap.retrieveMediator(this.adoptionDialogView) as AdoptionDialogMediator).closeDialog.add(this.onCloseAdoption);
        }

        private function showAdoptionOopsDialog():void
        {
            var data:Object = AdoptionConstants.getOopsObjectByPuffleName();
            var oopsMessageFilePath:String = this.pathsVO.data["global"][AdoptionConstants.OOPS_ADOPT_MEMBER_PUFFLE_FILE_KEY];
            var messageUrl:String = (this.environmentDataVO.globalContentPath + oopsMessageFilePath);
            this.appSignalBus.loadMembershipPufflePrompt.dispatch(messageUrl, data);
        }

        private function showAdoptionOops2PufflesDialog():void
        {
            var messageUrl:String;
            var loadMembershipPrompt:Signal;
            var oopsMessageFilePath:String = this.pathsVO.data["global"][AdoptionConstants.OVER_2_PUFFLES_OOPS_MESSAGE_FILE_KEY];
            if (oopsMessageFilePath)
            {
                messageUrl = (this.environmentDataVO.globalContentPath + oopsMessageFilePath);
                loadMembershipPrompt = Signal(this.appSignalBus.getLoadMembershipPrompt());
                loadMembershipPrompt.dispatch(messageUrl, {
                    "fileKey":AdoptionConstants.OVER_2_PUFFLES_OOPS_MESSAGE_FILE_KEY,
                    "oopsTag":AdoptionConstants.OVER_2_PUFFLES_OOPS_TAG
                });
            };
        }

        private function showRainbowPufflePoster():void
        {
            var assetPromptVO:AssetPromptVO = new AssetPromptVO();
            assetPromptVO.textClipStringTokens = new Object();
            assetPromptVO.textClipStringTokens.questTitleText = "w.puffleadoption.dialog.rainbowposter.questtitle";
            assetPromptVO.textClipStringTokens.step1Text = "w.puffleadoption.dialog.rainbowposter.questgotohotellobby";
            assetPromptVO.textClipStringTokens.step2Text = "w.puffleadoption.dialog.rainbowposter.questfinishtasks";
            assetPromptVO.textClipStringTokens.step3Text = "w.puffleadoption.dialog.rainbowposter.questlaunchcloudforest";
            assetPromptVO.textClipStringTokens.puffleHotelBtnClipText = "w.puffleadoption.dialog.rainbowposter.gotohotellobby";
            assetPromptVO.startFrames = new Object();
            assetPromptVO.startFrames.mainTitle = this.mainModel.getEnvironmentData().language;
            assetPromptVO.startFrames.member = this.mainModel.getEnvironmentData().language;
            assetPromptVO.buttonClipPredefinedActions = new Object();
            assetPromptVO.buttonClipPredefinedActions.closeButton = AssetPromptVO.ACTION_CLOSE;
            assetPromptVO.buttonClipFunctions = new Object();
            assetPromptVO.buttonClipFunctions.puffleHotelBtnClip = function ():void
            {
                var joinRoomMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_JOIN_ROOM);
                joinRoomMessage.data = new Object();
                joinRoomMessage.data.roomName = "hotellobby";
                bridge.send(joinRoomMessage);
                if (mainModule.isModuleOpen(ModuleFilenamesEnum.PUFFLE_ADOPTION))
                {
                    mainModule.getModuleWithKey(ModuleFilenamesEnum.PUFFLE_ADOPTION).closeModule();
                };
                bridge.getCloseAssetPrompt().dispatch();
            };
            if (!this.mainModel.isMember())
            {
                assetPromptVO.textClipStringTokens.questTitleText = "w.puffleadoption.dialog.rainbowposter.learnmoremembership";
                assetPromptVO.startFrames.member2 = this.mainModel.getEnvironmentData().language;
                assetPromptVO.buttonClipFunctions.buyMembershipBtnClip = function ():void
                {
                    var lang:String;
                    var URL:String;
                    var request:URLRequest;
                    try
                    {
                        lang = mainModel.getEnvironmentData().language;
                        if (lang == ENGLISH_LANG_CODE)
                        {
                            URL = "http://www.clubpenguin.com/membership/";
                        }
                        else
                        {
                            URL = (("http://www.clubpenguin.com/" + lang) + "/membership/");
                        };
                        request = new URLRequest(URL);
                        request.method = URLRequestMethod.POST;
                        navigateToURL(request, "_blank");
                    }
                    catch(error:Error)
                    {
                    };
                };
            };
            this.sendOpenPoster(assetPromptVO, "w.puffle.poster.rainbow");
        }

        private function showGoldPufflePoster():void
        {
            var assetPromptVO:AssetPromptVO = new AssetPromptVO();
            assetPromptVO.textClipStringTokens = new Object();
            assetPromptVO.textClipStringTokens.questTitleText = "w.puffleadoption.gold.poster.title";
            assetPromptVO.textClipStringTokens.step1Text = "w.puffleadoption.gold.poster.description";
            assetPromptVO.textClipStringTokens.puffleOKButtonText = "w.puffleadoption.gold.poster.memberbutton";
            assetPromptVO.startFrames = new Object();
            assetPromptVO.startFrames.questLogo = this.mainModel.getEnvironmentData().language;
            assetPromptVO.buttonClipPredefinedActions = new Object();
            assetPromptVO.buttonClipPredefinedActions.closeButton = AssetPromptVO.ACTION_CLOSE;
            assetPromptVO.buttonClipPredefinedActions.ok_button = AssetPromptVO.ACTION_CLOSE;
            if (!this.mainModel.isMember())
            {
                assetPromptVO.textClipStringTokens.buyMembershipBtnClipText = "w.puffleadoption.dialog.rainbowposter.learnmoremembership";
                assetPromptVO.startFrames.member = this.mainModel.getEnvironmentData().language;
                assetPromptVO.buttonClipFunctions = new Object();
                assetPromptVO.buttonClipFunctions.buyMembershipBtnClip = function ():void
                {
                    var lang:String;
                    var URL:String;
                    var request:URLRequest;
                    try
                    {
                        lang = mainModel.getEnvironmentData().language;
                        if (lang == ENGLISH_LANG_CODE)
                        {
                            URL = "http://www.clubpenguin.com/membership/";
                        }
                        else
                        {
                            URL = (("http://www.clubpenguin.com/" + lang) + "/membership/");
                        };
                        request = new URLRequest(URL);
                        request.method = URLRequestMethod.POST;
                        navigateToURL(request, "_blank");
                    }
                    catch(error:Error)
                    {
                    };
                };
            };
            this.sendOpenPoster(assetPromptVO, "w.puffle.poster.gold");
        }

        private function sendOpenPoster(assetPromptVO:AssetPromptVO, promptFileKey:String):void
        {
            var assetPromptFilePath:String = this.mainModel.getPathsVO().data["global"][promptFileKey];
            if (this.mainModel.isMember())
            {
                assetPromptFilePath = assetPromptFilePath.split(".swf").join("_member.swf");
            };
            assetPromptVO.url = (this.mainModel.getEnvironmentData().globalContentPath + assetPromptFilePath);
            this.bridge.getShowAssetPrompt().dispatch(assetPromptVO);
        }

        private function onCloseAdoption(yesAdoptClicked:Boolean):void
        {
            if (!yesAdoptClicked)
            {
                this.view.modalClip.visible = false;
                this.statsClipBoard.visible = true;
            };
            this.view.removeChild(this.adoptionDialogView);
        }

        private function onClosePopups():void
        {
            this.closePuffleAdoptionModule();
        }

        private function onCloseClicked(event:MouseEvent):void
        {
            this.closePuffleAdoptionModule();
        }

        private function closePuffleAdoptionModule():void
        {
            this.closeModule.dispatch(this.context.contextView);
        }

        private function setInitiallySelectedPuffle():void
        {
            var pufflePenViewEnum:PufflePenViewEnum;
            var puffleVO:PuffleVO;
            if (this.adoptionModel.puffleAdoptType != null)
            {
                pufflePenViewEnum = PufflePenViewEnum.getPenViewEnumByName(this.adoptionModel.puffleAdoptType);
                if (pufflePenViewEnum != null)
                {
                    puffleVO = pufflePenViewEnum.createPuffleVO();
                    Signal(this.adoptionSignalBus.setChosenPuffle).dispatch(puffleVO);
                };
            };
        }

        private function setupPuffleButtons():void
        {
            var puffleButton:MovieClip;
            var i:uint;
            while (i < this.puffleIdCollection.length)
            {
                puffleButton = this.view.getPuffleButton(PufflePenViewEnum(this.puffleIdCollection[i]).name);
                puffleButton.buttonMode = true;
                puffleButton.mouseChildren = false;
                puffleButton.addEventListener(MouseEvent.CLICK, this.onPuffleButtonClicked);
                i++;
            };
        }

        private function onPuffleButtonClicked(event:MouseEvent):void
        {
            var pufflePenViewEnum:PufflePenViewEnum;
            var puffleVO:PuffleVO;
            var i:uint;
            while (i < this.puffleIdCollection.length)
            {
                pufflePenViewEnum = this.puffleIdCollection[i];
                if (MovieClip(event.target).name.search(pufflePenViewEnum.name) != -1)
                {
                    puffleVO = pufflePenViewEnum.createPuffleVO();
                    Signal(this.adoptionSignalBus.setChosenPuffle).dispatch(puffleVO);
                };
                i++;
            };
        }

        private function setupPuffleViews():void
        {
            this.puffleViewCollection = [];
            this.puffleIdCollection = [PufflePenViewEnum.BLUE, PufflePenViewEnum.PINK, PufflePenViewEnum.BLACK, PufflePenViewEnum.GREEN, PufflePenViewEnum.PURPLE, PufflePenViewEnum.RED, PufflePenViewEnum.YELLOW, PufflePenViewEnum.WHITE, PufflePenViewEnum.ORANGE, PufflePenViewEnum.BROWN, PufflePenViewEnum.ORANGE_TABBY_CAT, PufflePenViewEnum.BLUE_BORDER_COLLIE];
            var i:int;
            if (this.mainModel.myPlayerVO.is_member)
            {
                while (i < this.puffleIdCollection.length)
                {
                    this.setupMemberPuffleView(i);
                    i++;
                };
            }
            else
            {
                while (i < this.puffleIdCollection.length)
                {
                    this.setupNonMemberPuffleView(i);
                    i++;
                };
            };
        }

        private function setupMemberPuffleView(index:uint):void
        {
            var puffleView:PuffleView = new PuffleView((this.puffleIdCollection[index] as PufflePenViewEnum));
            var puffleViewHolder:MovieClip = MovieClip(this.view.getMemberPuffleHolder(index));
            puffleViewHolder.addChild(puffleView);
            this.puffleViewCollection.push(puffleView);
        }

        private function setupNonMemberPuffleView(index:uint):void
        {
            var puffleView:PuffleView = new PuffleView((this.puffleIdCollection[index] as PufflePenViewEnum));
            var puffleViewHolder:MovieClip = MovieClip(this.view.getPuffleHolder(index));
            puffleViewHolder.addChild(puffleView);
            this.puffleViewCollection.push(puffleView);
        }

        private function hideStatsBoard():void
        {
            this.statsClipBoard.puffleFacts.visible = false;
        }

        final private function doGarbageCollection(event:Event):void
        {
            this.adoptionSignalBus.chosenPuffleChanged.remove(this.onPuffleChosen);
            this.adoptionModel.puffleAdopted.remove(this.onPuffleAdopted);
            this.adoptionModel.notEnoughCoins.remove(this.onPuffleAdoptionNotEnoughCoins);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
