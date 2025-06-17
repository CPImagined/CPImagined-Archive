class com.clubpenguin.services.vo.ServerCookieVO implements com.clubpenguin.util.ISerializable, com.clubpenguin.util.IVO
{
   function ServerCookieVO(cookieId)
   {
      this._cookieId = cookieId;
   }
   function destroy()
   {
   }
   function getID()
   {
      return this._cookieId;
   }
   function getCookieHandlerName()
   {
      return null;
   }
   function getSendCommandName()
   {
      return null;
   }
   function getReceiveCommandName()
   {
      return null;
   }
   function update(vo)
   {
   }
   function requestFromServer()
   {
      _global.getCurrentShell().getServerCookieService().requestCookieFromServer(this.getID());
   }
   function sendToServer()
   {
      _global.getCurrentShell().getServerCookieService().sendCookieToServer(this.getID());
   }
   function toString()
   {
      return "[ServerCookieVO:id=" + this.getID() + "]";
   }
   function equals(vo)
   {
      return this._cookieId == vo.getID();
   }
   function serialize()
   {
      return null;
   }
   function deserialize(data)
   {
   }
}
