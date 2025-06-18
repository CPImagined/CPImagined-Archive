//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.GadgetsMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
    {
        var _gadgetsView, _player, INTERFACE, context, _delayedUseTrekkerBtn, _canUseTrekkerBtn, epfService, _trekkerIsOn, TREKKER_AVATAR_ID, _canUseTraceTrackerBtn, _trackerTrackerIsOn, _delayedUseTraceTrackerBtn, _calibrationAnimation, _missionState, _hasUsedFur, _hasUsedHotsauce, _hasFur, _hasHotsauce;
        function GadgetsMediator (view, context) {
            super(view, context.appClosed, context.languageCode);
			TREKKER_AVATAR_ID = 2000;
            _gadgetsView = view;
            _gadgetsView.opened.add(onGadgetsViewOpened, this);
            _player = context.player;
            INTERFACE = context.INTERFACE;
            this.context = context;
            epfService = context.epfService;
            context.SHELL.addListener(context.SHELL.PLAYER_AVATAR_TRANSFORMED, onPlayerAvatarTransform, this);
            epfService.missionStateUpdated.add(updateView, this);
            epfService.epfHotSauceEvidenceSubmitted.add(updateView, this);
            epfService.inventoryDropped.add(onItemDropped, this);
            epfService.inventoryAdded.add(updateView, this);
            initView(view);
        }
        function initView(view) {
            _canUseTraceTrackerBtn = true;
			_canUseTrekkerBtn = true;
            updateView();
            _gadgetsView.onOffSlider.onRelease = com.clubpenguin.util.Delegate.create(this, onOnOffSliderClick);
			_gadgetsView.onOffSliderTrekker.onRelease = com.clubpenguin.util.Delegate.create(this, onOnOffSliderClickTrekker);
        }
        function onOnOffSliderClickTrekker() {
            if (!_player.is_member) {
                INTERFACE.showWindow("oops_epf_tracetracker3000", null, "oops_epf_tracetracker3000");
                return(undefined);
            }
            if (_canUseTrekkerBtn) {
                _trekkerIsOn = getTrekkerState();
                if (_trekkerIsOn) {
                    _global.getCurrentEngine().avatarManager.transformationManager.sendTransformPlayer(0);
					_gadgetsView.stateOffTrekker._visible = true;
                	_gadgetsView.onOffSliderTrekker._visible = true;
                	_gadgetsView.onOffSliderTrekker.gotoAndPlay("off");
                } else {
					_global.getCurrentEngine().avatarManager.transformationManager.sendTransformPlayer(TREKKER_AVATAR_ID);
					_gadgetsView.stateOnTrekker._visible = true;
                	_gadgetsView.onOffSliderTrekker._visible = true;
                	_gadgetsView.onOffSliderTrekker.gotoAndPlay("on");
                }
				_canUseTrekkerBtn = false;
				clearInterval(_delayedUseTrekkerBtn);
                _delayedUseTrekkerBtn = setInterval(this, "delayedUseTrekkerBtn", com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.DELAYED_USE_TRACE_TRACKER_TIME);
            }
        }
		function getTrekkerState() {
			var _local_2 = _global.getCurrentShell();
            var _local_3 = _local_2.getPlayerObjectById(_local_2.getMyPlayerId());
            return(_local_3.avatar_id == TREKKER_AVATAR_ID);
		}
		function onOnOffSliderClick() {
            if (!_player.is_member) {
                INTERFACE.showWindow("oops_epf_tracetracker3000", null, "oops_epf_tracetracker3000");
                return(undefined);
            }
            if (_canUseTraceTrackerBtn) {
                _trackerTrackerIsOn = epfService.getTrackerState();
                if (_trackerTrackerIsOn) {
                    epfService.deactivateTraceTracker();
                } else {
                    epfService.activateTraceTracker();
                }
                _canUseTraceTrackerBtn = false;
                clearInterval(_delayedUseTraceTrackerBtn);
                _delayedUseTraceTrackerBtn = setInterval(this, "delayedUseTraceTrackerBtn", com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.DELAYED_USE_TRACE_TRACKER_TIME);
            }
        }
        function delayedUseTraceTrackerBtn() {
            clearInterval(_delayedUseTraceTrackerBtn);
            _canUseTraceTrackerBtn = true;
        }
		function delayedUseTrekkerBtn() {
            clearInterval(_delayedUseTrekkerBtn);
            _canUseTrekkerBtn = true;
        }
        function onItemDropped(inventoryItemDropped, dropPoint) {
            if (!_gadgetsView.stateAddEvidence._visible) {
                return(undefined);
            }
            var _local_3 = _gadgetsView.evidenceSpout;
            if ((_local_3 != undefined) && (_local_3 != null)) {
                if (_local_3.hitTest(dropPoint.x, dropPoint.y, true)) {
                    if ((com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_FUR.isUsed && (inventoryItemDropped.equals(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_HOT_SAUCE))) || (com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_HOT_SAUCE.isUsed && (inventoryItemDropped.equals(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_FUR)))) {
                        _gadgetsView.stateAddEvidence._visible = false;
                        _gadgetsView.stateCalibrating._visible = true;
                        _gadgetsView.stateCalibrating.calibrateAnimation.gotoAndPlay(2);
                        _gadgetsView.stateCalibrating.calibrateAnimationTitle.gotoAndPlay(2);
                        _gadgetsView.evidenceSpout.gotoAndPlay("close");
                        clearInterval(_calibrationAnimation);
                        epfService.missionStateUpdated.remove(updateView, this);
                        epfService.epfHotSauceEvidenceSubmitted.remove(updateView, this);
                        epfService.inventoryDropped.remove(onItemDropped, this);
                        epfService.inventoryAdded.remove(updateView, this);
                        com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.useQuestItem(inventoryItemDropped);
                        _calibrationAnimation = setInterval(this, "onCalibrationAnimationComplete", 3600);
                        return(undefined);
                    }
                    if (inventoryItemDropped.equals(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_FUR)) {
                        com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.useQuestItem(inventoryItemDropped);
                    } else if (inventoryItemDropped.equals(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_HOT_SAUCE)) {
                        com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.useQuestItem(inventoryItemDropped);
                    }
                }
            }
        }
        function onCalibrationAnimationComplete() {
            clearInterval(_calibrationAnimation);
            epfService.missionStateUpdated.add(updateView, this);
            epfService.epfHotSauceEvidenceSubmitted.add(updateView, this);
            epfService.inventoryDropped.add(onItemDropped, this);
            epfService.inventoryAdded.add(updateView, this);
            epfService.activateTraceTracker();
        }
        function onGadgetsViewOpened() {
            clearInterval(_calibrationAnimation);
            if (_gadgetsView.evidenceSpout._visible) {
                _gadgetsView.evidenceSpout.gotoAndPlay("open");
            }
        }
        function onPlayerAvatarTransform(event) {
            if (event.player.player_id == context.SHELL.getMyPlayerId()) {
                updateView();
            }
        }
        function updateView() {
            clearInterval(_calibrationAnimation);
            _gadgetsView.hideAllViews();
            _trackerTrackerIsOn = epfService.getTrackerState();
			_trekkerIsOn = getTrekkerState();
            _missionState = epfService.getMissionState();
            _hasUsedFur = epfService.hasUsedFur();
            _hasUsedHotsauce = epfService.hasUsedHotSauce();
            _hasFur = epfService.hasCollectedFur();
            _hasHotsauce = epfService.hasCollectedHotSauce();
            if ((_missionState == epfService.QUEST_STATE_MISSION_ACCEPTED) && (_player.is_member)) {
                if (_hasUsedFur && (_hasUsedHotsauce)) {
                    updateTraceTrackerState();
                } else {
                    _gadgetsView.onOffSlider._visible = false;
                    _gadgetsView.stateAddEvidence._visible = true;
                    _gadgetsView.evidenceSpout._visible = true;
                    if (_hasUsedFur) {
                        _gadgetsView.stateAddEvidence.furSlot.gotoAndStop("slotFull");
                    } else if (_hasFur) {
                        _gadgetsView.stateAddEvidence.furSlot.gotoAndStop("slotFurAnimation");
                    }
                    if (_hasUsedHotsauce) {
                        _gadgetsView.stateAddEvidence.hotSauceSlot.gotoAndStop("slotFull");
                    } else if (_hasHotsauce) {
                        _gadgetsView.stateAddEvidence.hotSauceSlot.gotoAndStop("slotSauceAnimation");
                    }
                }
            } else {
                updateTraceTrackerState();
            }
        }
        function updateTraceTrackerState() {
            if (!_player.is_member) {
                _gadgetsView.stateOff._visible = true;
                _gadgetsView.onOffSlider._visible = true;
                return(undefined);
            }
			if (!_trackerTrackerIsOn) {
				_gadgetsView.stateOff._visible = true;
                _gadgetsView.onOffSlider._visible = true;
				if (_gadgetsView.onOffSlider._currentframe != 1) {
                	_gadgetsView.onOffSlider.gotoAndPlay("off");
				};
			} else {
				_gadgetsView.stateOn._visible = true;
                _gadgetsView.onOffSlider._visible = true;
				if (_gadgetsView.onOffSlider._currentframe != 5) {
                	_gadgetsView.onOffSlider.gotoAndPlay("on");
				};
			}
			if (!_trekkerIsOn) {
				_gadgetsView.stateOffTrekker._visible = true;
                _gadgetsView.onOffSliderTrekker._visible = true;
				if (_gadgetsView.onOffSliderTrekker._currentframe != 1) {
                	_gadgetsView.onOffSliderTrekker.gotoAndPlay("off");
				};
			} else {
				_gadgetsView.stateOnTrekker._visible = true;
                _gadgetsView.onOffSliderTrekker._visible = true;
				if (_gadgetsView.onOffSliderTrekker._currentframe != 5) {
                	_gadgetsView.onOffSliderTrekker.gotoAndPlay("on");
				};
			}
        }
    }
