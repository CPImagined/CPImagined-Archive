//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.vo
{
    import com.clubpenguin.main.overlays.type.OverlayType;

    public class MembershipOverlayVO extends OverlayVO 
    {

        public static const MEMBERSHIP_OVERLAY_ID:String = "membershipOverlayID";

        public function MembershipOverlayVO()
        {
            this.id = MEMBERSHIP_OVERLAY_ID;
            this.type = OverlayType.DISPLAY;
            this.modalBackgroundEnabled = false;
            this.isAbsoluteURL = true;
        }

    }
}//package com.clubpenguin.main.overlays.vo
