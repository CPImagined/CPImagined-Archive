//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import flash.display.MovieClip;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class LocalTextFieldGroupCollection extends MovieClip 
    {

        private static const GROUP_LIST:String = "groupList";
        private static const GROUP_FONT_SIZE:String = "groupFontSize";

        private var groups:Dictionary = new Dictionary();
        private var localText:LocalText;

        public function LocalTextFieldGroupCollection(localText:LocalText)
        {
            this.localText = localText;
        }

        public function addLocalTextField(localTF:LocalTextField):void
        {
            if (!localTF.isInGroup)
            {
                return;
            };
            if (this.groups[localTF.absoluteGroupName] == undefined)
            {
                this.groups[localTF.absoluteGroupName] = new Object();
                this.groups[localTF.absoluteGroupName][GROUP_LIST] = new Vector.<LocalTextField>();
            };
            this.setGroupFontSize(localTF.absoluteGroupName, (localTF.textField.getTextFormat().size as Number));
            var groupList:Vector.<LocalTextField> = (this.groups[localTF.absoluteGroupName][GROUP_LIST] as Vector.<LocalTextField>);
            if (groupList.indexOf(localTF) == -1)
            {
                groupList.push(localTF);
            };
        }

        public function isLTFMemberOfRegisteredGroup(localTF:ILocalTextField):Boolean
        {
            return ((localTF.isInGroup) && (!(this.groups[localTF.absoluteGroupName] == null)));
        }

        public function getGroupFontSize(absoluteGroupName:String):Number
        {
            if (!this.groups[absoluteGroupName])
            {
                throw (new Error(("There is no group with absolute name: " + absoluteGroupName)));
            };
            return (this.groups[absoluteGroupName][GROUP_FONT_SIZE] as Number);
        }

        public function setGroupFontSize(absoluteGroupName:String, size:Number):void
        {
            if (((!(this.groups[absoluteGroupName][GROUP_FONT_SIZE])) || (size < (this.groups[absoluteGroupName][GROUP_FONT_SIZE] as Number))))
            {
                this.groups[absoluteGroupName][GROUP_FONT_SIZE] = size;
            };
        }

        public function getLocalTextFieldsInGroup(absoluteGroupName:String):Vector.<LocalTextField>
        {
            if (!this.groups[absoluteGroupName])
            {
                throw (new Error(("There is no group with absolute name: " + absoluteGroupName)));
            };
            return (this.groups[absoluteGroupName][GROUP_LIST] as Vector.<LocalTextField>);
        }


    }
}//package com.clubpenguin.tools.localtext.core
