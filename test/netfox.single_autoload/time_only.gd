extends Control

## An example of trying to setup netfox so that it is as minimal as possible.

const CUSTOM_SETTINGS:NetfoxSettings = preload("uid://cibbx0oe3e7e5")

func                        ________PROPERTIES_______              ()->void:pass

var text:String = "Default Text"
var messages:Array = []

@onready var body: RichTextLabel = $Body

@onready var time_sync:_NetworkTimeSynchronizer = Netfox.NetworkTimeSynchronizer

func                        __________EVENTS_________              ()->void:pass

func _on_initial_sync() -> void:
	messages.append("Initial Sync")


func _on_panic(offset: float) -> void:
	messages.append("Panic: %s" % offset)

func                        ________OVERRIDES________              ()->void:pass

func _init() -> void:
	print("Main Scene init")
	Netfox.settings = CUSTOM_SETTINGS


func _ready() -> void:
	body.text = text

	if not Netfox.settings.time_sync_enabled:
		body.text = "NetworkTimeSynchroniser is not enabled."
		set_fail()
		return

	if not is_instance_valid(time_sync):
		body.text = "NetworkTimeSynchroniser valid."
		set_fail()
		return

	text = "Ready"

	@warning_ignore_start("return_value_discarded")
	time_sync.on_initial_sync.connect(_on_initial_sync)
	time_sync.on_panic.connect(_on_panic)
	@warning_ignore_restore("return_value_discarded")


func _process(_delta: float) -> void:
	body.text = '\n'.join([
		"[font_size=%d]%s[/font_size]" % [64, time_sync.get_time()],
		text
	] + messages)


func                        _________METHODS_________              ()->void:pass

func set_fail() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
