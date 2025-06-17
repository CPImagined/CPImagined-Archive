//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music
{
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import com.clubpenguin.music.events.MusicModuleEvent;

    public class TemporaryTriggers extends Sprite 
    {

        public function TemporaryTriggers()
        {
            this.addTempButtons();
        }

        private function addTempButtons():void
        {
            var up:Sprite;
            var over:Sprite;
            var down:Sprite;
            var hit:Sprite;
            var button:SimpleButton;
            var labels:Array = [0xFF0000, 0xFF00, 0xFF];
            var i:int;
            while (i < labels.length)
            {
                up = new Sprite();
                up.graphics.beginFill((labels[i] as uint));
                up.graphics.drawRoundRect(0, 300, 100, 30, 3, 3);
                up.graphics.endFill();
                over = new Sprite();
                over.graphics.beginFill((labels[i] as uint));
                over.graphics.drawRoundRect(0, 300, 100, 30, 3, 3);
                over.graphics.endFill();
                down = new Sprite();
                down.graphics.beginFill((labels[i] as uint));
                down.graphics.drawRoundRect(0, 300, 100, 30, 3, 3);
                down.graphics.endFill();
                hit = new Sprite();
                hit.graphics.beginFill((labels[i] as uint));
                hit.graphics.drawRoundRect(0, 300, 100, 30, 3, 3);
                hit.graphics.endFill();
                button = new SimpleButton(up, over, down, hit);
                addChild(button);
                button.x = (200 + (120 * i));
                button.y = 20;
                button.useHandCursor = true;
                button.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                i++;
            };
        }

        protected function onButtonClick(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            dispatchEvent(new MusicModuleEvent("TEMP_TRIGGER", getChildIndex((event.currentTarget as SimpleButton))));
        }


    }
}//package com.clubpenguin.music
