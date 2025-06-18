//Dummy document class created by Action Script Viewer
//
package
{
    import flash.display.*;
    //force all classes
    import com.clubpenguin.tools.localtext.core.IFontLibraryDependant; com.clubpenguin.tools.localtext.core.IFontLibraryDependant;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent; com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import fl.managers.IFocusManagerComponent; fl.managers.IFocusManagerComponent;
    import fl.managers.IFocusManager; fl.managers.IFocusManager;
    import fl.core.InvalidationType; fl.core.InvalidationType;
    import com.clubpenguin.tools.localtext.core.CharCodeReplacementMap; com.clubpenguin.tools.localtext.core.CharCodeReplacementMap;
    import fl.managers.StyleManager; fl.managers.StyleManager;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy; com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.core.commands.VAlignLTFContentCMD; com.clubpenguin.tools.localtext.core.commands.VAlignLTFContentCMD;
    import com.clubpenguin.tools.localtext.component.filters.controller.ApplyRawFiltersToTextFieldCMD; com.clubpenguin.tools.localtext.component.filters.controller.ApplyRawFiltersToTextFieldCMD;
    import com.clubpenguin.tools.localtext.component.filters.FilterDefinition; com.clubpenguin.tools.localtext.component.filters.FilterDefinition;
    import fl.managers.IFocusManagerGroup; fl.managers.IFocusManagerGroup;
    import com.clubpenguin.tools.localtext.core.LocalTextAlign; com.clubpenguin.tools.localtext.core.LocalTextAlign;
    import com.clubpenguin.tools.localtext.component.filters.controller.BitmapFilterFactory; com.clubpenguin.tools.localtext.component.filters.controller.BitmapFilterFactory;
    import com.clubpenguin.tools.localtext.component.filters.LTCFilterUtils; com.clubpenguin.tools.localtext.component.filters.LTCFilterUtils;
    import com.clubpenguin.tools.localtext.component.filters.FilterType; com.clubpenguin.tools.localtext.component.filters.FilterType;
    import com.clubpenguin.tools.localtext.core.ILocalizedText; com.clubpenguin.tools.localtext.core.ILocalizedText;
    import com.clubpenguin.tools.localtext.component.controlpanel.LTCjsfl; com.clubpenguin.tools.localtext.component.controlpanel.LTCjsfl;
    import fl.controls.ButtonLabelPlacement; fl.controls.ButtonLabelPlacement;
    import fl.controls.listClasses.ICellRenderer; fl.controls.listClasses.ICellRenderer;
    import fl.data.SimpleCollectionItem; fl.data.SimpleCollectionItem;
    import fl.controls.listClasses.ListData; fl.controls.listClasses.ListData;
    import fl.events.DataChangeType; fl.events.DataChangeType;
    import fl.controls.ScrollPolicy; fl.controls.ScrollPolicy;
    import fl.controls.ScrollBarDirection; fl.controls.ScrollBarDirection;
    import cpBurbankSmall; cpBurbankSmall;
    import com.clubpenguin.tools.localtext.core.ILocalTextField; com.clubpenguin.tools.localtext.core.ILocalTextField;
    import com.clubpenguin.tools.localtext.core.ILocalText; com.clubpenguin.tools.localtext.core.ILocalText;
    import com.clubpenguin.cardjitsu.ninjaprogress.ScrollBarEvent; com.clubpenguin.cardjitsu.ninjaprogress.ScrollBarEvent;
    import com.clubpenguin.tools.localtext.core.events.FontLibraryEvent; com.clubpenguin.tools.localtext.core.events.FontLibraryEvent;
    import fl.events.ComponentEvent; fl.events.ComponentEvent;
    import fl.events.DataChangeEvent; fl.events.DataChangeEvent;
    import fl.events.ListEvent; fl.events.ListEvent;
    import fl.events.ScrollEvent; fl.events.ScrollEvent;
    import fl.managers.FocusManager; fl.managers.FocusManager;
    import com.clubpenguin.tools.localtext.core.FontLibrary; com.clubpenguin.tools.localtext.core.FontLibrary;
    import fl.data.DataProvider; fl.data.DataProvider;
    import fl.core.UIComponent; fl.core.UIComponent;
    import com.clubpenguin.tools.localtext.core.TextBounds; com.clubpenguin.tools.localtext.core.TextBounds;
    import CJProgressViewer; CJProgressViewer;
    import CardJitsuProgressInventoryAssets_fla.CardPanelContent_27; CardJitsuProgressInventoryAssets_fla.CardPanelContent_27;
    import CardJitsuProgressInventoryAssets_fla.CardScroll_71; CardJitsuProgressInventoryAssets_fla.CardScroll_71;
    import CardJitsuProgressInventoryAssets_fla.CountTextContainer_66; CardJitsuProgressInventoryAssets_fla.CountTextContainer_66;
    import CardJitsuProgressInventoryAssets_fla.GoBackButton_111; CardJitsuProgressInventoryAssets_fla.GoBackButton_111;
    import CardJitsuProgressInventoryAssets_fla.MyProgressButton_81; CardJitsuProgressInventoryAssets_fla.MyProgressButton_81;
    import CardJitsuProgressInventoryAssets_fla.ProgressBar_104; CardJitsuProgressInventoryAssets_fla.ProgressBar_104;
    import CardJitsuProgressInventoryAssets_fla.ProgressPanelContent_76; CardJitsuProgressInventoryAssets_fla.ProgressPanelContent_76;
    import CardJitsuProgressInventoryAssets_fla.ProgressScroll_278; CardJitsuProgressInventoryAssets_fla.ProgressScroll_278;
    import CardJitsuProgressInventoryAssets_fla.RedeemtionWarningPopup_281; CardJitsuProgressInventoryAssets_fla.RedeemtionWarningPopup_281;
    import CardJitsuProgressInventoryAssets_fla.SnowPanelContent_4; CardJitsuProgressInventoryAssets_fla.SnowPanelContent_4;
    import CardJitsuProgressInventoryAssets_fla.SnowScroll_22; CardJitsuProgressInventoryAssets_fla.SnowScroll_22;
    import CardJitsuProgressInventoryAssets_fla.SnowVideoThumb_17; CardJitsuProgressInventoryAssets_fla.SnowVideoThumb_17;
    import CardJitsuProgressInventoryAssets_fla.btn_I_285; CardJitsuProgressInventoryAssets_fla.btn_I_285;
    import CardJitsuProgressInventoryAssets_fla.btn_I_67; CardJitsuProgressInventoryAssets_fla.btn_I_67;
    import CardJitsuProgressInventoryAssets_fla.btn_Ibuycards_69; CardJitsuProgressInventoryAssets_fla.btn_Ibuycards_69;
    import CardJitsuProgressInventoryAssets_fla.btn_nothanks_tan_286; CardJitsuProgressInventoryAssets_fla.btn_nothanks_tan_286;
    import CardJitsuProgressInventoryAssets_fla.cardItemScrollWindow_32; CardJitsuProgressInventoryAssets_fla.cardItemScrollWindow_32;
    import CardJitsuProgressInventoryAssets_fla.fireGemStates_247; CardJitsuProgressInventoryAssets_fla.fireGemStates_247;
    import CardJitsuProgressInventoryAssets_fla.lock_icon_21; CardJitsuProgressInventoryAssets_fla.lock_icon_21;
    import CardJitsuProgressInventoryAssets_fla.number_count_55; CardJitsuProgressInventoryAssets_fla.number_count_55;
    import CardJitsuProgressInventoryAssets_fla.progressWindowCJ_252; CardJitsuProgressInventoryAssets_fla.progressWindowCJ_252;
    import CardJitsuProgressInventoryAssets_fla.progressWindowFire_78; CardJitsuProgressInventoryAssets_fla.progressWindowFire_78;
    import CardJitsuProgressInventoryAssets_fla.progressWindowSnow_145; CardJitsuProgressInventoryAssets_fla.progressWindowSnow_145;
    import CardJitsuProgressInventoryAssets_fla.progressWindowWater_113; CardJitsuProgressInventoryAssets_fla.progressWindowWater_113;
    import CardJitsuProgressInventoryAssets_fla.snowGemStates_237; CardJitsuProgressInventoryAssets_fla.snowGemStates_237;
    import CardJitsuProgressInventoryAssets_fla.snowVideoStills_19; CardJitsuProgressInventoryAssets_fla.snowVideoStills_19;
    import CardJitsuProgressInventoryAssets_fla.titleTextContainer_309; CardJitsuProgressInventoryAssets_fla.titleTextContainer_309;
    import CardJitsuProgressInventoryAssets_fla.waterGemStates_242; CardJitsuProgressInventoryAssets_fla.waterGemStates_242;
    import com.clubpenguin.cardjitsu.ninjaprogress.ScrollPain; com.clubpenguin.cardjitsu.ninjaprogress.ScrollPain;
    import com.clubpenguin.cardjitsu.ninjaprogress.ScrollPainBar; com.clubpenguin.cardjitsu.ninjaprogress.ScrollPainBar;
    import com.clubpenguin.widgets.ninja.Amulet; com.clubpenguin.widgets.ninja.Amulet;
    import fl.core.ComponentShim; fl.core.ComponentShim;
    import com.clubpenguin.tools.localtext.core.LocalTextField; com.clubpenguin.tools.localtext.core.LocalTextField;
    import com.clubpenguin.tools.localtext.component.LocalTextComponent; com.clubpenguin.tools.localtext.component.LocalTextComponent;
    import fl.controls.BaseButton; fl.controls.BaseButton;
    import fl.controls.ComboBox; fl.controls.ComboBox;
    import fl.controls.TextInput; fl.controls.TextInput;
    import fl.containers.BaseScrollPane; fl.containers.BaseScrollPane;
    import fl.controls.ScrollBar; fl.controls.ScrollBar;
    import fl.controls.LabelButton; fl.controls.LabelButton;
    import fl.controls.SelectableList; fl.controls.SelectableList;
    import fl.controls.Button; fl.controls.Button;
    import fl.controls.listClasses.CellRenderer; fl.controls.listClasses.CellRenderer;
    import fl.controls.List; fl.controls.List;

    public dynamic class _asv_dummy_doc_class extends MovieClip
    {

    }
}//package 
