package fl.managers
{
    import fl.core.*;
    import flash.text.*;
    import flash.utils.*;

    public class StyleManager extends Object
    {
        private var styleToClassesHash:Object;
        private var classToInstancesDict:Dictionary;
        private var classToStylesDict:Dictionary;
        private var classToDefaultStylesDict:Dictionary;
        private var globalStyles:Object;
        private static var _instance:StyleManager;

        public function StyleManager()
        {
            this.styleToClassesHash = {};
            this.classToInstancesDict = new Dictionary(true);
            this.classToStylesDict = new Dictionary(true);
            this.classToDefaultStylesDict = new Dictionary(true);
            this.globalStyles = UIComponent.getStyleDefinition();
            return;
        }// end function

        private static function getInstance()
        {
            if (_instance == null)
            {
                _instance = new StyleManager;
            }
            return _instance;
        }// end function

        public static function registerInstance(param1:UIComponent) : void
        {
            var target:Class;
            var defaultStyles:Object;
            var styleToClasses:Object;
            var n:String;
            var instance:* = param1;
            var inst:* = getInstance();
            var classDef:* = getClassDef(instance);
            if (classDef == null)
            {
                return;
            }
            if (inst.classToInstancesDict[classDef] == null)
            {
                inst.classToInstancesDict[classDef] = new Dictionary(true);
                target = classDef;
                while (defaultStyles == null)
                {
                    
                    if (target["getStyleDefinition"] != null)
                    {
                        var _loc_3:* = target;
                        defaultStyles = _loc_3["getStyleDefinition"]();
                        break;
                    }
                    try
                    {
                        target = instance.loaderInfo.applicationDomain.getDefinition(getQualifiedSuperclassName(target)) as Class;
                    }
                    catch (err:Error)
                    {
                        try
                        {
                            target = getDefinitionByName(getQualifiedSuperclassName(target)) as Class;
                        }
                        catch (e:Error)
                        {
                            defaultStyles = UIComponent.getStyleDefinition();
                            break;
                        }
                    }
                    styleToClasses = inst.styleToClassesHash;
                    var _loc_3:* = 0;
                    var _loc_4:* = defaultStyles;
                    while (_loc_4 in _loc_3)
                    {
                        
                        n = _loc_4[_loc_3];
                        if (styleToClasses[n] == null)
                        {
                            styleToClasses[n] = new Dictionary(true);
                        }
                        styleToClasses[n][classDef] = true;
                    }
                    inst.classToDefaultStylesDict[classDef] = defaultStyles;
                    if (inst.classToStylesDict[classDef] == null)
                    {
                        inst.classToStylesDict[classDef] = {};
                    }
                }
                inst.classToInstancesDict[classDef][instance] = true;
                setSharedStyles(instance);
                return;
        }// end function

        private static function setSharedStyles(param1:UIComponent) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = getInstance();
            var _loc_3:* = getClassDef(param1);
            var _loc_4:* = _loc_2.classToDefaultStylesDict[_loc_3];
            for (_loc_5 in _loc_4)
            {
                
                param1.setSharedStyle(_loc_5, getSharedStyle(param1, _loc_5));
            }
            return;
        }// end function

        private static function getSharedStyle(param1:UIComponent, param2:String) : Object
        {
            var _loc_3:* = getClassDef(param1);
            var _loc_4:* = getInstance();
            var _loc_5:* = _loc_4.classToStylesDict[_loc_3][param2];
            if (_loc_4.classToStylesDict[_loc_3][param2] != null)
            {
                return _loc_5;
            }
            _loc_5 = _loc_4.globalStyles[param2];
            if (_loc_5 != null)
            {
                return _loc_5;
            }
            return _loc_4.classToDefaultStylesDict[_loc_3][param2];
        }// end function

        public static function getComponentStyle(param1:Object, param2:String) : Object
        {
            var _loc_3:* = getClassDef(param1);
            var _loc_4:* = getInstance().classToStylesDict[_loc_3];
            return getInstance().classToStylesDict[_loc_3] == null ? (null) : (_loc_4[param2]);
        }// end function

        public static function clearComponentStyle(param1:Object, param2:String) : void
        {
            var _loc_3:* = getClassDef(param1);
            var _loc_4:* = getInstance().classToStylesDict[_loc_3];
            if (getInstance().classToStylesDict[_loc_3] != null && _loc_4[param2] != null)
            {
                delete _loc_4[param2];
                invalidateComponentStyle(_loc_3, param2);
            }
            return;
        }// end function

        public static function setComponentStyle(param1:Object, param2:String, param3:Object) : void
        {
            var _loc_4:* = getClassDef(param1);
            var _loc_5:* = getInstance().classToStylesDict[_loc_4];
            if (getInstance().classToStylesDict[_loc_4] == null)
            {
                var _loc_6:* = {};
                getInstance().classToStylesDict[_loc_4] = {};
                _loc_5 = _loc_6;
            }
            if (_loc_5 == param3)
            {
                return;
            }
            _loc_5[param2] = param3;
            invalidateComponentStyle(_loc_4, param2);
            return;
        }// end function

        private static function getClassDef(param1:Object) : Class
        {
            var component:* = param1;
            if (component is Class)
            {
                return component as Class;
            }
            try
            {
                return getDefinitionByName(getQualifiedClassName(component)) as Class;
            }
            catch (e:Error)
            {
                if (component is UIComponent)
                {
                    try
                    {
                        return component.loaderInfo.applicationDomain.getDefinition(getQualifiedClassName(component)) as Class;
                    }
                    catch (e:Error)
                    {
                    }
                }
                return null;
        }// end function

        private static function invalidateStyle(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = getInstance().styleToClassesHash[param1];
            if (_loc_2 == null)
            {
                return;
            }
            for (_loc_3 in _loc_2)
            {
                
                invalidateComponentStyle(Class(_loc_3), param1);
            }
            return;
        }// end function

        private static function invalidateComponentStyle(param1:Class, param2:String) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = getInstance().classToInstancesDict[param1];
            if (_loc_3 == null)
            {
                return;
            }
            for (_loc_4 in _loc_3)
            {
                
                _loc_5 = _loc_4 as UIComponent;
                if (_loc_5 == null)
                {
                    continue;
                }
                _loc_5.setSharedStyle(param2, getSharedStyle(_loc_5, param2));
            }
            return;
        }// end function

        public static function setStyle(param1:String, param2:Object) : void
        {
            var _loc_3:* = getInstance().globalStyles;
            if (_loc_3[param1] === param2 && !(param2 is TextFormat))
            {
                return;
            }
            _loc_3[param1] = param2;
            invalidateStyle(param1);
            return;
        }// end function

        public static function clearStyle(param1:String) : void
        {
            setStyle(param1, null);
            return;
        }// end function

        public static function getStyle(param1:String) : Object
        {
            return getInstance().globalStyles[param1];
        }// end function

    }
}
