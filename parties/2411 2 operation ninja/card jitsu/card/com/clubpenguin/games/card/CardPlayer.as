//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.CardPlayer extends com.clubpenguin.games.card.AbstractPlayer
    {
        var __wins, __losses, __dealts, __pick, __dealtSlots, __get__seat, __get__nickname;
        function CardPlayer (seat, nickname, color, rank) {
            super(seat, nickname, color, rank);
            __wins = new Array();
            __losses = new Array();
            __dealts = new Array();
            __pick = null;
            __dealtSlots = new Array(5);
        }
        function get dealts() {
            return(__dealts);
        }
        function get pick() {
            return(__pick);
        }
        function set pick(pick) {
            __pick = pick;
            //return(this.pick);
        }
        function get wins() {
            return(__wins);
        }
        function get losses() {
            return(__losses);
        }
        function get dealtSlots() {
            return(__dealtSlots);
        }
        function receiveCard(cardStr) {
            __dealts.push(new com.clubpenguin.games.card.Card(cardStr));
        }
        function pickCard(id) {
            var _local_4;
            var _local_2 = 0;
            while (_local_2 < __dealts.length) {
                if (id == __dealts[_local_2].id) {
                    _local_4 = _local_2;
                    break;
                }
                _local_2++;
            }
            __pick = com.clubpenguin.games.card.Card(__dealts[_local_4]);
            __dealts.splice(_local_4, 1);
            _local_2 = 0;
            while (_local_2 < __dealtSlots.length) {
                if (__dealtSlots[_local_2].id == id) {
                    __dealtSlots[_local_2] = null;
                }
                _local_2++;
            }
            lockDealts(true);
            return(__pick);
        }
        function cardWin() {
            if (__pick == null) {
                this.log("ERROR - no picked card");
                return(undefined);
            }
            __wins.push(__pick);
            __pick = null;
        }
        function cardLose() {
            if (__pick == null) {
                this.log("ERROR - no picked card");
                return(undefined);
            }
            __losses.push(__pick);
            __pick.destroy();
            __pick = null;
        }
        function showWinCards(winseat, ids) {
            var _local_3 = 0;
            while (_local_3 < ids.length) {
                var _local_2 = 0;
                while (_local_2 < __wins.length) {
                    if (ids[_local_3] == __wins[_local_2].id) {
                        __wins[_local_2].tweenTo(com.clubpenguin.games.card.Layout.POS_WINS_OVER[winseat][_local_3].x, com.clubpenguin.games.card.Layout.POS_WINS_OVER[winseat][_local_3].y, 0.5);
                    }
                    _local_2++;
                }
                _local_3++;
            }
        }
        function findCardByIdFrom(id, pile) {
            var _local_1 = 0;
            while (_local_1 < pile.length) {
                if (pile[_local_1].id == id) {
                    return(pile[_local_1]);
                }
                _local_1++;
            }
            com.clubpenguin.util.Debug.log("CANNOT FIND Dealt Card: " + id, "ERROR");
        }
        function discardWinCard(id) {
            var _local_2 = 0;
            while (_local_2 < __wins.length) {
                if (id == wins[_local_2].id) {
                    __losses.push(wins[_local_2]);
                    __wins[_local_2].destroy();
                    __wins.splice(_local_2, 1);
                    return(undefined);
                }
                _local_2++;
            }
            com.clubpenguin.util.Debug.log("CANNOT FIND WIN CARD TO DESTROY: " + id, "ERROR");
        }
        function lockAtrCards(atr) {
            var _local_2 = 0;
            while (_local_2 < __dealts.length) {
                if (atr == __dealts[_local_2].atr) {
                    __dealts[_local_2].disable();
                }
                _local_2++;
            }
        }
        function lockDealts(lock) {
            var _local_2 = 0;
            while (_local_2 < __dealts.length) {
                __dealts[_local_2].lock = lock;
                _local_2++;
            }
        }
        function arrangeWinCards() {
            var _local_3 = new Object();
            _local_3.f = 0;
            _local_3.w = 0;
            _local_3.s = 0;
            var _local_2 = 0;
            while (_local_2 < __wins.length) {
                _local_3[__wins[_local_2].atr]++;
                __wins[_local_2].setState("thumbnail");
                __wins[_local_2].tweenTo(com.clubpenguin.games.card.Layout.POS_WINS[__get__seat()][__wins[_local_2].atr].x, com.clubpenguin.games.card.Layout.POS_WINS[__get__seat()][__wins[_local_2].atr].y + (com.clubpenguin.games.card.Layout.WIN_SPACER * _local_3[__wins[_local_2].atr]), 0.5);
                __wins[_local_2].mc.swapDepths(com.clubpenguin.games.card.Layout.DEPTH_WINS[__get__seat()] - _local_2);
                _local_2++;
            }
        }
        function log(msg) {
            com.clubpenguin.util.Debug.log(msg, __get__nickname());
        }
        function debugPlayer() {
            this.log("##########################DEBUG CardPlayer##########################");
            this.log("Dealt: " + __dealts);
            this.log("Dealt Slots: " + __dealtSlots);
            this.log("Picked: " + __pick);
            this.log("Win: " + __wins);
            this.log("Loss: " + __losses);
            this.log("###################################################################");
        }
        static var CLASS_PACKAGE = "com.clubpenguin.games.card";
        static var CLASS_NAME = "AbstractPlayer";
        var __classPackage = CLASS_PACKAGE;
        var __className = CLASS_NAME;
    }
