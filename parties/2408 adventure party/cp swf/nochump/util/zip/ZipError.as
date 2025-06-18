//Created by Action Script Viewer - https://www.buraks.com/asv
package nochump.util.zip
{
    import flash.errors.IOError;

    public class ZipError extends IOError 
    {

        public function ZipError(message:String="", id:int=0)
        {
            super(message, id);
        }

    }
}//package nochump.util.zip
