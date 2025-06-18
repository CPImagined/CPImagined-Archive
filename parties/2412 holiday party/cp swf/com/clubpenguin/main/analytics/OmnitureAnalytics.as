//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.analytics
{
    import com.clubpenguin.main.model.MainModel;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;

    public class OmnitureAnalytics extends BaseAnalytics 
    {

        [Inject]
        public var mainModel:MainModel;

        public function OmnitureAnalytics()
        {
            super(new AnalyticsContext());
        }

        override protected function logItem(itemName:String, data:Array=null):Boolean
        {
            var membershipType:Number = Number(this.mainModel.isMember());
            if (isNaN(membershipType))
            {
                membershipType = -1;
            };
            var omnitureScript:String = this.buildOmnitureScript(itemName, String(membershipType));
            navigateToURL(new URLRequest(omnitureScript), "_self");
            return (true);
        }

        private function buildOmnitureScript(itemName:String, membershipType:String):String
        {
            var crumb:String = "javascript:cto=new CTO();";
            crumb = (crumb + 'cto.account="clubpenguin";');
            crumb = (crumb + 'cto.category="dgame";');
            crumb = (crumb + 'cto.site="clp";');
            crumb = (crumb + 'cto.siteSection="play";');
            crumb = (crumb + (((('cto.pageName="' + itemName) + "_") + this.mainModel.getLanguage()) + '";'));
            crumb = (crumb + 'cto.contentType="activities";');
            crumb = (crumb + 'cto.property="clp";');
            crumb = (crumb + (('cto.membershipType="' + membershipType) + '";'));
            crumb = (crumb + "cto.track();");
            return (crumb);
        }

        override public function toString():String
        {
            return ("[OmnitureAnalytics]");
        }


    }
}//package com.clubpenguin.main.analytics
