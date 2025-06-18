//Created by Action Script Viewer - https://www.buraks.com/asv
package 
{
    import com.clubpenguin.CPHostEmulator;

    public class HostEmulator extends CPHostEmulator 
    {


        override protected function getHostGameName():String
        {
            return ("ScornBattle.swf");
        }


    }
}//package 
    //force all classes
    import com.disney.coupler.ICouplerHost; com.disney.coupler.ICouplerHost;
    import com.clubpenguin.lib.vo.MPGameVO; com.clubpenguin.lib.vo.MPGameVO;
    import com.clubpenguin.lib.vo.IPlayerVO; com.clubpenguin.lib.vo.IPlayerVO;
    import com.clubpenguin.lib.vo.IEndGameVO; com.clubpenguin.lib.vo.IEndGameVO;
    import com.disney.coupler.ICouplerGame; com.disney.coupler.ICouplerGame;
    import org.osflash.signals.IDispatcher; org.osflash.signals.IDispatcher;
    import org.osflash.signals.ISignal; org.osflash.signals.ISignal;
    import com.clubpenguin.lib.util.collection.ICollection; com.clubpenguin.lib.util.collection.ICollection;
    import com.clubpenguin.lib.vo.IVO; com.clubpenguin.lib.vo.IVO;
    import com.clubpenguin.game.ICPHost; com.clubpenguin.game.ICPHost;
    import org.osflash.signals.Signal; org.osflash.signals.Signal;
    import com.clubpenguin.CPHostEmulator; com.clubpenguin.CPHostEmulator;
    import HostEmulator; HostEmulator;
