//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.vo
{
    import com.clubpenguin.main.overlays.type.OverlayType;

    public class MembershipFAQOverlayVO extends OverlayVO 
    {

        public static const MEMBERSHIP_FAQ_OVERLAY_ID:String = "membershipFAQOverlayID";

        public function MembershipFAQOverlayVO()
        {
            this.id = MEMBERSHIP_FAQ_OVERLAY_ID;
            this.type = OverlayType.DISPLAY;
            this.modalBackgroundEnabled = false;
            this.isAbsoluteURL = true;
        }

    }
}//package com.clubpenguin.main.overlays.vo
