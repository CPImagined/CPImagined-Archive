0. Enable CORS. Flash didn't care, but Ruffle does.

add this to both main locations under the index line.
`templates\sites\vanilla.conf.template`
```
add_header Access-Control-Allow-Origin *;
```

1. Clone [websockify](https://github.com/novnc/websockify.git) inside wand
2. Change directory into `websockify` and run `python .\setup.py sdist --dist-dir docker/` to prepare the package
3. Change directory back to wand root
4. Add the following to the scripts:

NOTE: Ports are currently hardcoded. The examples given are based on the current `servers.xml` that I grabbed while writing.

Add to `templates/websockify/token`
```
login: login:6112
blizzard: blizzard:9875
glaciar: glaciar:9876
avalanche: avalanche:9877
yeti: yeti:9878
snow: snow:7002
```

Add to docker compose
```yaml
websockify:
  build: ./websockify/docker
  restart: always
  env_file:
    - .env
  networks:
    - wand
  ports:
    - ${WEBSOCKIFY_PORT}:${WEBSOCKIFY_PORT}
  volumes:
    - ./templates/websockify:/data
  depends_on:
    - houdini_login
    - houdini_blizzard
    - houdini_glaciar
    - houdini_avalanche
    - houdini_yeti
    - snowflake
  links:
    - houdini_login:login
    - houdini_blizzard:blizzard
    - houdini_glaciar:glaciar
    - houdini_avalanche:avalanche
    - houdini_yeti:yeti
    - snowflake:snow
  command: ["--token-plugin", "ReadOnlyTokenFile", "--token-source", "/data/token", "${WEBSOCKIFY_PORT}"]
```

Add to script tag in html.
```js
window.RufflePlayer = window.RufflePlayer || {};
window.RufflePlayer.config = window.RufflePlayer.config || {};

window.RufflePlayer.config.socketProxy = [
  {
    host: "server.cpimagined.net",
    port: 6112,
    proxyUrl: "ws://server.cpimagined.net:7001/?token=login",
  },
  {
    host: "server.cpimagined.net",
    port: 9875,
    proxyUrl: "ws://server.cpimagined.net:7001/?token=blizzard",
  },
  {
    host: "server.cpimagined.net",
    port: 9876,
    proxyUrl: "ws://server.cpimagined.net:7001/?token=glaciar",
  },
  {
    host: "server.cpimagined.net",
    port: 9877,
    proxyUrl: "ws://server.cpimagined.net:7001/?token=avalanche",
  },
  {
    host: "server.cpimagined.net",
    port: 9878,
    proxyUrl: "ws://server.cpimagined.net:7001/?token=yeti",
  },
  {
    host: "server.cpimagined.net",
    port: 7002,
    proxyUrl: "ws://server.cpimagined.net:7001/?token=snow",
  },
];

window.RufflePlayer.config.maxExecutionDuration = 120;

window.RufflePlayer.config.fontSources = ["http://media.cpimagined.net/play/v2/client/fonts/en/FontLibrary.swf"]
```

Add to `snowball_errors` in html. You can modify the image or the text (you should already know how to do that). 
```js
"ruffle":{"code":"ruffle","header":"Ruffle detected!","headerTag":"<h1>","message":"<span>We detect that you are using Ruffle. Some features like Card-Jitsu Snow will be unavailable</span><span>For the best experience, we recommend using a browser with Flash</span><span>Click the button below to continue. The game may take a while to load.</span>","messageTag":"<div>","links":[{"label":"/sites/play.clubpenguin.com/themes/snowball/img/en/ignore-button.png","href":"/#/login","id":"ignore-button","type":"img"}]},
```

The following 2 JS snippets are for `media/play/sites/default/files/js/js_HbFTUN2pKM9AIYs88RAyetbRRbaBp_PaIXfgtECrvTU.js`

Add to JavaScript in `launchMPGame`
```js
// START OF WAND RUFFLE CODE
if (gameDetails == null || (typeof gameDetails === "string" && gameDetails.trim() == "")) {
    // Kick the client back to the game if the launch params are wrong.
    returnToClubPenguin();
    return;
}
// END OF WAND RUFFLE CODE
```

Add to JavaScript in `CP.FlashClient.validateFlashVersion`
```js
// START OF WAND RUFFLE CODE
let WR_flashPlugin = navigator.plugins["Shockwave Flash"];
if (WR_flashPlugin && WR_flashPlugin.filename == "ruffle.js") {
    console.log("Ruffle detected - showing warning screen.");
    result.addError(Drupal.settings.snowball_errors.ruffle);
    return result;
}
// END OF WAND RUFFLE CODE
```

Add to env
```ini
##############################################
# Websockify
##############################################
WEBSOCKIFY_PORT=7001
```

5. (optional) Add Ruffle itself to the html. ENSURE THIS IS UNDER THE RUFFLE CONFIG OTHERWISE THERE MIGHT BE ISSUES!
(note: Ruffle is smart enough to not load when Flash is present, meaning it's safe to do this)
```html
<script src="https://unpkg.com/@ruffle-rs/ruffle"></script>
```

6. (optional) To remove the Ruffle splash, add this to the config script:
```js
window.RufflePlayer.config.splashScreen = false;
```

7. `docker compose up -d`

KNOWN ISSUES FOR USERS, AND OUR SOLUTIONS
- Onboarding font is broken
  - `FontLibrary.swf` declares font names with underscores prefixed, which messes up Ruffle. One option might be to make our own FontLibrary.
- CJ Snow doesn't work
  - Not something we can fix right now, so until we figure out what's wrong, we just kick them back out when they try to join.
- Game runs slow
  - Tell them to make sure hardware acceleration is enabled. On devices with multiple GPUs, set the browser to use the the powerful GPU.
- Audio doesn't play in background
  - Nothing we can do right now.