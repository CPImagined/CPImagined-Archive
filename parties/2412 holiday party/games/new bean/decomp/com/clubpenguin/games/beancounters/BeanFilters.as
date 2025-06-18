//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.BeanFilters
    {
        static var __instance;
        var filter_glow;
        function BeanFilters () {
            __instance = this;
            filter_glow = new flash.filters.GlowFilter(__glow_color, __glow_alpha, __glow_blurX, __glow_blurY, __glow_strength, __glow_quality, __glow_inner, __glow_knockout);
        }
        static function get getInstance() {
            if (__instance == undefined) {
                __instance = new com.clubpenguin.games.beancounters.BeanFilters();
            }
            return(__instance);
        }
        var __glow_color = 65535;
        var __glow_alpha = 0.8;
        var __glow_blurX = 25;
        var __glow_blurY = 25;
        var __glow_strength = 5;
        var __glow_quality = 5;
        var __glow_inner = false;
        var __glow_knockout = false;
        var __shadow_distance = 10;
        var __shadow_angleInDegrees = 45;
        var __shadow_color = 0;
        var __shadow_alpha = 0.8;
        var __shadow_blurX = 16;
        var __shadow_blurY = 16;
        var __shadow_strength = 1;
        var __shadow_quality = 3;
        var __shadow_inner = false;
        var __shadow_knockout = false;
        var __shadow_hideObject = false;
        var __blur_blurX = 10;
        var __blur_blurY = 10;
        var __blur_quality = 3;
        var __bevel_distance = 5;
        var __bevel_angleInDegrees = 45;
        var __bevel_highlightColor = 16448210;
        var __bevel_highlightAlpha = 0.5;
        var __bevel_shadowColor = 0;
        var __bevel_shadowAlpha = 0.8;
        var __bevel_blurX = 5;
        var __bevel_blurY = 5;
        var __bevel_strength = 5;
        var __bevel_quality = 3;
        var __bevel_type = "inner";
        var __bevel_knockout = false;
    }
