package com.clubpenguin.world.command
{
   import com.clubpenguin.lib.module.IAppModel;
   import com.clubpenguin.lib.vo.UserSubmissionVO;
   import org.robotlegs.mvcs.SignalCommand;
   import com.clubpenguin.lib.services.socket.ConnectionConstants;
   import com.clubpenguin.lib.services.socket.IConnection;
   
   public class SendUserSubmissionCommand extends SignalCommand
   {
       
      
      [Inject]
      public var userSubmission:UserSubmissionVO;
      
      [Inject]
      public var mainModel:IAppModel;
      
      [Inject]
      public var connection:IConnection;
      
      public function SendUserSubmissionCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
        this.connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PLAYER, "submission", [this.userSubmission.submissionCategory, this.userSubmission.submissionText]);
      }
   }
}
