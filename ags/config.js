"use strict";
// Import
import Gdk from 'gi://Gdk';
import GLib from 'gi://GLib';
import App from 'resource:///com/github/Aylur/ags/app.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

import { Bar } from './widgets/bar/main.js';
//import { NotificationPopups } from ' ./widgets/notificationPopup/main.js';



App.config({
    stackTraceOnError: true,
    style: "./style.css",
    windows: [
      Bar(),
      //NotificationPopups(1),
    ],
});
