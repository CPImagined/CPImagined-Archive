//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.model
{
    import com.clubpenguin.lib.enums.Enum;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import com.clubpenguin.puffles.adoption.BluePuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.BluePuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.BluePuffleAttentionView;
    import com.clubpenguin.puffles.adoption.BluePuffleSelectedView;
    import com.clubpenguin.puffles.adoption.PinkPuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.PinkPuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.PinkPuffleAttentionView;
    import com.clubpenguin.puffles.adoption.PinkPuffleSelectedView;
    import com.clubpenguin.puffles.adoption.BlackPuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.BlackPuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.BlackPuffleAttentionView;
    import com.clubpenguin.puffles.adoption.BlackPuffleSelectedView;
    import com.clubpenguin.puffles.adoption.GreenPuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.GreenPuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.GreenPuffleAttentionView;
    import com.clubpenguin.puffles.adoption.GreenPuffleSelectedView;
    import com.clubpenguin.puffles.adoption.PurplePuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.PurplePuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.PurplePuffleAttentionView;
    import com.clubpenguin.puffles.adoption.PurplePuffleSelectedView;
    import com.clubpenguin.puffles.adoption.RedPuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.RedPuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.RedPuffleAttentionView;
    import com.clubpenguin.puffles.adoption.RedPuffleSelectedView;
    import com.clubpenguin.puffles.adoption.YellowPuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.YellowPuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.YellowPuffleAttentionView;
    import com.clubpenguin.puffles.adoption.YellowPuffleSelectedView;
    import com.clubpenguin.puffles.adoption.WhitePuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.WhitePuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.WhitePuffleAttentionView;
    import com.clubpenguin.puffles.adoption.WhitePuffleSelectedView;
    import com.clubpenguin.puffles.adoption.OrangePuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.OrangePuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.OrangePuffleAttentionView;
    import com.clubpenguin.puffles.adoption.OrangePuffleSelectedView;
    import com.clubpenguin.puffles.adoption.BrownPuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.BrownPuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.BrownPuffleAttentionView;
    import com.clubpenguin.puffles.adoption.BrownPuffleSelectedView;
    import com.clubpenguin.lib.enums.puffle.PuffleSubTypeEnum;
    import com.clubpenguin.puffles.adoption.BlueDogPuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.BlueDogPuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.BlueDogPuffleAttentionView;
    import com.clubpenguin.puffles.adoption.BlueDogPuffleSelectedView;
    import com.clubpenguin.puffles.adoption.OrangeCatPuffleAmbient1View;
    import com.clubpenguin.puffles.adoption.OrangeCatPuffleAmbient2View;
    import com.clubpenguin.puffles.adoption.OrangeCatPuffleAttentionView;
    import com.clubpenguin.puffles.adoption.OrangeCatPuffleSelectedView;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;

    public class PufflePenViewEnum extends Enum 
    {

        public static const BLUE:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.BLUE.colorName, PuffleTypeEnum.BLUE.id, false, BluePuffleAmbient1View, BluePuffleAmbient2View, BluePuffleAttentionView, BluePuffleSelectedView);
        public static const PINK:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.PINK.colorName, PuffleTypeEnum.PINK.id, false, PinkPuffleAmbient1View, PinkPuffleAmbient2View, PinkPuffleAttentionView, PinkPuffleSelectedView);
        public static const BLACK:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.BLACK.colorName, PuffleTypeEnum.BLACK.id, false, BlackPuffleAmbient1View, BlackPuffleAmbient2View, BlackPuffleAttentionView, BlackPuffleSelectedView);
        public static const GREEN:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.GREEN.colorName, PuffleTypeEnum.GREEN.id, false, GreenPuffleAmbient1View, GreenPuffleAmbient2View, GreenPuffleAttentionView, GreenPuffleSelectedView);
        public static const PURPLE:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.PURPLE.colorName, PuffleTypeEnum.PURPLE.id, false, PurplePuffleAmbient1View, PurplePuffleAmbient2View, PurplePuffleAttentionView, PurplePuffleSelectedView);
        public static const RED:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.RED.colorName, PuffleTypeEnum.RED.id, false, RedPuffleAmbient1View, RedPuffleAmbient2View, RedPuffleAttentionView, RedPuffleSelectedView);
        public static const YELLOW:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.YELLOW.colorName, PuffleTypeEnum.YELLOW.id, false, YellowPuffleAmbient1View, YellowPuffleAmbient2View, YellowPuffleAttentionView, YellowPuffleSelectedView);
        public static const WHITE:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.WHITE.colorName, PuffleTypeEnum.WHITE.id, false, WhitePuffleAmbient1View, WhitePuffleAmbient2View, WhitePuffleAttentionView, WhitePuffleSelectedView);
        public static const ORANGE:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.ORANGE.colorName, PuffleTypeEnum.ORANGE.id, false, OrangePuffleAmbient1View, OrangePuffleAmbient2View, OrangePuffleAttentionView, OrangePuffleSelectedView);
        public static const BROWN:PufflePenViewEnum = new PufflePenViewEnum(PuffleTypeEnum.BROWN.colorName, PuffleTypeEnum.BROWN.id, false, BrownPuffleAmbient1View, BrownPuffleAmbient2View, BrownPuffleAttentionView, BrownPuffleSelectedView);
        public static const BLUE_BORDER_COLLIE:PufflePenViewEnum = new PufflePenViewEnum(PuffleSubTypeEnum.BLUE_BORDER_COLLIE.name, PuffleSubTypeEnum.BLUE_BORDER_COLLIE.id, true, BlueDogPuffleAmbient1View, BlueDogPuffleAmbient2View, BlueDogPuffleAttentionView, BlueDogPuffleSelectedView);
        public static const ORANGE_TABBY_CAT:PufflePenViewEnum = new PufflePenViewEnum(PuffleSubTypeEnum.ORANGE_TABBY_CAT.name, PuffleSubTypeEnum.ORANGE_TABBY_CAT.id, true, OrangeCatPuffleAmbient1View, OrangeCatPuffleAmbient2View, OrangeCatPuffleAttentionView, OrangeCatPuffleSelectedView);
        public static const PUFFLE_PEN_VIEW_ENUM_LIST:Array = Enum.createList(PufflePenViewEnum);

        public var name:String;
        public var ID:uint;
        public var isWild:Boolean;
        private var _ambientViewClass:Class;
        private var _ambient2ViewClass:Class;
        private var _attentionViewClass:Class;
        private var _selectedViewClass:Class;

        public function PufflePenViewEnum(name:String, ID:uint, isWild:Boolean, ambientViewClass:Class, ambient2ViewClass:Class, attentionViewClass:Class, selectedViewClass:Class)
        {
            this.name = name;
            this.ID = ID;
            this.isWild = isWild;
            this._ambientViewClass = ambientViewClass;
            this._ambient2ViewClass = ambient2ViewClass;
            this._attentionViewClass = attentionViewClass;
            this._selectedViewClass = selectedViewClass;
        }

        public static function getPenViewEnumByName(name:String):PufflePenViewEnum
        {
            var i:int;
            while (i < PUFFLE_PEN_VIEW_ENUM_LIST.length)
            {
                if (PufflePenViewEnum(PUFFLE_PEN_VIEW_ENUM_LIST[i]).name == name)
                {
                    return (PufflePenViewEnum(PUFFLE_PEN_VIEW_ENUM_LIST[i]));
                };
                i++;
            };
            return (null);
        }


        public function createPuffleVO():PuffleVO
        {
            var puffleVO:PuffleVO = new PuffleVO();
            if (this.isWild)
            {
                puffleVO.subType = PuffleSubTypeEnum.getPuffleSubTypeEnumByID(this.ID);
                puffleVO.type = PuffleTypeEnum.getPuffleTypeEnumByID(puffleVO.subType.baseTypeId);
            }
            else
            {
                puffleVO.type = PuffleTypeEnum.getPuffleTypeEnumByID(this.ID);
            };
            return (puffleVO);
        }

        public function get ambientViewClass():Class
        {
            return (this._ambientViewClass);
        }

        public function get attentionViewClass():Class
        {
            return (this._attentionViewClass);
        }

        public function get selectedViewClass():Class
        {
            return (this._selectedViewClass);
        }

        public function get ambient2ViewClass():Class
        {
            return (this._ambient2ViewClass);
        }


    }
}//package com.clubpenguin.puffles.adoption.model
