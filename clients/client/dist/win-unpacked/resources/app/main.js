const {app, BrowserWindow, dialog} = require('electron');
const isDev = require('electron-is-dev');
const { autoUpdater } = require("electron-updater");
const RPC = require('discord-rpc');
const rpc = new RPC.Client({
    transport: "ipc" // don't know what this does, I just read documentation
});

//const {app, BrowserWindow} = require('electron');
const path = require('path');

let pluginName
switch (process.platform) {
  case 'win32':
    pluginName = 'flash/pepflashplayer64_32_0_0_303.dll'
    break
  case 'darwin':
    pluginName = 'flash/PepperFlashPlayer.plugin'
    break
  case 'linux':
    pluginName = 'flash/libpepflashplayer.so'
    break
}
app.commandLine.appendSwitch('ppapi-flash-path', path.join(__dirname, pluginName));

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
autoUpdater.checkForUpdatesAndNotify();
let mainWindow;

function clearCache() {
  mainWindow.webContents.session.clearCache();
}

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 1280,
    height: 720,
    title: "Connecting...",
    icon: __dirname + '/icon.png',
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      plugins: true
    }
  });

  mainWindow.setMenu(null);
  clearCache();
  mainWindow.loadURL('https://play.cpimagined.net/');

  // RICH PRESENCE START
rpc.on("ready", () => {
    rpc.setActivity({
        details: "Waddling around!", // text under Application name
        state: "Making new friends!", // text under details 
        startTimestamp: new Date(), // If you want to show how long the status has been running, if you don't want it, put // infront of the line or just delete this line
        largeImageKey: "small_image", //must match images in the application
        //largeImageText: "Text 1", // This is the text above the large image
        //smallImageKey:"github", //must match images in the application
        //smallImageText: "Text 2", // this is the text above the small image
        buttons: [
            {
		label: "Play Now",
		url: "https://play.cpimagined.net/"
            },
            { label: "Join our Discord", url: "https://play.cpimagined.net/" }
        ]
    });
})

rpc.login({
    clientId: "924851110886391839" //https://discord.com/developers/applications
})

  //mainWindow.webContents.openDevTools();

  mainWindow.on('closed', function () {
    mainWindow = null
  });
}

app.on('ready', createWindow);

app.on('window-all-closed', function () {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') app.quit();
});

app.on('activate', function () {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (mainWindow === null) createWindow();
});


setInterval(clearCache, 1000*60*5);