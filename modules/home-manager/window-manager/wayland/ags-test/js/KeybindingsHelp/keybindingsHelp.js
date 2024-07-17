
const hyprland = await Service.import('hyprland');

const keybindings = {
    'Alacritty': ['Ctrl+Shift+T: New Tab', 'Ctrl+Shift+W: Close Tab'],
    'Firefox': ['Ctrl+T: New Tab', 'Ctrl+W: Close Tab'],
    'Unknown': ['No keybindings available']
};

const getKeybindings = (appClass) => {
    return keybindings[appClass] || keybindings['Unknown'];
};

const KeybindingsWidget = () => Widget.Box({
    children: [
        Widget.Label({
            label: hyprland.active.client.bind('class').as(appClass => `Focused Window Class: ${appClass}`),
        }),
        Widget.Box({
            children: hyprland.active.client.bind('class').as(appClass => {
                const bindings = getKeybindings(appClass);
                return bindings.map(binding => Widget.Label({
                    label: binding,
                }));
            }),
            setup: self => self.hook(hyprland, () => {
                const appClass = hyprland.active.client.class;
                const bindings = getKeybindings(appClass);
                self.children = bindings.map(binding => Widget.Label({
                    label: binding,
                }));
            }),
        }),
    ],
    setup: self => {
        self.size = [800, Math.min(600, window.innerHeight / 2)];
        self.set_position(Gtk.WindowPosition.CENTER);
    }
});
export defa:Exult () = Widget.Box({
    name: "keybinds",
    anchor: ["left"],
    visible: false,
    children: [
        KeybindingsWidget(),
    ],
    setup: self => self.hook(hyprland, () => {
        self.children = [KeybindingsWidget()];
    }),
});
