//Created by Action Script Viewer - https://www.buraks.com/asv
package com.playdom.tracker
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.model.IMetricsModel;
    import com.playdom.util.NameValuesContainer;
    import flash.utils.Dictionary;
    import com.playdom.baseactors.BasePlayerStats;
    import flash.display.Stage;
    import flash.events.Event;
    import com.playdom.baseactors.BaseMoney;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.system.Capabilities;
    import com.clubpenguin.lib.enums.metrics.MetricsConstant;
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;

    use namespace OnlyTracker;

    public class Tracker extends Actor 
    {

        public static const DEFAULT_URL_STRING:String = "http://log.data.disney.com/flash_log?";
        public static const PRELOADING_BLOCK:String = "page_load";
        public static const DATA_LOADING_BLOCK:String = "dataLoading";
        public static const ASSET_LOADING_BLOCK:String = "assetLoading";
        public static const SOCIAL_PLATFORM_CALL_BLOCK_X:String = "socialPlatformCall_";
        public static const PASS:String = "pass";
        public static const FAIL:String = "fail";
        public static const POPUP_STEP_SHOW:String = "show";
        public static const POPUP_STEP_CONTINUE:String = "continue";
        public static const POPUP_STEP_CANCEL:String = "cancel";
        public static const START_STEP:String = "start";
        public static const END_STEP:String = "end";
        public static const ERROR:uint = 0;
        public static const GAME_ACTION:uint = 1;
        public static const PAGEVIEW:uint = 2;
        public static const POPUP:uint = 3;
        public static const LEVEL_UP:uint = 4;
        public static const MONEY:uint = 5;
        public static const STEP_TIMING:uint = 6;
        public static const USER_STAT_CHANGE:uint = 7;
        public static const SEND_MONEY:uint = 8;
        public static const SEND_SOCIAL_ACTION:uint = 9;
        public static const PERFORMANCE:uint = 10;
        public static const SYSTEM:uint = 11;
        public static const TEST_IMPRESSION:uint = 12;
        public static const USER_INFO:uint = 13;
        public static const GEO:uint = 14;
        public static const MAP_SWID:uint = 15;
        protected static const tagStrings:Array = ["error", "game_action", "pageview", "popup", "level_up", "money", "step_timing", "user_stat_change", "send_money", "send_social_action", "performance", "system", "test_impression", "user_info", "geo", "network_mapping_info"];
        protected static const BASE_PLAYER_PATH:String = "com.playdom.baseactors::BasePlayerStats";
        protected static const USER_ID_ATTRIBUTE:String = "user_id";
        protected static const PLAYER_ID_ATTRIBUTE:String = "player_id";
        protected static const BALANCE_ATTRIBUTE:String = "balance";
        protected static const NETWORK_ATTRIBUTE:String = "network";
        protected static const VIEW_NETWORK_ATTRIBUTE:String = "view_network";
        protected static const REASON_ATTRIBUTE:String = "reason";
        protected static const MESSAGE_ATTRIBUTE:String = "message";
        protected static const CONTEXT_ATTRIBUTE:String = "context";
        protected static const EXPERIENCE_ATTRIBUTE:String = "exp";
        protected static const LEVEL_ATTRIBUTE:String = "level";
        protected static const CURRENCY_ATTRIBUTE:String = "currency";
        protected static const SUBTYPE:String = "subtype";
        protected static const CITY_ATTRIBUTE:String = "city";
        protected static const STATE_ATTRIBUTE:String = "state";
        protected static const COUNTRY_ATTRIBUTE:String = "country";
        protected static const ZIP_ATTRIBUTE:String = "zip";
        protected static const AMOUNT_ATTRIBUTE:String = "amount";
        protected static const ACTION_ATTRIBUTE:String = "action";
        protected static const ITEM_NAME_ATTRIBUTE:String = "item_name";
        protected static const LOCATION_ATTRIBUTE:String = "location";
        protected static const TRACKING_CODE_ATTRIBUTE:String = "tracking_code";
        protected static const STEP_ATTRIBUTE:String = "step";
        protected static const TYPE_ATTRIBUTE:String = "type";
        protected static const SUBTYPE_ATTRIBUTE:String = "subtype";
        protected static const STAT_NAME_ATTRIBUTE:String = "stat_name";
        protected static const ELAPSED_TIME_ATTRIBUTE:String = "elapsed_time";
        protected static const ELAPSED_TIME_MS_ATTRIBUTE:String = "elapsed_time_ms";
        protected static const RESULT_ATTRIBUTE:String = "result";
        protected static const BALANCE__ATTRIBUTE:String = "balance_";
        protected static const TAG_ATTRIBUTE:String = "tag";
        protected static const APP_ATTRIBUTE:String = "app";
        protected static const PATH_NAME_ATTRIBUTE:String = "path_name";
        protected static const MEMORY_ATTRIBUTE:String = "memory_used";
        protected static const NETWORK_SPEED_ATTRIBUTE:String = "network_speed";
        protected static const LOADED_BYTES_ATTRIBUTE:String = "loaded_bytes";
        protected static const LOADING_TIME_ATTRIBUTE:String = "loading_time";
        protected static const ENGAGED:String = "engaged";
        protected static const TIME_SINCE_START:String = "time_since_start";
        protected static const LANG_ATTRIBUTE:String = "lang";
        protected static const DISPLAY_STATE_ATTRIBUTE:String = "display_state";
        protected static const TRANSACTION_ID_ATTRIBUTE:String = "transaction_id";
        protected static const BROWSER_ID_ATTRIBUTE:String = "browser_id";
        protected static const IS_MEMBER_ATTRIBUTE:String = "is_member";
        protected static const WORLD_ID:String = "world_id";
        protected static const BEFORE_WORLD_ID:String = "-1";
        protected static const FPS_ATTRIBUTE:String = "fps";
        protected static const MIN_FPS_ATTRBIUTE:String = "min_fps";
        protected static const ROOM_ATTRIBUTE:String = "room";
        protected static const PLAYER_COUNT_ATTRIBUTE:String = "player_count";
        protected static const COUNT_BRIDGE_CALLS_ATTRIBUTE:String = "bridge_count";
        protected static const COUNT_FRIENDS_EI_ATTRBIUTE:String = "friends_ei_count";
        protected static const AVG_BRIDGE_LAG_ATTRIBUTE:String = "avg_bridge_lag";
        protected static const MAX_BRIDGE_LAG_ATTRIBUTE:String = "max_bridge_lag";
        protected static const POLL_INTERVAL_ATTRIBUTE:String = "poll_interval";
        protected static const APP_LOCALE:String = "app_locale";
        protected static const NETWORK_MAPPING_INFO:String = "network_mapping_info";
        protected static const SECONDARY_USER_ID:String = "secondary_user_id";
        protected static const SECONDARY_NETWORK:String = "secondary_network";
        protected static const SYSTEM_MANUFACTURER_ATTRIBUTE:String = "manufacturer";
        protected static const SYSTEM_OS_ATTRIBUTE:String = "os";
        protected static const SYSTEM_PLAYER_TYPE_ATTRIBUTE:String = "player_type";
        protected static const SYSTEM_FP_VERSION_ATTRIBUTE:String = "fp_version";
        protected static const SYSTEM_APP_VERSION_ATTRIBUTE:String = "app_version";
        protected static const MUST_INITIALIZE_ERROR:String = "You must initialize with the initialize function before using Tracker";
        protected static const MUST_INSTANSIATE_STATS_ERROR:String = "Tracker default playerStats, or passed in playerStats must be instansiated";
        protected static const KEY_DOESNT_EXIST_ERROR:String = "Key does not exists";
        protected static const ALREADY_RUNNING_ERROR:String = "Can not start performance monitor while it is already running.";
        protected static const ALREADY_TIMING_ERROR:String = "Timing as already started for ";
        protected static const PERFORMANCE_INTERVAL_SECONDS:uint = 120;
        protected static const LANG_EN_US:String = "en_US";
        private static const CJ_SNOW_ROOM_ID:int = 996;
        private static const TEST:String = "test";
        private static const VARIANT:String = "variant";
        private static const CONTROL:String = "control";

        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var metricsModel:IMetricsModel;
        protected var gameDataNVC:NameValuesContainer;
        protected var logManager:LogManager;
        protected var _startTimes:Dictionary = new Dictionary();
        protected var _initialized:Boolean = false;
        protected var _defaultPlayerStats:BasePlayerStats;
        protected var _performanceDelegate:PerformanceDelegate;
        protected var _networkSpeed:Number = NaN;
        protected var _gameStartTime:Number;
        protected var _totalLoadedTime:Number = 0;
        protected var _totalLoadedBytes:uint = 0;
        protected var appVersion:String = "";
        private var lastDisplayState:String;
        private var _sessionUuid:String;
        private var _browserID:String;
        private var _currentContext:String;
        private var _contextMap:Array = [];
        private var _networkID:String;
        private var _viewNetworkID:String;
        private var _initLang:String;
        protected var _stageRef:Stage;

        public function Tracker():void
        {
        }

        public function initialize(userID:String, appString:String, networkID:String="", appVersion:String="", sendStartInFlash:Boolean=false, flushOnInterval:Boolean=false, analyticsURL:String="http://log.data.disney.com/flash_log?", viewNetworkID:String="", language:String="en_US", sessionUuid:String="", browserID:String=""):void
        {
            this._initialized = true;
            this._sessionUuid = sessionUuid;
            this._browserID = browserID;
            this.logManager = new LogManager(analyticsURL, flushOnInterval);
            this.gameDataNVC = new NameValuesContainer();
            this.appVersion = appVersion;
            if (viewNetworkID == "")
            {
                viewNetworkID = networkID;
            };
            this._networkID = networkID;
            this._viewNetworkID = viewNetworkID;
            this.gameDataNVC.addPair(APP_ATTRIBUTE, appString);
            this.gameDataNVC.addPair(USER_ID_ATTRIBUTE, userID);
            this.gameDataNVC.addPair(NETWORK_ATTRIBUTE, networkID);
            this.gameDataNVC.addPair(VIEW_NETWORK_ATTRIBUTE, viewNetworkID);
            this.gameDataNVC.addPair(LANG_ATTRIBUTE, language);
            this.startPerformanceMonitor(PERFORMANCE_INTERVAL_SECONDS, 0);
            var now:Date = new Date();
            var ms:Number = now.getTime();
            this._gameStartTime = ms;
            if (sendStartInFlash)
            {
                this.trackStepTiming(PRELOADING_BLOCK, START_STEP);
            };
            this.startTiming(PRELOADING_BLOCK);
            this.trackSystem();
            this._initLang = language;
        }

        public function handleUserIdChange(_swid:String):void
        {
            this.gameDataNVC.setNewUniqueId(_swid);
        }

        public function enableDisplayStateCheck(stage:Stage):void
        {
            if (stage !== null)
            {
                this._stageRef = stage;
                this.lastDisplayState = this._stageRef.displayState;
                this._performanceDelegate.watchDisplayState(this._stageRef);
            };
        }

        public function set defaultPlayerStats(bps:BasePlayerStats):void
        {
            this._defaultPlayerStats = bps;
        }

        public function get defaultPlayerStats():BasePlayerStats
        {
            return (this._defaultPlayerStats);
        }

        public function get analyticsURL():String
        {
            return (this.logManager.url);
        }

        public function preloadComplete():void
        {
            var context:String = PRELOADING_BLOCK;
            var elapsedTime:Number = this.getElapsedTime(context);
            this.trackStepTiming(PRELOADING_BLOCK, END_STEP, elapsedTime);
        }

        public function onPreloadingComplete(e:Event):void
        {
            this.preloadComplete();
        }

        public function trackRuntimeLoadStepStart(blockName:String, location:String):void
        {
            this.startTiming(location);
            this.trackStepTiming(blockName, ((location + "_") + START_STEP));
        }

        public function trackRuntimeLoadStepEnd(bytesLoaded:uint, blockName:String, location:String):void
        {
            var elapsedTime:Number = this.getElapsedTime(location);
            this.updateNetworkSpeed(bytesLoaded, elapsedTime);
            this.trackStepTiming(blockName, ((location + "_") + END_STEP), elapsedTime);
        }

        public function trackDataLoadingStart(stepLabel:String=""):void
        {
            var context:String = DATA_LOADING_BLOCK;
            this.startTiming((context + stepLabel));
            this.trackStepTiming(PRELOADING_BLOCK, ((((context + "_") + stepLabel) + "_") + START_STEP));
        }

        public function trackDataLoadingEnd(bytesLoaded:uint=0, stepLabel:String=""):void
        {
            var context:String = DATA_LOADING_BLOCK;
            var elapsedTime:Number = this.getElapsedTime((context + stepLabel));
            this.updateNetworkSpeed(bytesLoaded, elapsedTime);
            this.trackStepTiming(PRELOADING_BLOCK, ((((context + "_") + stepLabel) + "_") + END_STEP), elapsedTime);
        }

        public function trackAssetLoadingStart(stepLabel:String, path:String="", result:String=""):void
        {
            var context:String = ASSET_LOADING_BLOCK;
            this.startTiming((context + stepLabel));
            this.trackStepTiming(stepLabel, START_STEP, 0, path, result);
        }

        public function trackAssetLoadingEnd(bytesLoaded:uint, stepLabel:String, path:String="", result:String=""):void
        {
            var context:String = ASSET_LOADING_BLOCK;
            var elapsedTime:Number = this.getElapsedTimeMS((context + stepLabel));
            this.updateNetworkSpeed(bytesLoaded, elapsedTime);
            this.trackStepTiming(stepLabel, END_STEP, elapsedTime, path, result);
        }

        public function trackSubContextStart(location:String, context:String="", trackTime:Boolean=true):void
        {
            if (context.length == 0)
            {
                context = this._contextMap[location];
            };
            if (trackTime)
            {
                this.startTiming((context + location));
            };
            this._contextMap[location] = context;
        }

        public function trackSubContextEnd(location:String, pathName:String="", elapsed:Number=0, trackTime:Boolean=true):void
        {
            var context:String = this._contextMap[location];
            if (context == this._currentContext)
            {
                if (!context)
                {
                };
            };
            if (trackTime)
            {
                elapsed = this.getElapsedTimeMS((context + location));
            };
            this.trackStepTiming(context, location, elapsed, pathName);
        }

        public function trackTimingStep(context:String, location:String, elapsed:Number=0, pathName:String="", result:String=""):void
        {
            if (((!(context)) || (context == "")))
            {
                context = this._currentContext;
            };
            this.trackStepTiming(context, location, elapsed, pathName, result);
        }

        public function trackLoginLoadingError(bytesLoaded:uint=0, stepLabel:String=""):void
        {
            var context:String = ASSET_LOADING_BLOCK;
            var elapsedTime:Number = this.getElapsedTimeMS((context + stepLabel));
            this.updateNetworkSpeed(bytesLoaded, elapsedTime);
            this.trackStepTiming(stepLabel, END_STEP, elapsedTime, "", " ");
        }

        public function trackSocialCallRequest(label:String):void
        {
            var context:String = (SOCIAL_PLATFORM_CALL_BLOCK_X + label);
            this.startTiming(context);
            this.trackStepTiming(context, START_STEP);
        }

        public function trackSocialCallResponse(label:String=""):void
        {
            var context:String = (SOCIAL_PLATFORM_CALL_BLOCK_X + label);
            var elapsedTime:Number = this.getElapsedTime(context);
            this.trackStepTiming(context, END_STEP, elapsedTime);
        }

        public function trackError(reason:String, context:String, message:String=""):void
        {
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer(REASON_ATTRIBUTE, reason, CONTEXT_ATTRIBUTE, context, MESSAGE_ATTRIBUTE, message);
            this.analysisLog(ERROR, nvc);
        }

        public function trackGameAction(context:String, action:String, allStats:Boolean=false, itemName:String=null, engaged:Boolean=false, payload:Object=null):void
        {
            var key:String;
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer(CONTEXT_ATTRIBUTE, context, ACTION_ATTRIBUTE, action);
            this.addPlayerStats(nvc, allStats);
            if (itemName)
            {
                nvc.addPair(ITEM_NAME_ATTRIBUTE, itemName);
            };
            if (payload != null)
            {
                for (key in payload)
                {
                    nvc.addPair(key, payload[key]);
                };
            };
            nvc.addPair(ENGAGED, ((engaged) ? "1" : "0"));
            this.analysisLog(GAME_ACTION, nvc);
        }

        public function trackOmniture(context:String, data:Array):void
        {
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer(CONTEXT_ATTRIBUTE, context);
            if (data)
            {
                nvc.addPair(ACTION_ATTRIBUTE, data.toString());
            }
            else
            {
                nvc.addPair(ACTION_ATTRIBUTE, "view");
            };
            nvc.addPair(TRANSACTION_ID_ATTRIBUTE, this._sessionUuid);
            nvc.addPair(BROWSER_ID_ATTRIBUTE, this._browserID);
            this.analysisLog(GAME_ACTION, nvc);
        }

        public function trackPageview(context:String, engaged:Boolean=false):void
        {
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer(LOCATION_ATTRIBUTE, context);
            nvc.addPair(ENGAGED, ((engaged) ? "1" : "0"));
            this.analysisLog(PAGEVIEW, nvc);
        }

        public function trackPopup(step:String, tracking_code:String, engaged:Boolean=false):void
        {
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer(TRACKING_CODE_ATTRIBUTE, tracking_code, STEP_ATTRIBUTE, step);
            nvc.addPair(ENGAGED, ((engaged) ? "1" : "0"));
            this.analysisLog(POPUP, nvc);
        }

        public function trackLevelUp(allAccounts:Array, additionalNVC:NameValuesContainer=null, allStats:Boolean=false, engaged:Boolean=false):void
        {
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer();
            this.addPlayerStats(nvc, allStats);
            nvc.addNVC(this.getAllAccountsNVC(allAccounts));
            nvc.addNVC(additionalNVC);
            nvc.addPair(ENGAGED, ((engaged) ? "1" : "0"));
            this.analysisLog(LEVEL_UP, nvc);
        }

        public function trackMoneyTransaction(_arg_1:String, transaction:BaseMoney, subtype:String="", balance:Number=NaN, allStats:Boolean=false, engaged:Boolean=false, context:String="", payload:Object=null):void
        {
            var key:String;
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer(TYPE_ATTRIBUTE, _arg_1);
            nvc.addNVC(this.getMoneyNVC(transaction));
            nvc.addPair(SUBTYPE_ATTRIBUTE, subtype);
            if (!isNaN(balance))
            {
                nvc.addPair(BALANCE_ATTRIBUTE, String(balance));
            };
            if (this._defaultPlayerStats)
            {
                nvc.addNVC(this.getPlayerStatsNVC(this._defaultPlayerStats, allStats));
            };
            if (context != "")
            {
                nvc.addPair(CONTEXT_ATTRIBUTE, context);
            };
            if (payload != null)
            {
                for (key in payload)
                {
                    nvc.addPair(key, payload[key]);
                };
            };
            nvc.addPair(ENGAGED, ((engaged) ? "1" : "0"));
            this.analysisLog(MONEY, nvc);
        }

        public function trackPageLoadStep(location:String):void
        {
            this.trackStepTiming(PRELOADING_BLOCK, location);
        }

        public function trackStatChange(statName:String, amount:Number, context:String="", action:String="", engaged:Boolean=false):void
        {
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer(STAT_NAME_ATTRIBUTE, statName, AMOUNT_ATTRIBUTE, amount, ACTION_ATTRIBUTE, action, CONTEXT_ATTRIBUTE, context);
            nvc.addPair(ENGAGED, ((engaged) ? "1" : "0"));
            this.analysisLog(USER_STAT_CHANGE, nvc);
        }

        public function trackTestImpression(test:String, variant:String, control:uint):void
        {
            this.checkInitialized();
            var nvc:NameValuesContainer = new NameValuesContainer(TEST, test, VARIANT, variant, CONTROL, control);
            this.analysisLog(TEST_IMPRESSION, nvc);
        }

        public function trackUserInfo(transaction_id:String, isMember:Boolean, player_id:Number, city:String="", state:String="", country:String="", zip:String=""):void
        {
            var nvc:NameValuesContainer = new NameValuesContainer(TRANSACTION_ID_ATTRIBUTE, transaction_id, IS_MEMBER_ATTRIBUTE, isMember, PLAYER_ID_ATTRIBUTE, player_id, CITY_ATTRIBUTE, city, STATE_ATTRIBUTE, state, COUNTRY_ATTRIBUTE, country, ZIP_ATTRIBUTE, zip);
            this.analysisLog(USER_INFO, nvc);
        }

        public function trackGeoPixel(app:String, locale:String, user_id:String):void
        {
            var loader:Loader = new Loader();
            loader.load(new URLRequest(((((((((("http://log.data.disney.com/g?app=" + app) + "&user_id=") + user_id) + "&app_locale=") + locale) + "&network=") + this._networkID) + "&view_network=") + this._viewNetworkID)));
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onGeoPixelIOError);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onGeoPixelSecurityError);
        }

        private function onGeoPixelIOError(event:IOErrorEvent):void
        {
        }

        private function onGeoPixelSecurityError(event:SecurityErrorEvent):void
        {
        }

        protected function startPerformanceMonitor(intervalSeconds:uint, repeats:uint=0):void
        {
            if (!this._performanceDelegate)
            {
                this._performanceDelegate = new PerformanceDelegate(this);
            };
            if (this._performanceDelegate.running)
            {
                throw (new Error(ALREADY_RUNNING_ERROR));
            };
            this._performanceDelegate.startPM([0.5, 1, 2]);
        }

        protected function stopPerformanceMonitor():void
        {
            if (this._performanceDelegate)
            {
                this._performanceDelegate.stopPM();
            };
        }

        protected function get networkSpeed():Number
        {
            return ((this._totalLoadedBytes / this._totalLoadedTime) * 0.9765625);
        }

        protected function trackStepTiming(context:String, location:String, elapsed:Number=0, pathName:String="", result:String=""):void
        {
            var roundedElapsed:uint;
            this.checkInitialized();
            this.updateCurrentContext(location, context);
            var nvc:NameValuesContainer = new NameValuesContainer(CONTEXT_ATTRIBUTE, context, LOCATION_ATTRIBUTE, location);
            nvc.addPair(PATH_NAME_ATTRIBUTE, pathName);
            nvc.addPair(RESULT_ATTRIBUTE, result);
            nvc.addPair(TRANSACTION_ID_ATTRIBUTE, this._sessionUuid);
            if (this.mainModel.getCurrentWorldData())
            {
                nvc.addPair(WORLD_ID, this.mainModel.getCurrentWorldData().id);
            }
            else
            {
                nvc.addPair(WORLD_ID, BEFORE_WORLD_ID);
            };
            if (elapsed > 0)
            {
                roundedElapsed = Math.floor(elapsed);
                nvc.addPair(ELAPSED_TIME_MS_ATTRIBUTE, String(roundedElapsed));
            };
            this.analysisLog(STEP_TIMING, nvc, true);
        }

        protected function updateCurrentContext(location:String, context:String):void
        {
            if (location == START_STEP)
            {
                if (this._currentContext)
                {
                };
                this._currentContext = context;
            }
            else
            {
                if (location == END_STEP)
                {
                    this._currentContext = null;
                };
            };
        }

        protected function startTiming(key:String):void
        {
            var now:Date = new Date();
            var ms:Number = now.getTime();
            if (this._startTimes[key])
            {
                throw (new Error((ALREADY_TIMING_ERROR + key)));
            };
            this._startTimes[key] = ms;
        }

        protected function getElapsedTime(key:String):Number
        {
            var elapsedTime:Number;
            var now:Date = new Date();
            var now_ms:Number = now.getTime();
            if (this._startTimes[key])
            {
                elapsedTime = ((now_ms - this._startTimes[key]) / 1000);
                delete this._startTimes[key];
            }
            else
            {
                throw (new Error(((KEY_DOESNT_EXIST_ERROR + ": ") + key)));
            };
            return (elapsedTime);
        }

        protected function getElapsedTimeMS(key:String):Number
        {
            var elapsedTime:Number;
            var now:Date = new Date();
            var now_ms:Number = now.getTime();
            if (this._startTimes[key])
            {
                elapsedTime = (now_ms - this._startTimes[key]);
                delete this._startTimes[key];
            }
            else
            {
                throw (new Error(((KEY_DOESNT_EXIST_ERROR + ": ") + key)));
            };
            return (elapsedTime);
        }

        protected function updateNetworkSpeed(bytes:uint, ms:Number):void
        {
            if (bytes > 0)
            {
                this._totalLoadedTime = (this._totalLoadedTime + ms);
                this._totalLoadedBytes = (this._totalLoadedBytes + bytes);
            };
        }

        protected function trackSystem():void
        {
            var nvc:NameValuesContainer = new NameValuesContainer();
            nvc.addPair(SYSTEM_APP_VERSION_ATTRIBUTE, this.appVersion);
            nvc.addPair(SYSTEM_MANUFACTURER_ATTRIBUTE, Capabilities.manufacturer);
            nvc.addPair(SYSTEM_OS_ATTRIBUTE, Capabilities.os);
            nvc.addPair(SYSTEM_PLAYER_TYPE_ATTRIBUTE, Capabilities.playerType);
            nvc.addPair(SYSTEM_FP_VERSION_ATTRIBUTE, Capabilities.version);
            this.analysisLog(SYSTEM, nvc);
        }

        OnlyTracker function trackPerformance(fps:Number, context:String, pollInterval:int=0):void
        {
            var now:Date;
            var ms:Number;
            this.checkInitialized();
            var nvc:NameValuesContainer = NameValuesContainer.getInstance(CONTEXT_ATTRIBUTE, context);
            if (((context == PerformanceDelegate.PERF_POLL_CONTEXT) && (this.canPerfTrack())))
            {
                nvc.addPair(FPS_ATTRIBUTE, fps.toFixed(2));
                nvc.addPair(MEMORY_ATTRIBUTE, this.metricsModel.getMemUsageMB().toFixed(3));
                nvc.addPair(POLL_INTERVAL_ATTRIBUTE, String(pollInterval));
                nvc.addPair(COUNT_FRIENDS_EI_ATTRBIUTE, String(this.metricsModel.counters.getCount(MetricsConstant.COUNT_FRIENDS_EI_CALLS)));
                nvc.addPair(COUNT_BRIDGE_CALLS_ATTRIBUTE, String(this.metricsModel.counters.getCount(MetricsConstant.COUNT_BRIDGE_CALLS)));
                nvc.addPair(AVG_BRIDGE_LAG_ATTRIBUTE, String(this.metricsModel.getAverageBridgeLag()));
                nvc.addPair(MAX_BRIDGE_LAG_ATTRIBUTE, String(this.metricsModel.getMaxBridgeLag()));
                this.metricsModel.clearAllMetrics();
                if (!isNaN(this.networkSpeed))
                {
                    nvc.addPair(NETWORK_SPEED_ATTRIBUTE, String(this.networkSpeed.toFixed(2)));
                };
                now = new Date();
                ms = now.getTime();
                nvc.addPair(TIME_SINCE_START, String((ms - this._gameStartTime)));
                if (this._defaultPlayerStats)
                {
                    nvc.addNVC(this.getPlayerStatsNVC(this._defaultPlayerStats, false));
                };
                if (this._totalLoadedBytes)
                {
                    nvc.addPair(LOADED_BYTES_ATTRIBUTE, String(this._totalLoadedBytes));
                };
                if (this._totalLoadedTime)
                {
                    nvc.addPair(LOADING_TIME_ATTRIBUTE, String(this._totalLoadedTime));
                };
                if (this._stageRef !== null)
                {
                    nvc.addPair(DISPLAY_STATE_ATTRIBUTE, this.lastDisplayState);
                    this.lastDisplayState = this._stageRef.displayState;
                };
                nvc.addPair(TRANSACTION_ID_ATTRIBUTE, this._sessionUuid);
                this.analysisLog(PERFORMANCE, nvc, true);
            }
            else
            {
                if (((context == PerformanceDelegate.PERF_EVENT_CONTEXT) && (this.canPerfTrack())))
                {
                    nvc.addPair(MIN_FPS_ATTRBIUTE, fps.toFixed(2));
                    nvc.addPair(PLAYER_COUNT_ATTRIBUTE, String(this.mainModel.getPlayerCount()));
                    nvc.addPair(ROOM_ATTRIBUTE, String(this.mainModel.getCurrentRoomId()));
                    nvc.addPair(MEMORY_ATTRIBUTE, this.metricsModel.getMemUsageMB().toFixed(3));
                    nvc.addPair(TRANSACTION_ID_ATTRIBUTE, this._sessionUuid);
                    this.analysisLog(PERFORMANCE, nvc, true);
                };
            };
        }

        public function trackNetworkMappingInfo(playerSWID:String, playerID:String):void
        {
            this.checkInitialized();
            this.handleUserIdChange(playerSWID);
            var nvc:NameValuesContainer = new NameValuesContainer();
            nvc.addPair(SYSTEM_APP_VERSION_ATTRIBUTE, this.appVersion);
            nvc.addPair(APP_LOCALE, this._initLang);
            nvc.addPair(SECONDARY_USER_ID, playerID);
            nvc.addPair(SECONDARY_NETWORK, "c");
            this.analysisLog(MAP_SWID, nvc);
        }

        private function canPerfTrack():Boolean
        {
            if (this.mainModel.getCurrentRoomId() == CJ_SNOW_ROOM_ID)
            {
                return (false);
            };
            return (true);
        }

        protected function addPlayerStats(nvc:NameValuesContainer, allStats:Boolean=false):void
        {
            if (this._defaultPlayerStats)
            {
                nvc.addNVC(this.getPlayerStatsNVC(this._defaultPlayerStats, allStats));
            }
            else
            {
                throw (new Error(MUST_INSTANSIATE_STATS_ERROR));
            };
        }

        protected function checkInitialized():void
        {
            if (!this._initialized)
            {
                throw (new Error(MUST_INITIALIZE_ERROR));
            };
        }

        protected function getAllAccountsNVC(allAccounts:Array):NameValuesContainer
        {
            var money:BaseMoney;
            var nvc:NameValuesContainer = new NameValuesContainer();
            var cntx:uint;
            while (cntx < allAccounts.length)
            {
                money = allAccounts[cntx];
                nvc.addNVC(this.getAccountNVC(money));
                cntx++;
            };
            return (nvc);
        }

        public function analysisLog(tag:uint, nvc:NameValuesContainer=null, flush:Boolean=false):void
        {
            var myNVC:NameValuesContainer = new NameValuesContainer();
            myNVC.addNVC(this.gameDataNVC);
            myNVC.addPair(TAG_ATTRIBUTE, tagStrings[tag]);
            myNVC.addNVC(nvc);
            var myNVString:String = myNVC.toString();
            this.logManager.log(myNVString, flush);
        }

        protected function getPlayerStatsNVC(stats:BasePlayerStats, all:Boolean=false):NameValuesContainer
        {
            var nvc:NameValuesContainer;
            var describeXML:XML;
            var variableXMLList:XMLList;
            var cntx:uint;
            var node:XML;
            var attributeName:String;
            var attributeValue:String;
            if (((getQualifiedClassName(stats) == BASE_PLAYER_PATH) || (!(all))))
            {
                return (new NameValuesContainer(EXPERIENCE_ATTRIBUTE, stats.experience, LEVEL_ATTRIBUTE, stats.level));
            };
            nvc = new NameValuesContainer();
            describeXML = describeType(stats);
            variableXMLList = describeXML.variable;
            cntx = 0;
            while (cntx < variableXMLList.length())
            {
                node = variableXMLList[cntx];
                attributeName = node.@name[0];
                attributeValue = stats[attributeName];
                nvc.addPair(attributeName, attributeValue);
                cntx++;
            };
            return (nvc);
        }

        protected function getAccountNVC(money:BaseMoney):NameValuesContainer
        {
            return (new NameValuesContainer(((BALANCE_ATTRIBUTE + "_") + money.currency), money.amount));
        }

        protected function getMoneyNVC(money:BaseMoney):NameValuesContainer
        {
            return (new NameValuesContainer(CURRENCY_ATTRIBUTE, money.currency, AMOUNT_ATTRIBUTE, money.amount, SUBTYPE, money.item));
        }


    }
}//package com.playdom.tracker
import flash.display.Sprite;

Sprite;
