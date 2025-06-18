dynamic class com.clubpenguin.world.rooms.common.triggers.GridTile extends flash.geom.Rectangle
{
    var _triggers;
    var bottom;
    var height;
    var left;
    var right;
    var top;
    var width;
    var x;
    var y;

    function GridTile(x, y, w, h)
    {
        super(x, y, w, h);
        this._triggers = [];
    }

    function addTrigger(triggerToAdd)
    {
        this._triggers.push(triggerToAdd);
    }

    function hitTest(object, mc)
    {
        var __reg2 = this._triggers.length - 1;
        for (;;) 
        {
            if (__reg2 < 0) 
            {
                return;
            }
            this._triggers[__reg2].hitTest(object, mc);
            --__reg2;
        }
    }

    function reset()
    {
        this._triggers = [];
    }

    function isEmpty()
    {
        return this._triggers.length <= 0;
    }

    function drawRed(mc)
    {
        mc.lineStyle(1, 0, 10);
        mc.beginFill(16711680, 20);
        mc.moveTo(this.left, this.top);
        mc.lineTo(this.right, this.top);
        mc.lineTo(this.right, this.bottom);
        mc.lineTo(this.left, this.bottom);
        mc.lineTo(this.left, this.top);
        mc.endFill();
    }

    function draw(mc)
    {
        mc.lineStyle(1, 0, 10);
        mc.beginFill(65280, 20);
        mc.moveTo(this.left, this.top);
        mc.lineTo(this.right, this.top);
        mc.lineTo(this.right, this.bottom);
        mc.lineTo(this.left, this.bottom);
        mc.lineTo(this.left, this.top);
        mc.endFill();
    }

    function toString()
    {
        return this.x + ":" + this.y + ":" + this.width + ":" + this.height;
    }

}
