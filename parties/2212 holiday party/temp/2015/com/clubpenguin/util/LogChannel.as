class com.clubpenguin.util.LogChannel
{
   static var _numMasks = 0;
   var _name = "";
   var _bitMask = 0;
   function LogChannel(name)
   {
      this._name = name;
      this._bitMask = 1 << com.clubpenguin.util.LogChannel._numMasks;
      com.clubpenguin.util.LogChannel._numMasks++;
      com.clubpenguin.util.Log.ALL._bitMask += this.bitMask;
   }
   function get name()
   {
      return this._name;
   }
   function get bitMask()
   {
      return this._bitMask;
   }
}
