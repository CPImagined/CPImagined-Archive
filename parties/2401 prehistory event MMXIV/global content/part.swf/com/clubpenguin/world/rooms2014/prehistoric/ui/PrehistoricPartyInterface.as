
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.ui.PrehistoricPartyInterface
    {
        var _view, _INTERFACE, _SHELL, _ENGINE, dinosaurs, dinosaurTransformsMapping;
        function PrehistoricPartyInterface (_arg_3) {
            _view = _arg_3;
            _INTERFACE = _global.getCurrentInterface();
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
        }
        function init() {
            dinosaurs = [com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.TREX, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.TRICERATOPS, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.PTERANODON, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.STEGOSAURUS, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.RAPTORS];
            dinosaurTransformsMapping = {trex_pink:0, trex_red:1, trex_turquoise:2, trex_yellow:3, tri_brown:4, tri_purple:5, tri_turquoise:6, tri_yellow:7, pt_blue:8, pt_green:9, pt_orange:10, pt_pink:11, st_blue:12, st_green:13, st_purple:14, st_yellow:15, ra_black:16, ra_green:17, ra_pink:18, ra_red:19};
            configureDinoDetails();
            configureHelpInfo();
            configureTransformationEggs();
            configurePuffleEggs();
            _view.closeBtn.onRelease = com.clubpenguin.util.Delegate.create(this, closeUI);
            _view.testingMc.unlockAll_btn.onRelease = com.clubpenguin.util.Delegate.create(this, unlockAll);
            _view.testingMc.hatch_btn.onRelease = com.clubpenguin.util.Delegate.create(this, hatchEggs);
        }
        function configureHelpInfo() {
            _view.help_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showHelpInfo);
        }
        function showHelpInfo() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("showHelpInfo():_view.dinoInfo_mc:" + _view.dinoInfo_mc);
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.playSound(_view, SFX_SELECT);
            _view.dinoInfo_mc.gotoAndStop(2);
            _view.dinoInfo_mc.infobg.useHandCursor = false;
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("showHelpInfo():_view.dinoInfo_mc.close_btn:" + _view.dinoInfo_mc.close_btn);
            _view.dinoInfo_mc.close_btn.onPress = com.clubpenguin.util.Delegate.create(this, hideHelpInfo);
        }
        function hideHelpInfo() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("hideHelpInfo()" + _view);
            _view.dinoInfo_mc.gotoAndStop(1);
        }
        function configureDinoDetails() {
            _view.dinoDetails_mc.gotoAndStop(1);
        }
        function configureTransformationEggs() {
            setDefaultTransformEggState();
            var _local_2 = 0;
            while (_local_2 < dinosaurs.length) {
                if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hasPlayerCollectedAllTransforms(dinosaurs[_local_2]) || (testingActive)) {
                    var _local_3 = _view["reward_" + String(dinosaurs[_local_2])];
                    _local_3.nextFrame();
                    com.clubpenguin.party.BaseParty.configurePurchaseableItem(_local_3, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS[dinosaurs[_local_2].toUpperCase() + "_REWARD_ITEM"], com.clubpenguin.party.BaseParty.PAPER_ITEM_TAG, false, false);
                }
                _local_2++;
            }
            if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.transformationAllowed(416)) {
                _view.ra_badge._visible = false;
            }
            if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.transformationAllowed(400)) {
                _view.tri_badge._visible = false;
                _view.trex_badge._visible = false;
                _view.pt_badge._visible = false;
                _view.st_badge._visible = false;
                _view.ra_badge._visible = false;
            }
        }
        function setDefaultTransformEggState() {
            var _local_5 = com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.__get__partyCookie().__get__trans();
            for (var _local_6 in _view.transformEggs_mc) {
                var _local_2 = _view.transformEggs_mc[_local_6];
                if (_local_2._name != null) {
                    var _local_3 = _local_2._name;
                    var _local_4 = Number(dinosaurTransformsMapping[_local_6]);
                    if ((_local_5[_local_4] == 1) || (testingActive)) {
                        _local_2.gotoAndStop("show");
                        _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, onTransformationEggSelected, _local_2, _local_3);
                    }
                }
            }
        }
        function onTransformationEggSelected(_arg_4, _arg_3) {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.playSound(_view, SFX_SELECT);
            setDefaultTransformEggState();
            _arg_4.gotoAndStop("choose");
            _view.dinoDetails_mc.gotoAndStop(_arg_3);
            var _local_2 = Number(dinosaurTransformsMapping[_arg_3] + com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.PARTYCOOKIE_TO_AVATAR_ID_OFFSET);
            if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.transformationAllowed(_local_2) && (!_SHELL.isMyPlayerMember())) {
                _view.dinoDetails_mc.nonmember_transform_btn._visible = true;
                _view.dinoDetails_mc.transform_btn._visible = false;
                _view.dinoDetails_mc.nonmember_transform_btn.onRelease = com.clubpenguin.util.Delegate.create(this, sendDinoTransformation, _local_2);
            } else {
                _view.dinoDetails_mc.transform_btn._visible = true;
                _view.dinoDetails_mc.nonmember_transform_btn._visible = false;
                _view.dinoDetails_mc.transform_btn.onRelease = com.clubpenguin.util.Delegate.create(this, sendDinoTransformation, _local_2);
            }
        }
        function sendDinoTransformation(_arg_3) {
            var _local_2 = new Sound(_ENGINE.getRoomMovieClip()[com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME]);
            _local_2.attachSound(SFX_DINO_TRANSFORM);
            _local_2.start(0, 1);
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.sendDinosaurTransformation(_arg_3);
            _INTERFACE.closeContent();
        }
        function configurePuffleEggs() {
            var _local_2 = 1;
            while (_local_2 <= NUM_DINO_PUFFLES) {
                var _local_3 = Number(_local_2 - 1);
                if ((com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.PARTY_DAY >= (_local_3 * 2)) || (testingActive)) {
                    var _local_5 = com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.specificDinoPuffleObject(_local_3);
                    var _local_4 = _local_5[com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.DINO_PUFFLE_STATE_KEY];
                    _view[("dinopuffle_" + _local_2) + "_mc"].gotoAndStop("uncollected");
                    if (((_local_4 >= 1) && (_local_4 <= 3)) || (testingActive)) {
                        _view[("dinopuffle_" + _local_2) + "_mc"].gotoAndStop("collected");
                        _view[("dinopuffle_" + _local_2) + "_mc"].equip_btn.onRelease = com.clubpenguin.util.Delegate.create(this, sendEquipPuffleEgg, _local_3);
                        unlockDinoPuffleReward(_view[("dinopuffle_" + _local_2) + "_mc"].item_mc, _local_3);
                    }
                    if ((_local_4 == 4) || (eggsHatched)) {
                        _view[("dinopuffle_" + _local_2) + "_mc"].gotoAndStop("hatched");
                        _view[("dinopuffle_" + _local_2) + "_mc"].walk_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.sendWalkDinoPuffle, _local_3);
                        unlockDinoPuffleReward(_view[("dinopuffle_" + _local_2) + "_mc"].item_mc, _local_3);
                    }
                }
                _local_2++;
            }
        }
        function unlockDinoPuffleReward(_arg_1, _arg_2) {
            _arg_1.nextFrame();
            com.clubpenguin.party.BaseParty.configurePurchaseableItem(_arg_1, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.PUFFLE_REWARDS_IDS[_arg_2], com.clubpenguin.party.BaseParty.PAPER_ITEM_TAG, false, false);
        }
        function sendEquipPuffleEgg(_arg_2) {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.playSound(_view, SFX_EQUIP_COLLECT);
            setTimeout(com.clubpenguin.util.Delegate.create(this, sendEquipPuffleEggTimeout, _arg_2), 500);
        }
        function sendEquipPuffleEggTimeout(_arg_2) {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("sendEquipPuffleEggTimeout:puffleIndex=" + _arg_2);
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.playSound(_view, SFX_EQUIP_COLLECT);
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.sendEquipPuffleEgg(_arg_2);
            _INTERFACE.closeContent();
        }
        function closeUI() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.playSound(_view, SFX_CLOSE);
            setTimeout(com.clubpenguin.util.Delegate.create(this, closeInterface), 200);
        }
        function closeInterface() {
            _SHELL.startRoomMusic();
            _INTERFACE.closeContent();
        }
        function unlockAll() {
            if (testingActive) {
                return(undefined);
            }
            testingActive = true;
            init();
        }
        function hatchEggs() {
            if (eggsHatched) {
                return(undefined);
            }
            eggsHatched = true;
            init();
        }
        static var NUM_DINO_TRANSFORMS = 20;
        static var NUM_DINO_PUFFLES = 6;
        static var SFX_SELECT = "sfx_select";
        static var SFX_CLOSE = "sfx_close";
        static var SFX_ITEM_PURCHASE = "sfx_item_purchase";
        static var SFX_DINO_TRANSFORM = "sfx_dino_transform";
        static var SFX_EQUIP_COLLECT = "sfx_equip_collect";
        var testingActive = false;
        var eggsHatched = false;
    }
