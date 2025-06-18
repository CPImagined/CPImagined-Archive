//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.signal
{
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.ErrorVO;

    public class LoadWebServiceFatalErrorSignal extends Signal 
    {

        public function LoadWebServiceFatalErrorSignal()
        {
            super(ErrorVO);
        }

    }
}//package com.clubpenguin.main.signal
