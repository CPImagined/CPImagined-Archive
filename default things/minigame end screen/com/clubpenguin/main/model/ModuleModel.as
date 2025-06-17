//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model
{
    import org.robotlegs.mvcs.Actor;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;

    public class ModuleModel extends Actor 
    {

        private var _openModules:Dictionary;

        public function ModuleModel()
        {
            this._openModules = new Dictionary(true);
        }

        public function addModuleWithKey(module:BaseModule, key:ModuleFilenamesEnum):void
        {
            this._openModules[key] = module;
        }

        public function getModuleWithKey(key:ModuleFilenamesEnum):BaseModule
        {
            return (this._openModules[key]);
        }

        public function removeModule(module:BaseModule):void
        {
            var key:Object;
            for (key in this._openModules)
            {
                if (this._openModules[key] == module)
                {
                    this._openModules[key] = null;
                };
            };
        }

        public function isModuleOpen(key:ModuleFilenamesEnum):Boolean
        {
            return (!(this.getModuleWithKey(key) == null));
        }


    }
}//package com.clubpenguin.main.model
