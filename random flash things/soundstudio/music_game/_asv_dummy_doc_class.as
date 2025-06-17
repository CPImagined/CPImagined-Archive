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
    import back_sfx; back_sfx;
    import fl.core.UIComponent; fl.core.UIComponent;
    import com.clubpenguin.tools.localtext.core.TextBounds; com.clubpenguin.tools.localtext.core.TextBounds;
    import LikeButtonMC_NoThumb; LikeButtonMC_NoThumb;
    import LikePopupBelow; LikePopupBelow;
    import SongListItemSkin; SongListItemSkin;
    import com.clubpenguin.world.rooms2014.common.partyIglooMap.view.IglooMapListItemRenderer; com.clubpenguin.world.rooms2014.common.partyIglooMap.view.IglooMapListItemRenderer;
    import icon343; icon343;
    import music_btn1; music_btn1;
    import music_btn2; music_btn2;
    import music_btn3; music_btn3;
    import music_btn4; music_btn4;
    import music_btn5; music_btn5;
    import music_btn6; music_btn6;
    import music_game_fla.LED_Light_69; music_game_fla.LED_Light_69;
    import music_game_fla.PlayerItem_138; music_game_fla.PlayerItem_138;
    import music_game_fla.ProtobotThruster_84; music_game_fla.ProtobotThruster_84;
    import music_game_fla.animate_02_191; music_game_fla.animate_02_191;
    import music_game_fla.animate_03_193; music_game_fla.animate_03_193;
    import music_game_fla.countdown_animation_9; music_game_fla.countdown_animation_9;
    import music_game_fla.instructions_all_184; music_game_fla.instructions_all_184;
    import music_game_fla.like_203; music_game_fla.like_203;
    import music_game_fla.likes_204; music_game_fla.likes_204;
    import music_game_fla.organpipeanim_64; music_game_fla.organpipeanim_64;
    import music_game_fla.play_pause_133; music_game_fla.play_pause_133;
    import music_game_fla.saving_animation_131; music_game_fla.saving_animation_131;
    import music_game_fla.soundstudio_simple_160; music_game_fla.soundstudio_simple_160;
    import music_progress; music_progress;
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
