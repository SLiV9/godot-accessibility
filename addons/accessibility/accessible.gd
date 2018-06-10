extends Object

var node

func present_button():
    var text = "Unlabelled"
    if node.text:
        text = node.text
    print("%s: button" % text)

func present_line_edit():
    var text = "blank"
    if node.secret:
        text = "password"
    elif node.text != "":
        text = node.text
    elif node.placeholder_text != "":
        text = node.placeholder_text
    var type = "editable text"
    if not node.editable:
        type = "text"
    print("%s: %s" % [text, type])

func item_or_items(count):
    if count == 1:
        return "item"
    else:
        return "items"

func present_tree():
    var root = node.get_root()
    var count = 0
    print("tree: %s %s" % [count, item_or_items(count)])

func focused():
    if node is Button:
        present_button()
    elif node is LineEdit:
        present_line_edit()
    elif node is Tree:
        present_tree()
    else:
        print("Focus entered.", self.node)

func unfocused():
    pass

func gui_input(event):
    pass

func _init(node):
    if node.is_in_group("accessible"):
        return
    node.add_to_group("accessible")
    self.node = node
    # self.node.set_focus_mode(Control.FOCUS_ALL)
    self.node.connect("focus_entered", self, "focused")
    self.node.connect("mouse_entered", self, "focused")
    self.node.connect("focus_exited", self, "unfocused")
    self.node.connect("mouse_exited", self, "unfocused")
    self.node.connect("gui_input", self, "gui_input")
    self.node.connect("tree_exiting", self, "free")
