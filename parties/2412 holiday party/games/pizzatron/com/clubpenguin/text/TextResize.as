class com.clubpenguin.text.TextResize
{
   function TextResize()
   {
   }
   static function scaleDown($field, $verticalAlign, $minFontSize)
   {
      if($field.autoSize != "none")
      {
         return undefined;
      }
      var _loc7_ = $field._width;
      var _loc5_ = $field._height;
      var _loc6_ = undefined;
      var _loc10_ = $field.textHeight;
      var _loc11_ = undefined;
      var _loc9_ = $field._x;
      var _loc8_ = $field._y;
      var _loc2_ = $field.getTextFormat();
      var _loc12_ = _loc2_.size;
      var _loc4_ = true;
      _loc6_ = _loc2_.align;
      _loc11_ = _loc2_.size;
      $minFontSize = $minFontSize != undefined ? $minFontSize : 2;
      if($field.multiline)
      {
         $field.wordWrap = true;
      }
      else
      {
         $field.wordWrap = false;
      }
      while(_loc4_)
      {
         $field.autoSize = _loc6_;
         if($field._width > _loc7_ || $field._height > _loc5_)
         {
            _loc2_.size = _loc2_.size - 1;
            if(_loc2_.size < $minFontSize)
            {
               _loc2_.size = $minFontSize;
               _loc4_ = false;
            }
         }
         else
         {
            _loc4_ = false;
         }
         $field.autoSize = "none";
         _loc2_.align = _loc6_;
         $field.setTextFormat(_loc2_);
         $field._height = _loc5_;
         $field._width = _loc7_;
         $field._x = _loc9_;
         $field._y = _loc8_;
      }
      if(!$field.multiline)
      {
         switch($verticalAlign)
         {
            case "center":
               $field._y += (_loc10_ - $field.textHeight - 1) / 2;
               break;
            case "bottom":
               $field._y += _loc10_ - $field.textHeight - 1;
               break;
            case "top":
            default:
               $field._y = $field._y + 1;
         }
      }
   }
}
