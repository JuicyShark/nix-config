{pkgs, ...}:
{
	home.packages = with pkgs; [
		kitty
		dmenu-rs
		feh
	];
	xdg.configFile."leftwm/config.ron".text = ''
 		#![enable(implicit_some)]
		#![enable(unwrap_newtypes)]
		(
	backend: "X11rb"
    	modkey: "Mod1",
    	mousekey: "Mod1",
    	workspaces: [],
    	tags: [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
    ],
    max_window_width: 3440,
    layouts: [
        "EvenHorizontal",
        "EvenVertical",
        "Monocle",
        "Grid",
        "MainAndVertStack",
        "MainAndHorizontalStack",
        "RightMainAndVertStack",
        "Fibonacci",
        "Dwindle",
        "MainAndDeck",
        "CenterMain",
        "CenterMainBalanced",
        "CenterMainFluid",
    ],
    
		layout_definitions: [
        (name: "EvenHorizontal", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: None, stack: (flip: None, rotate: North, split: Vertical), second_stack: None)),
        (name: "EvenVertical", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: None, stack: (flip: None, rotate: North, split: Horizontal), second_stack: None)),
        (name: "Monocle", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: None, stack: (flip: None, rotate: North, split: None), second_stack: None)),
        (name: "Grid", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: None, stack: (flip: None, rotate: North, split: Grid), second_stack: None)),
        (name: "MainAndVertStack", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: (count: 1, size: 0.5, flip: None, rotate: North, split: Vertical), stack: (flip: None, rotate: North, split: Horizontal), second_stack: None)),
        (name: "MainAndHorizontalStack", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: (count: 1, size: 0.5, flip: None, rotate: North, split: Vertical), stack: (flip: None, rotate: North, split: Vertical), second_stack: None)),
        (name: "RightMainAndVertStack", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: South, main: (count: 1, size: 0.5, flip: None, rotate: North, split: Vertical), stack: (flip: None, rotate: North, split: Horizontal), second_stack: None)),
        (name: "Fibonacci", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: (count: 1, size: 0.5, flip: None, rotate: North, split: Vertical), stack: (flip: None, rotate: North, split: Fibonacci), second_stack: None)),
        (name: "Dwindle", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: (count: 1, size: 0.5, flip: None, rotate: North, split: Vertical), stack: (flip: None, rotate: North, split: Dwindle), second_stack: None)),
        (name: "MainAndDeck", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: (count: 1, size: 0.5, flip: None, rotate: North, split: None), stack: (flip: None, rotate: North, split: None), second_stack: None)),
        (name: "CenterMain", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: (count: 1, size: 0.5, flip: None, rotate: North, split: Vertical), stack: (flip: None, rotate: North, split: None), second_stack: (flip: None, rotate: North, split: Horizontal))),
        (name: "CenterMainBalanced", flip: None, rotate: North, reserve: None, columns: (flip: None, rotate: North, main: (count: 1, size: 0.5, flip: None, rotate: North, split: Vertical), stack: (flip: None, rotate: North, split: Dwindle), second_stack: (flip: None, rotate: North, split: Dwindle))),
        (name: "CenterMainFluid", flip: None, rotate: North, reserve: Reserve, columns: (flip: None, rotate: North, main: (count: 1, size: 0.5, flip: None, rotate: North, split: Vertical), stack: (flip: None, rotate: North, split: None), second_stack: (flip: None, rotate: North, split: Horizontal))),
    ],
    layout_mode: Tag,
    insert_behavior: Bottom,
    scratchpad: [
        (name: "Kitty", value: "kitty", x: 860, y: 390, height: 300, width: 200),
    ],
    window_rules: [],
    disable_current_tag_swap: false,
    disable_tile_drag: false,
    disable_window_snap: true,
    focus_behaviour: Sloppy,
    focus_new_windows: true,
    create_follows_cursor: true,
    single_window_border: true,
    sloppy_mouse_follows_focus: true,
    reposition_cursor_on_resize: true,
    auto_derive_workspaces: true,
    
    keybind: [
        
	(command: Execute, value: "dmenu_run", modifier: ["modkey"], key: "space"),
        (command: Execute, value: "kitty", modifier: ["modkey"], key: "Return"),
        (command: Execute, value: "firefox", modifier: ["modkey"], key: "b"),
	(command: CloseWindow, value: "", modifier: ["modkey", "Shift"], key: "q"),
        (command: SoftReload, value: "", modifier: ["modkey", "Shift"], key: "r"),
       	(command: MoveToLastWorkspace, value: "", modifier: ["modkey", "Shift"], key: "w"),
        (command: SwapTags, value: "", modifier: ["modkey"], key: "w"),

        (command: MoveWindowUp, value: "", modifier: ["modkey", "Shift"], key: "k"),
        (command: MoveWindowDown, value: "", modifier: ["modkey", "Shift"], key: "j"),
        (command: MoveWindowUp, value: "", modifier: ["modkey", "Shift"], key: "e"),
        (command: MoveWindowDown, value: "", modifier: ["modkey", "Shift"], key: "d"),
	(command: MoveWindowUp, value: "", modifier: ["modkey", "Shift"], key: "Up"),
        (command: MoveWindowDown, value: "", modifier: ["modkey", "Shift"], key: "Down"),
        (command: FocusWindowUp, value: "", modifier: ["modkey"], key: "k"),
        (command: FocusWindowDown, value: "", modifier: ["modkey"], key: "j"),
        (command: FocusWindowUp, value: "", modifier: ["modkey"], key: "e"),
        (command: FocusWindowDown, value: "", modifier: ["modkey"], key: "d"),
        (command: FocusWindowUp, value: "", modifier: ["modkey"], key: "Up"),
        (command: FocusWindowDown, value: "", modifier: ["modkey"], key: "Down"),
        (command: NextLayout, value: "", modifier: ["modkey", "Shift", "Control"], key: "k"),
        (command: PreviousLayout, value: "", modifier: ["modkey", "Shift", "Control"], key: "j"),
        (command: NextLayout, value: "", modifier: ["modkey", "Shift", "Control"], key: "e"),
        (command: PreviousLayout, value: "", modifier: ["modkey", "Shift", "Control"], key: "d"),
        (command: NextLayout, value: "", modifier: ["modkey", "Shift", "Control"], key: "Up"),
        (command: PreviousLayout, value: "", modifier: ["modkey", "Shift", "Control"], key: "Down"),
        (command: FocusWorkspaceNext, value: "", modifier: ["modkey"], key: "l"),
        (command: FocusWorkspacePrevious, value: "", modifier: ["modkey"], key: "h"),
        (command: FocusWorkspaceNext, value: "", modifier: ["modkey"], key: "f"),
        (command: FocusWorkspacePrevious, value: "", modifier: ["modkey"], key: "s"),
	(command: FocusWorkspaceNext, value: "", modifier: ["modkey"], key: "Right"),
        (command: FocusWorkspacePrevious, value: "", modifier: ["modkey"], key: "Left"),

        (command: GotoTag, value: "1", modifier: ["modkey"], key: "1"),
        (command: GotoTag, value: "2", modifier: ["modkey"], key: "2"),
        (command: GotoTag, value: "3", modifier: ["modkey"], key: "3"),
        (command: GotoTag, value: "4", modifier: ["modkey"], key: "4"),
        (command: GotoTag, value: "5", modifier: ["modkey"], key: "5"),
        (command: GotoTag, value: "6", modifier: ["modkey"], key: "6"),
        (command: GotoTag, value: "7", modifier: ["modkey"], key: "7"),
        (command: MoveToTag, value: "1", modifier: ["modkey", "Shift"], key: "1"),
        (command: MoveToTag, value: "2", modifier: ["modkey", "Shift"], key: "2"),
        (command: MoveToTag, value: "3", modifier: ["modkey", "Shift"], key: "3"),
        (command: MoveToTag, value: "4", modifier: ["modkey", "Shift"], key: "4"),
        (command: MoveToTag, value: "5", modifier: ["modkey", "Shift"], key: "5"),
        (command: MoveToTag, value: "6", modifier: ["modkey", "Shift"], key: "6"),
        (command: MoveToTag, value: "7", modifier: ["modkey", "Shift"], key: "7"),
    ],
    state_path: None,
)
 '';
}
