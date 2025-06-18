//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.BattleController
    {
        var _parent, _mc, _battle0_mc, _battle1_mc, _animFrameCounter, dispatchEvent;
        function BattleController (parent) {
            mx.events.EventDispatcher.initialize(this);
            trace("BATTLE CONTROLLER INITING");
            _parent = parent;
            _mc = _parent.battle_mc;
            loadBasicBattles();
        }
        function get mc() {
            return(_mc);
        }
        function animate(winseat, name, noTieSfx) {
            trace((("ninja Animation | winseat: " + winseat) + " | name: ") + name);
            if (_battle0_mc) {
                _battle0_mc.removeMovieClip();
            }
            if (_battle1_mc) {
                _battle1_mc.removeMovieClip();
            }
            var _local_4 = ((name.indexOf("pow") != -1) ? (POWER_ANIM[name]) : (BASIC_ANIM[name]));
            var _local_5 = ((name.indexOf("pow") != -1) ? "power" : (name));
            switch (_local_5) {
                case "walk" : 
                case "tie" : 
                case "ambient" : 
                    _battle0_mc = _mc[name].attachMovie(name, "battle0_mc", 1, {_x:com.clubpenguin.games.card.Layout.POS_CENTER.x, _y:com.clubpenguin.games.card.Layout.POS_CENTER.y});
                    _battle1_mc = _mc[name].attachMovie(name, "battle1_mc", 2, {_x:com.clubpenguin.games.card.Layout.POS_CENTER.x, _y:com.clubpenguin.games.card.Layout.POS_CENTER.y});
                    if ((name == "tie") && (!noTieSfx)) {
                        var _local_3 = new Sound(_battle0_mc);
                        _local_3.attachSound(name + "_sfx");
                        _local_3.start();
                    }
                    break;
                case "f" : 
                case "s" : 
                case "w" : 
                case "power" : 
                    if (winseat == 0) {
                        _battle0_mc = _mc[name + "_attack"].attachMovie("attack", "battle0_mc", 1, {_x:com.clubpenguin.games.card.Layout.POS_CENTER.x, _y:com.clubpenguin.games.card.Layout.POS_CENTER.y});
                        _battle1_mc = _mc[name + "_react"].attachMovie("react", "battle1_mc", 2, {_x:com.clubpenguin.games.card.Layout.POS_CENTER.x, _y:com.clubpenguin.games.card.Layout.POS_CENTER.y});
                    } else {
                        _battle0_mc = _mc[name + "_react"].attachMovie("react", "battle0_mc", 1, {_x:com.clubpenguin.games.card.Layout.POS_CENTER.x, _y:com.clubpenguin.games.card.Layout.POS_CENTER.y});
                        _battle1_mc = _mc[name + "_attack"].attachMovie("attack", "battle1_mc", 2, {_x:com.clubpenguin.games.card.Layout.POS_CENTER.x, _y:com.clubpenguin.games.card.Layout.POS_CENTER.y});
                    }
                    if (_local_4.attack_top) {
                        _mc[name + "_attack"].swapDepths(_mc.getNextHighestDepth());
                    } else {
                        _mc[name + "_react"].swapDepths(_mc.getNextHighestDepth());
                    }
                    break;
                default : 
                    com.clubpenguin.util.Debug.log("Error Ninja Animation: " + name, "ERROR");
            }
            _battle0_mc._xscale = -100;
            _battle1_mc._xscale = 100;
            _animFrameCounter = 1;
            _mc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onBattleEnterFrame, name, _local_4.frames);
            senseiClip(0, ((com.clubpenguin.games.card.GameEngine.instance.mode == com.clubpenguin.games.card.GameEngine.MODE_SEN) ? true : false));
            senseiClip(1, false);
        }
        function setColor(player) {
            var _local_2 = player.color;
            var _local_5 = new Color(this[("_battle" + player.seat) + "_mc"].body_mc);
            var _local_4 = new Color(this[("_battle" + player.seat) + "_mc"].frontArm_mc);
            var _local_6 = new Color(this[("_battle" + player.seat) + "_mc"].backArm_mc);
            _local_5.setRGB(_local_2);
            _local_4.setRGB(_local_2);
            _local_6.setRGB(_local_2);
        }
        function setBeltColor(player) {
            var _local_2 = player.rank;
            var _local_4 = BELT_COLOR[_local_2];
            if (_local_2 == 0) {
                this[("_battle" + player.seat) + "_mc"].belt_mc._visible = false;
                this[("_battle" + player.seat) + "_mc"].beltline_mc._visible = false;
                return(undefined);
            }
            var _local_5 = new Color(this[("_battle" + player.seat) + "_mc"].belt_mc);
            _local_5.setRGB(_local_4);
        }
        function senseiClip(seat, bSensei) {
            if (bSensei) {
                this[("_battle" + seat) + "_mc"].belt_mc._visible = false;
                this[("_battle" + seat) + "_mc"].beltline_mc._visible = false;
            } else {
                this[("_battle" + seat) + "_mc"].sensay_mc._visible = false;
                this[("_battle" + seat) + "_mc"].sensay2_mc._visible = false;
                this[("_battle" + seat) + "_mc"].sensay_mc2._visible = false;
            }
        }
        function loadPowerBattle(type) {
            var _local_2 = "pow_" + type;
            initLoader(_local_2 + "_attack");
            initLoader(_local_2 + "_react");
            POWER_ANIM[_local_2].loaded = true;
        }
        function loadBasicBattles() {
            for (var _local_2 in BASIC_ANIM) {
                if (BASIC_ANIM[_local_2].dual) {
                    initLoader(_local_2 + "_attack");
                    initLoader(_local_2 + "_react");
                } else {
                    initLoader(_local_2);
                }
            }
            for (var _local_2 in POWER_ANIM) {
                POWER_ANIM[_local_2].loaded = false;
            }
        }
        function initLoader(file) {
            var _local_4 = _mc.createEmptyMovieClip(file, _mc.getNextHighestDepth(), {_x:com.clubpenguin.games.card.Layout.POS_CENTER.x, _y:com.clubpenguin.games.card.Layout.POS_CENTER.y});
            var _local_3 = new MovieClipLoader();
            var _local_2 = new Object();
            _local_2.onLoadStart = com.clubpenguin.util.Delegate.create(this, onLoadStart);
            _local_2.onLoadInit = com.clubpenguin.util.Delegate.create(this, onLoadInit, _local_3, _local_2);
            _local_2.onLoadProgress = com.clubpenguin.util.Delegate.create(this, onLoadProgress);
            _local_2.onLoadError = com.clubpenguin.util.Delegate.create(this, onLoadError);
            _local_3.addListener(_local_2);
            _local_3.loadClip((BATTLE_FILE_PATH + file) + ".swf", _local_4);
        }
        function onLoadStart(target) {
        }
        function onLoadInit(target, loader, listener) {
            loader.removeListener(listener);
            if ((--_battlesToLoad) == 0) {
                dispatchEvent({target:this, type:FILE_LOADED});
            }
        }
        function onLoadProgress(target, progress, total) {
        }
        function onLoadError(target, error, httpStatus) {
            com.clubpenguin.util.Debug.log((((("Error Loading: " + target) + " | ") + error) + " | ") + httpStatus, "ERROR");
        }
        function onBattleEnterFrame(name, frames) {
            if (frames == undefined) {
                _mc.onEnterFrame = null;
                return(undefined);
            }
            if ((++_animFrameCounter) >= frames) {
                onBattleDone(name);
            }
        }
        function onBattleDone(name) {
            for (var _local_2 in _battle0_mc) {
                _battle0_mc[_local_2].stop();
            }
            for (var _local_2 in _battle1_mc) {
                _battle1_mc[_local_2].stop();
            }
            _mc.onEnterFrame = null;
            dispatchEvent({target:this, type:BATTLE_DONE, anim:name});
        }
        static var BATTLE_FILE_PATH = _global.getCurrentShell().getGameContentPath() + "/card/battles/";
        static var BASIC_ANIM = {ambient:{dual:false, frames:undefined, attack_top:true}, walk:{dual:false, frames:106, attack_top:true}, tie:{dual:false, frames:45, attack_top:true}, f:{dual:true, frames:118, attack_top:true}, s:{dual:true, frames:100, attack_top:true}, w:{dual:true, frames:91, attack_top:true}};
        static var POWER_ANIM = {pow_71:{dual:true, frames:105, attack_top:true}, pow_72:{dual:true, frames:204, attack_top:false}, pow_73:{dual:true, frames:190, attack_top:true}, pow_74:{dual:true, frames:194, attack_top:true}, pow_75:{dual:true, frames:256, attack_top:true}, pow_76:{dual:true, frames:186, attack_top:false}, pow_77:{dual:true, frames:166, attack_top:true}, pow_78:{dual:true, frames:142, attack_top:true}, pow_79:{dual:true, frames:264, attack_top:true}, pow_80:{dual:true, frames:175, attack_top:true}, pow_81:{dual:true, frames:165, attack_top:true}, pow_82:{dual:true, frames:240, attack_top:false}, pow_83:{dual:true, frames:148, attack_top:false}, pow_84:{dual:true, frames:175, attack_top:true}, pow_85:{dual:true, frames:250, attack_top:true}, pow_86:{dual:true, frames:178, attack_top:true}, pow_87:{dual:true, frames:231, attack_top:false}, pow_88:{dual:true, frames:222, attack_top:false}, pow_89:{dual:true, frames:139, attack_top:true}, pow_90:{dual:true, frames:176, attack_top:true}, pow_91:{dual:true, frames:295, attack_top:false}, pow_92:{dual:true, frames:183, attack_top:true}, pow_93:{dual:true, frames:225, attack_top:false}, pow_94:{dual:true, frames:292, attack_top:true}, pow_95:{dual:true, frames:355, attack_top:false}, pow_96:{dual:true, frames:166, attack_top:false}, pow_97:{dual:true, frames:223, attack_top:true}, pow_249:{dual:true, frames:200, attack_top:true}, pow_250:{dual:true, frames:295, attack_top:true}, pow_251:{dual:true, frames:205, attack_top:false}, pow_252:{dual:true, frames:172, attack_top:true}, pow_253:{dual:true, frames:261, attack_top:false}, pow_254:{dual:true, frames:173, attack_top:true}, pow_255:{dual:true, frames:296, attack_top:true}, pow_256:{dual:true, frames:189, attack_top:true}, pow_257:{dual:true, frames:233, attack_top:true}, pow_258:{dual:true, frames:215, attack_top:false}, pow_259:{dual:true, frames:125, attack_top:true}, pow_260:{dual:true, frames:225, attack_top:true}, pow_349:{dual:true, frames:145, attack_top:false}, pow_350:{dual:true, frames:225, attack_top:true}, pow_351:{dual:true, frames:294, attack_top:false}, pow_352:{dual:true, frames:196, attack_top:false}, pow_353:{dual:true, frames:139, attack_top:true}, pow_354:{dual:true, frames:222, attack_top:false}, pow_355:{dual:true, frames:183, attack_top:true}, pow_356:{dual:true, frames:245, attack_top:false}, pow_357:{dual:true, frames:190, attack_top:true}, pow_358:{dual:true, frames:135, attack_top:false}, pow_359:{dual:true, frames:413, attack_top:true}, pow_360:{dual:true, frames:230, attack_top:true}, pow_427:{dual:true, frames:306, attack_top:false}, pow_572:{dual:true, frames:169, attack_top:true}, pow_573:{dual:true, frames:280, attack_top:false}, pow_574:{dual:true, frames:179, attack_top:false}, pow_575:{dual:true, frames:268, attack_top:true}, pow_576:{dual:true, frames:171, attack_top:true}, pow_577:{dual:true, frames:218, attack_top:true}, pow_578:{dual:true, frames:221, attack_top:true}, pow_579:{dual:true, frames:198, attack_top:true}, pow_580:{dual:true, frames:195, attack_top:true}, pow_581:{dual:true, frames:218, attack_top:true}, pow_582:{dual:true, frames:275, attack_top:false}, pow_583:{dual:true, frames:181, attack_top:true}, pow_584:{dual:true, frames:248, attack_top:false}, pow_585:{dual:true, frames:235, attack_top:false}, pow_586:{dual:true, frames:208, attack_top:true}, pow_587:{dual:true, frames:230, attack_top:true}, pow_588:{dual:true, frames:249, attack_top:true}, pow_589:{dual:true, frames:205, attack_top:true}, pow_590:{dual:true, frames:276, attack_top:true}, pow_591:{dual:true, frames:180, attack_top:false}, pow_592:{dual:true, frames:315, attack_top:true}, pow_593:{dual:true, frames:170, attack_top:true}, pow_594:{dual:true, frames:256, attack_top:true}, pow_595:{dual:true, frames:260, attack_top:true}, pow_724:{dual:true, frames:240, attack_top:false}, pow_725:{dual:true, frames:306, attack_top:false}, pow_726:{dual:true, frames:274, attack_top:false}, pow_727:{dual:true, frames:240, attack_top:false}, pow_728:{dual:true, frames:225, attack_top:true}, pow_729:{dual:true, frames:235, attack_top:false}, pow_730:{dual:true, frames:176, attack_top:true}, pow_731:{dual:true, frames:283, attack_top:true}, pow_732:{dual:true, frames:205, attack_top:true}, pow_733:{dual:true, frames:218, attack_top:true}, pow_734:{dual:true, frames:306, attack_top:false}, pow_735:{dual:true, frames:380, attack_top:false}, pow_736:{dual:true, frames:166, attack_top:false}, pow_737:{dual:true, frames:290, attack_top:true}, pow_738:{dual:true, frames:380, attack_top:false}, pow_739:{dual:true, frames:204, attack_top:true}, pow_740:{dual:true, frames:225, attack_top:false}, pow_741:{dual:true, frames:296, attack_top:true}, pow_742:{dual:true, frames:296, attack_top:true}, pow_743:{dual:true, frames:258, attack_top:false}, pow_744:{dual:true, frames:258, attack_top:true}, pow_745:{dual:true, frames:283, attack_top:true}, pow_746:{dual:true, frames:320, attack_top:true}, pow_747:{dual:true, frames:294, attack_top:true}, pow_748:{dual:true, frames:355, attack_top:false}, pow_749:{dual:true, frames:166, attack_top:false}, pow_750:{dual:true, frames:223, attack_top:true}, pow_804:{dual:true, frames:339, attack_top:false}};
        static var BELT_COLOR = [null, 16777215, 16776960, 16737792, 3394560, 13260, 13369344, 6684927, 6697728, 4473924, 4473924];
        static var FILE_LOADED = "onFileLoaded";
        static var BATTLE_DONE = "onBattleDone";
        var _battlesToLoad = 9;
    }
