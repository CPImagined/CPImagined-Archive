class com.disney.dlearning.games.aqua.DLearning
{
   var __stampOpcodes;
   var __firedStampOpcodes;
   var __coins;
   var __smallItemsCollected;
   var __previouslyReportedCoins;
   var __currentChallenge;
   var __currentLevel;
   static var __instance;
   static var AQUAGRABBER_START_STOP = "5CD48A05-FF10-C934-0991-2FF9719956D2";
   static var AQUAGRABBER_CLAM_WATERS = "B5BF0A87-CD09-2498-B01F-C778A513684F";
   static var AQUAGRABBER_SODA_SEAS = "4FD21346-EDF3-F813-F213-8FF049563DE9";
   static var AQUAGRABBER_CLAM_WATERS_FIND_THE_MAIN_TREASURE_BUT_DIDNT_GET_TO_NET = "9DE68225-83F4-7F07-885A-1404AB942117";
   static var AQUAGRABBER_CLAM_WATERS_FIND_THE_RARE_TREASURE_BUT_DIDNT_GET_TO_NET = "BA07C05D-D7F6-5DCB-F3E9-5FFDE200CE2B";
   static var AQUAGRABBER_CLAM_WATERS_TIME_TRIAL_NOT_IN_TIME = "A917DB0E-4450-109D-9F9E-79B367C8A7B1";
   static var AQUAGRABBER_CLAM_WATERS_COMPRESSED_AIR_MODE_DIDNT_FINISH = "F1B2F198-7069-2A72-4B93-A1EF2F270083";
   static var AQUAGRABBER_SODA_SEAS_FIND_THE_MAIN_TREASURE_BUT_DIDNT_GET_TO_NET = "961B8A76-CB81-6B11-6D77-7B2816198B88";
   static var AQUAGRABBER_SODA_SEAS_FIND_THE_RARE_TREASURE_BUT_DIDNT_GET_TO_NET = "B9921038-36F4-7B91-5AC4-EB12F4AF8194";
   static var AQUAGRABBER_SODA_SEAS_TIME_TRIAL_NOT_IN_TIME = "EC4C28F4-E4A3-B6A8-8C06-7A3009701AE4";
   static var AQUAGRABBER_SODA_SEAS_COMPRESSED_AIR_MODE_DIDNT_FINISH = "AF33072C-2897-2503-11F7-B8698739340C";
   static var AQUAGRABBER_OOPS_MESSAGE = "25E462EA-3D2C-7A22-EF16-595DD6F07EEC";
   static var AQUAGRABBER_CLAM_WATERS_LOSE_GAME_BY_DYING = "2FE6343A-07C3-89AF-AC57-B648B08A56AD";
   static var AQUAGRABBER_SODA_SEAS_LOSE_GAME_BY_DYING = "39D4A24D-311C-C945-9B4D-82610604";
   static var AQUAGRABBER_INSTRUCTIONS = "96E47C13-8F39-CB13-2D41-FB163D40D9D0";
   function DLearning()
   {
      this.__stampOpcodes = new Array();
      this.__firedStampOpcodes = new Array();
      this.__coins = 0;
      this.__smallItemsCollected = 0;
      this.__previouslyReportedCoins = 0;
      this.__currentChallenge = "";
      this.__currentLevel = "";
   }
   function openedInstructions()
   {
      trace("DL:Opened Instructions");
      this.pushSelectedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_INSTRUCTIONS);
   }
   function startedChallenge(challenge)
   {
      this.__currentChallenge = challenge;
   }
   function updateCoins(coins)
   {
      trace("DL:Updated Coins: " + this.__coins);
      this.__coins = coins;
   }
   function pickedUpSmallItem(appraiseValue)
   {
      trace("DL:Picked Up Small Item, Worth: " + appraiseValue);
      this.__smallItemsCollected = this.__smallItemsCollected + 1;
   }
   function pickedUpPart(partNumber)
   {
      trace("DL:Picked Up Part: " + partNumber);
      if(partNumber == 1 && this.__currentLevel == "SodaSeas")
      {
         this.__smallItemsCollected = this.__smallItemsCollected + 1;
      }
   }
   function closedLevel()
   {
      trace("DL:Closed Level!");
      if(this.__currentChallenge == "COMPRESSED_AIR")
      {
         if(this.__currentLevel == "ClamWaters")
         {
            this.pushPresentedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS_COMPRESSED_AIR_MODE_DIDNT_FINISH);
         }
         else
         {
            this.pushPresentedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS_COMPRESSED_AIR_MODE_DIDNT_FINISH);
         }
      }
      if(this.__currentLevel == "ClamWaters")
      {
         this.pushGamescoreOpcodeParams(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS,"" + this.__smallItemsCollected,"QUIT",String(this.__coins - this.__previouslyReportedCoins));
      }
      else
      {
         this.pushGamescoreOpcodeParams(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS,"" + this.__smallItemsCollected,"QUIT",String(this.__coins - this.__previouslyReportedCoins));
      }
      this.__previouslyReportedCoins = this.__coins;
      this.gameOver();
   }
   function loseGame()
   {
      trace("DL:Lose Game");
      if(this.__currentChallenge == "COMPRESSED_AIR")
      {
         if(this.__currentLevel == "ClamWaters")
         {
            this.pushPresentedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS_COMPRESSED_AIR_MODE_DIDNT_FINISH);
         }
         else
         {
            this.pushPresentedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS_COMPRESSED_AIR_MODE_DIDNT_FINISH);
         }
      }
      if(this.__currentLevel == "ClamWaters")
      {
         this.pushPresentedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS_LOSE_GAME_BY_DYING);
      }
      else
      {
         this.pushPresentedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS_LOSE_GAME_BY_DYING);
      }
      if(this.__currentLevel == "ClamWaters")
      {
         this.pushGamescoreOpcodeParams(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS,"" + this.__smallItemsCollected,"LOSE",String(this.__coins - this.__previouslyReportedCoins));
      }
      else
      {
         this.pushGamescoreOpcodeParams(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS,"" + this.__smallItemsCollected,"LOSE",String(this.__coins - this.__previouslyReportedCoins));
      }
      this.__previouslyReportedCoins = this.__coins;
      this.gameOver();
   }
   function winGame()
   {
      trace("DL:Win Game");
      if(this.__currentLevel == "ClamWaters")
      {
         this.pushGamescoreOpcodeParams(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS,"" + this.__smallItemsCollected,"WIN",String(this.__coins - this.__previouslyReportedCoins));
      }
      else
      {
         this.pushGamescoreOpcodeParams(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS,"" + this.__smallItemsCollected,"WIN",String(this.__coins - this.__previouslyReportedCoins));
      }
      this.__previouslyReportedCoins = this.__coins;
      this.gameOver();
   }
   function gameOver()
   {
      com.disney.dlearning.games.aqua.DLearning.instance.pushStopOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_START_STOP);
      if(this.__currentLevel == "ClamWaters")
      {
         this.pushStopOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS);
      }
      else
      {
         this.pushStopOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS);
      }
      this.__smallItemsCollected = 0;
      this.__currentLevel = "";
      this.__currentChallenge = "";
   }
   function timeExpired()
   {
      trace("Time Expired!");
      if(this.__currentLevel == "ClamWaters")
      {
         this.pushPresentedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS_TIME_TRIAL_NOT_IN_TIME);
      }
      else
      {
         this.pushPresentedOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS_TIME_TRIAL_NOT_IN_TIME);
      }
   }
   function startedClamWaters()
   {
      this.__currentLevel = "ClamWaters";
      com.disney.dlearning.games.aqua.DLearning.instance.pushStartOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_START_STOP);
      com.disney.dlearning.games.aqua.DLearning.instance.pushStartOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_CLAM_WATERS);
   }
   function startedSodaSeas()
   {
      this.__currentLevel = "SodaSeas";
      com.disney.dlearning.games.aqua.DLearning.instance.pushStartOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_START_STOP);
      com.disney.dlearning.games.aqua.DLearning.instance.pushStartOpcode(com.disney.dlearning.games.aqua.DLearning.AQUAGRABBER_SODA_SEAS);
   }
   function init(learnerId)
   {
      trace("initializing DLearning");
      com.disney.dlearning.managers.DLSManager.init(learnerId,"aquagrabber.k.api.dlsnetwork.com");
      this.populateStampOpcodes();
   }
   function populateStampOpcodes()
   {
      this.__stampOpcodes[72] = "C2055C01-612D-9CB2-2E18-6F0988CA4900";
      this.__stampOpcodes[73] = "6E7A2235-6B9F-4A44-6984-2481141EE7BF";
      this.__stampOpcodes[74] = "70DD4BC4-7C54-8C89-49E0-9A0C64702DA7";
      this.__stampOpcodes[75] = "E3F567B6-0679-7D5F-FA36-9FD01DC6E9A6";
      this.__stampOpcodes[76] = "FE060F7E-AE53-F2C9-2409-5A8A9260D350";
      this.__stampOpcodes[77] = "671F39FD-1A22-3A1B-8E87-564AE1AD13D6";
      this.__stampOpcodes[78] = "F91E7CF6-789F-9C8B-3E00-E668AB5019A5";
      this.__stampOpcodes[79] = "1EF75292-4740-390F-6B0E-3351D3473D91";
      this.__stampOpcodes[80] = "A37FA92E-2E41-6677-3B0C-70489DC51B29";
      this.__stampOpcodes[81] = "06955ECC-169A-70C0-1234-D5D08AB957F6";
      this.__stampOpcodes[82] = "CB8475F2-7ADF-A10F-0986-435348CB21AC";
      this.__stampOpcodes[83] = "548D2A09-5D3F-E796-8EB7-33CB0B247922";
      this.__stampOpcodes[84] = "C9F3757C-FE22-8A2B-D907-2D05C0F60C52";
      this.__stampOpcodes[85] = "EB899E63-369B-B4D2-0EFE-E87C115315F8";
      this.__stampOpcodes[86] = "EFC8DC36-08F0-06E1-A1CD-E26441010199";
      this.__stampOpcodes[87] = "13E9E3B0-F048-7145-7F24-5484C33D5A0F";
      this.__stampOpcodes[88] = "115E1ABF-2EB1-B59A-2F88-C073C4625260";
      this.__stampOpcodes[89] = "6B56C2BA-93A0-4B83-7147-746DBD6399E5";
      this.__stampOpcodes[90] = "C491D3C9-89C0-692A-4A2F-6A672D1677A6";
      this.__stampOpcodes[91] = "4744DFC0-7C0D-678D-273E-9576156D7603";
      this.__stampOpcodes[92] = "204F7E5E-9D61-D6EA-5354-C9B4D67D9A44";
      this.__firedStampOpcodes[72] = false;
      this.__firedStampOpcodes[73] = false;
      this.__firedStampOpcodes[74] = false;
      this.__firedStampOpcodes[75] = false;
      this.__firedStampOpcodes[76] = false;
      this.__firedStampOpcodes[77] = false;
      this.__firedStampOpcodes[78] = false;
      this.__firedStampOpcodes[79] = false;
      this.__firedStampOpcodes[80] = false;
      this.__firedStampOpcodes[81] = false;
      this.__firedStampOpcodes[82] = false;
      this.__firedStampOpcodes[83] = false;
      this.__firedStampOpcodes[84] = false;
      this.__firedStampOpcodes[85] = false;
      this.__firedStampOpcodes[86] = false;
      this.__firedStampOpcodes[87] = false;
      this.__firedStampOpcodes[88] = false;
      this.__firedStampOpcodes[89] = false;
      this.__firedStampOpcodes[90] = false;
      this.__firedStampOpcodes[91] = false;
      this.__firedStampOpcodes[92] = false;
   }
   function pushStamp(stampID)
   {
      trace("DL:Checking Stamp");
      if(this.__firedStampOpcodes[stampID] == false)
      {
         trace("Firing stamp: " + stampID + "with Opcode: " + this.__stampOpcodes[stampID]);
         com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED",this.__stampOpcodes[stampID],this.dlsmCallback,"0","0","0");
         this.__firedStampOpcodes[stampID] = true;
      }
      else
      {
         trace("Already fired stamp: " + stampID);
      }
   }
   function pushPresentedOpcode(opcode)
   {
      trace("pushPresentedOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("PRESENTED",opcode,this.dlsmCallback,"0","0","0");
   }
   function pushSelectedOpcode(opcode)
   {
      trace("pushSelectedOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED",opcode,this.dlsmCallback,"0","0","0");
   }
   function pushStartOpcode(opcode)
   {
      trace("pushStartOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("START",opcode,this.dlsmCallback,"0","0","0");
   }
   function pushStopOpcode(opcode)
   {
      trace("pushStopOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("STOP",opcode,this.dlsmCallback,"0","0","0");
   }
   function pushPresentedOpcodeParams(opcode, param0, param1, param2)
   {
      trace("pushPresentedOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("PRESENTED",opcode,this.dlsmCallback,param0,param1,param2);
   }
   function pushSelectedOpcodeParams(opcode, param0, param1, param2)
   {
      trace("pushSelectedOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED",opcode,this.dlsmCallback,param0,param1,param2);
   }
   function pushStartOpcodeParams(opcode, param0, param1, param2)
   {
      trace("pushStartOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("START",opcode,this.dlsmCallback,param0,param1,param2);
   }
   function pushStopOpcodeParams(opcode, param0, param1, param2)
   {
      trace("pushStopOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("STOP",opcode,this.dlsmCallback,param0,param1,param2);
   }
   function pushGamescoreOpcodeParams(opcode, param0, param1, param2)
   {
      trace("pushGamescoreOpcode");
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("GAMESCORE",opcode,this.dlsmCallback,param0,param1,param2);
   }
   function dlsmCallback(retString)
   {
      trace("DLSCallback : " + retString);
   }
   static function get instance()
   {
      if(com.disney.dlearning.games.aqua.DLearning.__instance == null)
      {
         com.disney.dlearning.games.aqua.DLearning.__instance = new com.disney.dlearning.games.aqua.DLearning();
      }
      return com.disney.dlearning.games.aqua.DLearning.__instance;
   }
}
