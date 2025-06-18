dynamic class com.clubpenguin.world.rooms.common.PopupContentVO
{
    var button;
    var condition;
    var content;
    var data;
    var elseContent;

    function PopupContentVO(button, condition, content, elseContent, data)
    {
        this.button = button;
        this.condition = condition;
        this.content = content;
        this.elseContent = elseContent;
        this.data = data;
    }

}
