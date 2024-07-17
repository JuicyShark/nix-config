// entry file for ags

import App from 'resource:///com/github/Aylur/ags/app.js';
import Bar from './js/bar/bar.js'
import ControlCenter from './js/ControlCenter/ControlCenter.js';
import MediaWindow from './js/MediaWindow/media.js';
import Calendar from './js/Calendar/Calendar.js';
//import KeybindingsHelp from './js/KeybindingsHelp/keybindingsHelp.js'
let config = {
    style: App.configDir + '/style.css',
    windows: [
        Bar(1),
        ControlCenter(),
        MediaWindow(),
        Calendar(),
 //       KeyBindingsHelp()
    ],
    closeWindowDelay: {
        'controlcenter': 350,
        'media': 350,
        'calendar': 350
      },
};


App.config(config);
