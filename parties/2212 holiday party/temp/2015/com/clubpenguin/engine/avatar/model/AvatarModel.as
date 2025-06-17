class com.clubpenguin.engine.avatar.model.AvatarModel
{
   function AvatarModel()
   {
      this._SHELL = _global.getCurrentShell();
      this._avatarData = {};
      this._snowballHitChecks = {};
   }
   function setSnowballHitCheck(avatarEnum, snowballHitCheck)
   {
      this._snowballHitChecks[avatarEnum.__get__symbolName()] = snowballHitCheck;
   }
   function getSnowballHitCheck(avatarEnum)
   {
      return this._snowballHitChecks[avatarEnum.__get__symbolName()];
   }
   function setAvatarTemplate(avatarId, data)
   {
      data.avatar_id = avatarId;
      this._avatarData[avatarId] = data;
   }
   function getAvatarTemplate(avatarId)
   {
      return this._avatarData[avatarId];
   }
   function createAvatarFromTemplate(avatarId)
   {
      if(this._avatarData[avatarId] != null)
      {
         return this._avatarData[avatarId].clone();
      }
      return this._avatarData[com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID].clone();
   }
}
