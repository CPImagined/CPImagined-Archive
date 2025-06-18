//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.controller.localization
{
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.display.DisplayObject;

    public class LocalTextComponentReplacer implements ILocaleTextReplacer 
    {


        public function replaceText(textDO:DisplayObject, newText:String):void
        {
            var ltf:ILocalTextField = (textDO as ILocalTextComponent).localTextField;
            LocalTextProxy.localText.setText(ltf, newText);
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.controller.localization
