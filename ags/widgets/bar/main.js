
const time = Variable('', {
    poll: [1000, function() {
        return Date().toString();
    }],
});
const hyprland = await Service.import("hyprland")
const notifications = await Service.import("notifications")
const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")

const date = Variable("", {
    poll: [5000, 'date "+%H\n%M\n%b\n%e"'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id")
  const workspaces = hyprland.bind("workspaces")
    .as(ws => ws.map(({ id }) => Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Label(`${id}`),
      class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
    })))
  return Widget.Box({
    class_name: "workspaces",
    vertical: true,
    children: workspaces,
  })
}

function ClientTitle() {
  return Widget.Label({
    wrap: true,
    class_name: "client-title",
    label: hyprland.active.client.bind("title"),
  })
}


function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  })
}

function Notification() {
  const popups = notifications.bind("popups")
  return Widget.Box({
    class_name: "notification",
    vertical: true,
    visible: true,
    children: [
      Widget.Icon({ icon: "preferences-system-notifications-symbolic", }),
      Widget.Label({ label: popups.as(p => p.length || ""), }),
    ],
  })
}


function Media() {
  const label = Utils.watch("", mpris, "player-changed", () => {
    if (mpris.players[0]) {
      const { track_artists, track_title } = mpris.players[0]
      return `${track_artists.join(", ")} - ${track_title}`
    } else {
      return "Nothing is playing"
    }
  })

  return Widget.Button({
    class_name: "media",
    on_primary_click: () => mpris.getPlayer("")?.playPause(),
    on_scroll_up: () => mpris.getPlayer("")?.next(),
    on_scroll_down: () => mpris.getPlayer("")?.previous(),
    child: Widget.Label({ label }),
  })
}

function Volume() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  function getIcon() {
    const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
      threshold => threshold <= audio.speaker.volume * 100
    );
    return `audio-volume-${icons[icon]}-symbolic`;
  }

  const icon = Widget.Icon({
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
  });

  const label = Widget.Label({
    justification: "center",
    label: Utils.watch(() => `${Math.round(audio.speaker.volume * 100)}%`, audio.speaker),
  });

  const slider = Widget.Slider({
    vertical: true,
    min: 0,
    max: 130,
    value: 75,
    vexpand: true,
    draw_value: false,
    on_change: ({ value }) => audio.speaker.volume = value,
    setup: self => self.hook(audio.speaker, () => {
      self.value = audio.speaker.volume || 0;
    }),
  });

  return Widget.Box({
    class_name: "volume",
    css: "min-height: 180px",
    vertical: true,
    children: [slider, icon, label],
  });
}

// Leaving for a laptop im yet to use
function BatteryLabel() {
  const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
  const icon = battery.bind("percent").as(p =>
    `battery-level-${Math.floor(p / 10) * 10}-symbolic`)
  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    vertical: true,
    children: [
      Widget.Icon({ icon }),
      Widget.LevelBar({
        widthRequest: 140,
        vpack: "center",
        value,
      }),
    ],
  })
}


function SysTray() {
  const items = systemtray.bind("items")
  .as(items => items.map(item => Widget.Button({
    child: Widget.Icon({ icon: item.bind("icon") }),
    on_primary_click: (_, event) => item.activate(event),
    on_secondary_click: (_, event) => item.openMenu(event),
    tooltip_markup: item.bind("tooltip_markup"),
  })))

  return Widget.Box({
    vertical: true,
    children: items,
  })
}
// layout of the bar
function Left() {
  return Widget.Box({
    vertical: true,
    spacing: 8,
    children: [
      Workspaces(),
      //ClientTitle(),
    ],
  })
}

function Center() {
  return Widget.Box({
    vertical: true,
    vpack: "center",
    spacing: 8,
    children: [
      //Media(),
      Clock(),
      Notification(),
    ],
  })
}

function Right() {
  return Widget.Box({
    vertical: true,
    vpack: "end",
    spacing: 8,
    children: [
	    Volume(),
	    SysTray(),
    ],
  })
}


export function Bar() {
  return Widget.Window({
    monitor: 1,
    name: `bar`,
    class_name: "bar",
    keymode: "none",
    anchor: ['left', 'bottom', 'top'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
      vertical: true,
      css: "min-width: 2px; min-height: 2px;",
	    start_widget: Left(),
	    center_widget: Center(),
	    end_widget: Right(),
    }),
  });
}
