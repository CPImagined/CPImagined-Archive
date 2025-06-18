dynamic class com.clubpenguin.model.vo.MyPlayerVO extends com.clubpenguin.model.vo.PlayerVO
{
    var getBackyardPuffleCount: Boolean = true;
    var getIglooPuffleCount: Boolean = true;
    var currencies;

    function MyPlayerVO()
    {
        super();
        this.currencies = new Object();
    }

    function destroy()
    {
    }

}
