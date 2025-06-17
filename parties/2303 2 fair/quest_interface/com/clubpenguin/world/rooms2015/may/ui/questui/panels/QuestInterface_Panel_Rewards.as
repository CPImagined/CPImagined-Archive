//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel_Rewards
    {
        static var _shell;
        var _view;
        function QuestInterface_Panel_Rewards (skin) {
            trace("QuestInterface_Panel_Rewards()");
            _view = skin;
            _shell = _global.getCurrentShell();
            configureFairTickets();
            configureSilverTicket();
            configureTransformations();
        }
        function configureFairTickets() {
            _view.fair_tickets_mc.numTickets.text = String(com.clubpenguin.world.rooms2015.may.party.MayParty.tickets);
        }
        function configureSilverTicket() {
            if (_shell.isMyPlayerMember()) {
                _view.silverTicket_mc.gotoAndStop("member");
                return(undefined);
            }
            if (com.clubpenguin.world.rooms2015.may.party.MayParty.numSilverTickets > 0) {
                _view.silverTicket_mc.gotoAndStop("yes_ticket");
                var _local_2 = "";
                if (com.clubpenguin.world.rooms2015.may.party.MayParty.numSilverTickets == 1) {
                    _local_2 = getSilverTicketString_singular();
                } else {
                    _local_2 = getSilverTicketString_plural();
                }
                _view.silverTicket_mc.silver_ticket_amount.text = _local_2;
            } else {
                _view.silverTicket_mc.gotoAndStop("no_ticket");
            }
        }
        function getSilverTicketString_singular() {
            var _local_2 = _shell.getLanguageAbbreviation();
            var _local_1;
            switch (_local_2) {
                case "de" : 
                    _local_1 = "1 Ticket!";
                    break;
                case "en" : 
                    _local_1 = "1 Ticket!";
                    break;
                case "fr" : 
                    _local_1 = "1 ticket !";
                    break;
                case "pt" : 
                    _local_1 = "1 tíquete!";
                    break;
                case "es" : 
                    _local_1 = "¡1 billete!";
                    break;
                case "ru" : 
                    _local_1 = "1 билет!";
                    break;
                default : 
                    _local_1 = "1 Ticket!";
                    break;
            }
            return(_local_1);
        }
        function getSilverTicketString_plural() {
            var _local_3 = _shell.getLanguageAbbreviation();
            var _local_1 = String(com.clubpenguin.world.rooms2015.may.party.MayParty.numSilverTickets);
            var _local_2;
            switch (_local_3) {
                case "de" : 
                    _local_2 = _local_1 + " Tickets!";
                    break;
                case "en" : 
                    _local_2 = _local_1 + " Tickets!";
                    break;
                case "fr" : 
                    _local_2 = _local_1 + " tickets !";
                    break;
                case "pt" : 
                    _local_2 = _local_1 + " tíquetes!";
                    break;
                case "es" : 
                    _local_2 = ("¡" + _local_1) + " billetes!";
                    break;
                case "ru" : 
                    _local_2 = _local_1 + " билетов!";
                    break;
                default : 
                    _local_2 = _local_1 + " Tickets!";
                    break;
            }
            return(_local_2);
        }
        function configureTransformations() {
            trace("QuestInterface_Panel_Rewards.configureTransformations()");
            _view.transform_01.claim_btn.onPress = com.clubpenguin.util.Delegate.create(this, requestTransformation, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.TRANSFORMATION_ID_COYOTE);
            _view.transform_02.claim_btn.onPress = com.clubpenguin.util.Delegate.create(this, requestTransformation, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.TRANSFORMATION_ID_CRAB);
            _view.transform_03.claim_btn.onPress = com.clubpenguin.util.Delegate.create(this, requestTransformation, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.TRANSFORMATION_ID_DRAGON);
            _view.transform_04.claim_btn.onPress = com.clubpenguin.util.Delegate.create(this, requestTransformation, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.TRANSFORMATION_ID_ROBO);
        }
        function requestTransformation(id) {
            trace("QuestInterface_Panel_Rewards.requestTransformation() - id : " + id);
            if (_shell.isMyPlayerMember()) {
                trace("PLAYER TRANSFORM");
                com.clubpenguin.world.rooms2015.may.party.MayParty.sendTransformation(id);
            } else {
                trace("SHOW OOPS");
                com.clubpenguin.world.rooms2015.may.party.MayParty.showMemberContentOopsMessage();
            }
        }
        function clean() {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("CLEAN UP THE QUEST UI REWARDS PANEL");
        }
    }
