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
    import com.clubpenguin.puffles.adoption.PurplePuffleAmbient1View; com.clubpenguin.puffles.adoption.PurplePuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.PurplePuffleSelectedView; com.clubpenguin.puffles.adoption.PurplePuffleSelectedView;
    import com.clubpenguin.puffles.adoption.WhitePuffleAmbient1View; com.clubpenguin.puffles.adoption.WhitePuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.YellowPuffleAmbient1View; com.clubpenguin.puffles.adoption.YellowPuffleAmbient1View;
    import pufflePen_fla.AdoptButtonYellowMember_55; pufflePen_fla.AdoptButtonYellowMember_55;
    import pufflePen_fla.CurrentCoinsGreen_29; pufflePen_fla.CurrentCoinsGreen_29;
    import pufflePen_fla.PP_PurplePuffleSelected_77; pufflePen_fla.PP_PurplePuffleSelected_77;
    import pufflePen_fla.buttonClipGoldPoster_11; pufflePen_fla.buttonClipGoldPoster_11;
    import pufflePen_fla.buttonClipRainbowPoster_5; pufflePen_fla.buttonClipRainbowPoster_5;
    import pufflePen_fla.buttonSelectBlack_45; pufflePen_fla.buttonSelectBlack_45;
    import pufflePen_fla.buttonSelectBlue_33; pufflePen_fla.buttonSelectBlue_33;
    import pufflePen_fla.buttonSelectBrown_44; pufflePen_fla.buttonSelectBrown_44;
    import pufflePen_fla.buttonSelectGreen_41; pufflePen_fla.buttonSelectGreen_41;
    import pufflePen_fla.buttonSelectOrange_39; pufflePen_fla.buttonSelectOrange_39;
    import pufflePen_fla.buttonSelectPink_43; pufflePen_fla.buttonSelectPink_43;
    import pufflePen_fla.buttonSelectPurple_42; pufflePen_fla.buttonSelectPurple_42;
    import pufflePen_fla.buttonSelectRed_37; pufflePen_fla.buttonSelectRed_37;
    import pufflePen_fla.buttonSelectWhite_38; pufflePen_fla.buttonSelectWhite_38;
    import pufflePen_fla.buttonSelectYellow_40; pufflePen_fla.buttonSelectYellow_40;
    import pufflePen_fla.clipboardDefault_30; pufflePen_fla.clipboardDefault_30;
    import pufflePen_fla.puffleIconsALL_62; pufflePen_fla.puffleIconsALL_62;
    import pufflePen_fla.puffle_facts_54; pufflePen_fla.puffle_facts_54;
    import pufflePen_fla.select_cat_btn_51; pufflePen_fla.select_cat_btn_51;
    import pufflePen_fla.select_dog_btn_46; pufflePen_fla.select_dog_btn_46;
    import pufflePen_fla.sparkles66_10; pufflePen_fla.sparkles66_10;
    import pufflePen_fla.txtAdoptButtonMember_59; pufflePen_fla.txtAdoptButtonMember_59;
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
