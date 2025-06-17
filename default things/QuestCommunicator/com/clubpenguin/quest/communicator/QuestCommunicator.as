//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.quest.communicator
{
    import com.clubpenguin.lib.module.BaseModule;

    public class QuestCommunicator extends BaseModule 
    {


        override public function init():void
        {
            context = new QuestCommunicatorContext(this, injector);
        }


    }
}//package com.clubpenguin.quest.communicator
    //force all classes
    import com.clubpenguin.lib.module.BaseModule; com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.quest.communicator.QuestCommunicator; com.clubpenguin.quest.communicator.QuestCommunicator;
    import org.robotlegs.core.IInjector; org.robotlegs.core.IInjector;
    import org.osflash.signals.IDispatcher; org.osflash.signals.IDispatcher;
    import org.osflash.signals.ISignal; org.osflash.signals.ISignal;
    import org.osflash.signals.Signal; org.osflash.signals.Signal;
    import com.clubpenguin.lib.module.IAppSignalBus; com.clubpenguin.lib.module.IAppSignalBus;
    import org.robotlegs.core.IContext; org.robotlegs.core.IContext;
    import org.robotlegs.base.ContextBase; org.robotlegs.base.ContextBase;
    import org.robotlegs.mvcs.Context; org.robotlegs.mvcs.Context;
    import org.robotlegs.core.ISignalContext; org.robotlegs.core.ISignalContext;
    import org.robotlegs.mvcs.SignalContext; org.robotlegs.mvcs.SignalContext;
    import com.clubpenguin.lib.module.BaseModuleContext; com.clubpenguin.lib.module.BaseModuleContext;
    import com.clubpenguin.quest.communicator.QuestCommunicatorContext; com.clubpenguin.quest.communicator.QuestCommunicatorContext;
    import org.robotlegs.core.IEventMap; org.robotlegs.core.IEventMap;
    import org.robotlegs.base.EventMap; org.robotlegs.base.EventMap;
    import org.robotlegs.core.IReflector; org.robotlegs.core.IReflector;
    import org.robotlegs.core.ICommandMap; org.robotlegs.core.ICommandMap;
    import org.robotlegs.base.CommandMap; org.robotlegs.base.CommandMap;
    import org.robotlegs.core.IMediatorMap; org.robotlegs.core.IMediatorMap;
    import org.robotlegs.core.IViewMap; org.robotlegs.core.IViewMap;
    import org.robotlegs.base.ViewMapBase; org.robotlegs.base.ViewMapBase;
    import org.robotlegs.base.ViewMap; org.robotlegs.base.ViewMap;
    import org.robotlegs.base.ContextEvent; org.robotlegs.base.ContextEvent;
    import org.robotlegs.base.MediatorMap; org.robotlegs.base.MediatorMap;
    import org.swiftsuspenders.Injector; org.swiftsuspenders.Injector;
    import org.robotlegs.adapters.SwiftSuspendersInjector; org.robotlegs.adapters.SwiftSuspendersInjector;
    import org.swiftsuspenders.Reflector; org.swiftsuspenders.Reflector;
    import org.robotlegs.adapters.SwiftSuspendersReflector; org.robotlegs.adapters.SwiftSuspendersReflector;
    import org.robotlegs.core.ISignalCommandMap; org.robotlegs.core.ISignalCommandMap;
    import org.robotlegs.base.SignalCommandMap; org.robotlegs.base.SignalCommandMap;
    import org.robotlegs.mvcs.Command; org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.commands.CloseModuleCommand; com.clubpenguin.lib.commands.CloseModuleCommand;
    import com.clubpenguin.lib.signals.CloseModuleSignal; com.clubpenguin.lib.signals.CloseModuleSignal;
    import org.robotlegs.mvcs.SignalCommand; org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.quest.communicator.commands.DismissCommunicatorCommand; com.clubpenguin.quest.communicator.commands.DismissCommunicatorCommand;
    import com.clubpenguin.quest.communicator.mediator.QuestCommunicatorMediator; com.clubpenguin.quest.communicator.mediator.QuestCommunicatorMediator;
    import com.clubpenguin.quest.communicator.service.QuestCommunicatorBridgeService; com.clubpenguin.quest.communicator.service.QuestCommunicatorBridgeService;
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView; com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import com.clubpenguin.quest.communicator.view.QuestCommunicatorView; com.clubpenguin.quest.communicator.view.QuestCommunicatorView;
    import com.clubpenguin.lib.module.IAppModel; com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.quest.communicator.commands.DisplayMessageCommand; com.clubpenguin.quest.communicator.commands.DisplayMessageCommand;
    import org.robotlegs.base.ContextError; org.robotlegs.base.ContextError;
    import org.robotlegs.core.IMediator; org.robotlegs.core.IMediator;
    import org.swiftsuspenders.injectionpoints.InjectionPoint; org.swiftsuspenders.injectionpoints.InjectionPoint;
    import org.swiftsuspenders.injectionpoints.PropertyInjectionPoint; org.swiftsuspenders.injectionpoints.PropertyInjectionPoint;
    import org.swiftsuspenders.injectionpoints.NoParamsConstructorInjectionPoint; org.swiftsuspenders.injectionpoints.NoParamsConstructorInjectionPoint;
    import org.swiftsuspenders.injectionresults.InjectionResult; org.swiftsuspenders.injectionresults.InjectionResult;
    import org.swiftsuspenders.injectionresults.InjectClassResult; org.swiftsuspenders.injectionresults.InjectClassResult;
    import org.swiftsuspenders.injectionresults.InjectOtherRuleResult; org.swiftsuspenders.injectionresults.InjectOtherRuleResult;
    import org.swiftsuspenders.injectionresults.InjectSingletonResult; org.swiftsuspenders.injectionresults.InjectSingletonResult;
    import org.swiftsuspenders.injectionpoints.PostConstructInjectionPoint; org.swiftsuspenders.injectionpoints.PostConstructInjectionPoint;
