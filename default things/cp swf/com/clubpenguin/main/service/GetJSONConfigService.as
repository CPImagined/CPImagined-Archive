//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service
{
    import com.clubpenguin.lib.services.http.HTTPServiceRequest;

    public class GetJSONConfigService extends HTTPServiceRequest 
    {

        private static const GET_JSON_CONFIG_URL:String = "../local_config/flashvars.json";

        public function GetJSONConfigService()
        {
            setURL(GET_JSON_CONFIG_URL, HTTPServiceRequest.JSON_ENCODING);
        }

    }
}//package com.clubpenguin.main.service
