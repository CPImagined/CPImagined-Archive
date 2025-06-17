//Created by Action Script Viewer - https://www.buraks.com/asv
package secretOverlay_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var secretOverlay:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 339.85;
            this.visibleHeight = 411.55;
        }


    }
}//package secretOverlay_fla
    //force all classes
    import secretOverlay_fla.MainTimeline; secretOverlay_fla.MainTimeline;
    import secretOverlay_fla.ProtoBot_34; secretOverlay_fla.ProtoBot_34;
    import secretOverlay_fla.ProtobotThruster_16; secretOverlay_fla.ProtobotThruster_16;
    import secretOverlay_fla.Protobot_46; secretOverlay_fla.Protobot_46;