// //     import org.swiftsuspenders.getConstructor; org.swiftsuspenders.getConstructor;
    import org.swiftsuspenders.InjectionConfig; org.swiftsuspenders.InjectionConfig;
    import org.swiftsuspenders.InjectorError; org.swiftsuspenders.InjectorError;
    import org.swiftsuspenders.injectionresults.InjectValueResult; org.swiftsuspenders.injectionresults.InjectValueResult;
    import org.swiftsuspenders.injectionpoints.MethodInjectionPoint; org.swiftsuspenders.injectionpoints.MethodInjectionPoint;
    import org.swiftsuspenders.injectionpoints.ConstructorInjectionPoint; org.swiftsuspenders.injectionpoints.ConstructorInjectionPoint;
    import com.clubpenguin.quest.communicator.view.EmbeddedQuestCommunicatorAssets; com.clubpenguin.quest.communicator.view.EmbeddedQuestCommunicatorAssets;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager; com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.util.Log; com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.services.IAVMBridgeService; com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.tools.localtext.core.ILocalText; com.clubpenguin.tools.localtext.core.ILocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy; com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.lib.vo.IPlayerVO; com.clubpenguin.lib.vo.IPlayerVO;
    import com.clubpenguin.lib.vo.PathsVO; com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.lib.vo.EnvironmentDataVO; com.clubpenguin.lib.vo.EnvironmentDataVO;
    import mx.core.IFlexAsset; mx.core.IFlexAsset;
    import mx.core.FlexMovieClip; mx.core.FlexMovieClip;
    import mx.core.IFlexDisplayObject; mx.core.IFlexDisplayObject;
    import mx.core.IBorder; mx.core.IBorder;
    import mx.core.MovieClipAsset; mx.core.MovieClipAsset;
    import mx.core.MovieClipLoaderAsset; mx.core.MovieClipLoaderAsset;
    import com.clubpenguin.quest.communicator.view.EmbeddedQuestCommunicatorAssets_HALLOWEEN_ASSET; com.clubpenguin.quest.communicator.view.EmbeddedQuestCommunicatorAssets_HALLOWEEN_ASSET;
    import com.clubpenguin.tools.localtext.core.ILocalizedText; com.clubpenguin.tools.localtext.core.ILocalizedText;
    import com.clubpenguin.lib.vo.AVMBridgeMessage; com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.tools.localtext.core.FontLibrary; com.clubpenguin.tools.localtext.core.FontLibrary;
    import com.clubpenguin.tools.localtext.core.IFontLibraryDependant; com.clubpenguin.tools.localtext.core.IFontLibraryDependant;
    import com.clubpenguin.tools.localtext.core.ILocalTextField; com.clubpenguin.tools.localtext.core.ILocalTextField;
    import com.clubpenguin.tools.localtext.core.LocalTextField; com.clubpenguin.tools.localtext.core.LocalTextField;
    import com.clubpenguin.lib.util.collection.ICollection; com.clubpenguin.lib.util.collection.ICollection;
    import com.clubpenguin.lib.enums.Enum; com.clubpenguin.lib.enums.Enum;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum; com.clubpenguin.lib.enums.resource.CacheTypeEnum;
    import mx.core.mx_internal; mx.core.mx_internal;
    import mx.utils.NameUtil; mx.utils.NameUtil;
    import mx.core.EdgeMetrics; mx.core.EdgeMetrics;
    import mx.core.ByteArrayAsset; mx.core.ByteArrayAsset;
    import com.clubpenguin.quest.communicator.view.EmbeddedQuestCommunicatorAssets_HALLOWEEN_ASSET_dataClass; com.clubpenguin.quest.communicator.view.EmbeddedQuestCommunicatorAssets_HALLOWEEN_ASSET_dataClass;
    import com.clubpenguin.tools.localtext.core.TextBounds; com.clubpenguin.tools.localtext.core.TextBounds;
    import com.clubpenguin.tools.localtext.component.MismatchedVersionsHack; com.clubpenguin.tools.localtext.component.MismatchedVersionsHack;
    import com.clubpenguin.tools.localtext.core.events.FontLibraryEvent; com.clubpenguin.tools.localtext.core.events.FontLibraryEvent;
    import com.clubpenguin.tools.localtext.core.CharCodeReplacementMap; com.clubpenguin.tools.localtext.core.CharCodeReplacementMap;
    import com.clubpenguin.lib.vo.IVO; com.clubpenguin.lib.vo.IVO;
    import com.clubpenguin.lib.util.StringUtils; com.clubpenguin.lib.util.StringUtils;
    import mx.core.IRepeaterClient; mx.core.IRepeaterClient;
