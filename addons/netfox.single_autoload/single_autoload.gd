@tool
extends EditorPlugin
## My Modifications for Stripping Netfox down.
##
## Reviewing the original plugin script. it's whole purpose is to create the
## autoloads and update the settings, there is nothing else in here.
## [br]So lets look at the autoloads and see what is required of them.

const Settings = preload("uid://6dax4xv0fr20")
const SettingsResource = preload("uid://mq3y6sk5aedg")

const Self:GDScript = preload("single_autoload.gd")

const Author:String = "Samuel Nicholas (Enetheru)"
const author:String = "enetheru"           # snake_case tag
const PluginName:String = "EnetheruNetfox"   # Capitalised
const plugin_name:String = "enetheru_netfox" # snake case
const PluginDescription:String = "shim over netfox to show a single autoload with options."
const AutoloadName:String = "Netfox"

static var plugin_dir:String = (Self as Resource).resource_path
static var plugin_path:String = plugin_dir.get_base_dir()

static var ll := ENetfoxLogger.new('netfox', 'enetheru')

const default_settings:SettingsResource = preload("uid://htpl2iowt2lu")
static var settings:Settings = Settings.new(default_settings, plugin_name)

## An array of custom types we've added that we can loop through on exit to
## remove.
static var enabled_types:Array[StringName] = []

# The only reason these should be in strings is so that we arent autoloading them.
# bit in the original they are all added by default anyway, so what gives?
# is there a specific order things had to be added in?
static var autoloads: Dictionary = {
		"NetworkTime": plugin_path + "/network-time.gd",
		"NetworkTimeSynchronizer":plugin_path + "/network-time-synchronizer.gd",
		"NetworkRollback": plugin_path + "/rollback/network-rollback.gd",
		"NetworkEvents": plugin_path + "/network-events.gd",
		"NetworkPerformance": plugin_path + "/network-performance.gd",
		"RollbackSimulationServer": plugin_path + "/servers/rollback-simulation-server.gd",
		"NetworkHistoryServer": plugin_path + "/servers/network-history-server.gd",
		"NetworkSynchronizationServer":plugin_path + "/servers/network-synchronization-server.gd",
		"NetworkIdentityServer": plugin_path + "/servers/network-identity-server.gd",
		"NetworkCommandServer": plugin_path + "/servers/network-command-server.gd",
		"RollbackLivenessServer": plugin_path + "/servers/rollback-liveness-server.gd"
}

## What's weird about these types is that they have class_names. I'm confused as
## to why this array exists if they are already in the editor.
static var TYPES: Array[Dictionary] = [
	{
		"name": "RollbackSynchronizer",
		"base": "Node",
		"script": plugin_path + "/rollback/rollback-synchronizer.gd",
		"icon": plugin_path + "/icons/rollback-synchronizer.svg"
	},
	{
		"name": "StateSynchronizer",
		"base": "Node",
		"script": plugin_path + "/state-synchronizer.gd",
		"icon": plugin_path + "/icons/state-synchronizer.svg"
	},
	{
		"name": "TickInterpolator",
		"base": "Node",
		"script": plugin_path + "/tick-interpolator.gd",
		"icon": plugin_path + "/icons/tick-interpolator.svg"
	},
	{
		"name": "RewindableAction",
		"base": "Node",
		"script": plugin_path + "/rewindable-action.gd",
		"icon": plugin_path + "/icons/rewindable-action.svg"
	},
	{
		"name": "PredictiveSynchronizer",
		"base": "Node",
		"script": plugin_path + "/rollback/predictive-synchronizer.gd",
		"icon": plugin_path + "/icons/predictive-synchronizer.svg"
	},
]

func _on_project_settings_changed(
			setting_name:String,
			setting_value:Variant ) -> void:
	ll.debug(''.join([setting_name, ':', str(setting_value)]))
	match setting_name:
		# These are the only boolean on or off switches i found.
		# I had to prefix them to prevent name clashes.
		&'rollback_enabled':pass
		&'sync_enable_diff_states': pass
		&'events_enabled': pass

	## This needs to be actioned per module.
	# for type in TYPES:
	# 	add_custom_type(type.name, type.base, load(type.script), load(type.icon))

	# I dont want any autoloads except for one. and that's aready been added.
	# for autoload_name in autoloads.keys():
	# 	if not ProjectSettings.has_setting("autoload/" + autoload_name):
	#		add_autoload_singleton(autoload_name, autoloads[autoload_name])


func _init() -> void:
	name = PluginName

	if not ProjectSettings.has_setting("autoload/" + AutoloadName):
		add_autoload_singleton(AutoloadName, plugin_path + "/servers/netfox.gd")


func _enter_tree() -> void:
	settings.validate_settings()

	@warning_ignore("return_value_discarded")
	settings.settings_changed.connect(_on_project_settings_changed)


func _exit_tree() -> void:
	if default_settings.clear_settings:
		settings.erase_prefix(plugin_name)

	while not enabled_types.is_empty():
		var type:StringName = enabled_types.pop_back()
		remove_custom_type(type)

	if ProjectSettings.has_setting("autoload/" + AutoloadName):
			remove_autoload_singleton(AutoloadName)
