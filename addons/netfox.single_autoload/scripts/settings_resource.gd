@tool
extends Resource

@export_category("general")

@export
## Setting this to false will make Netfox keep its settings even when
## disabling the plugin. Useful for developing the plugin.
var clear_settings:bool = true

@export
var use_raw_commands:bool = false

@export
## Very conservative packet size limit, source:
## https://stackoverflow.com/a/35697810
var max_sync_packet_size:int = 508

@export
var supress_identity_peer_disconnected_warning:bool = false


@export_category('logging')

# @export
# FIXME This was noticed, as I was going, looks like they have a nexted logging situation.
# I could probaby do the same using a prefix, But I'm analysing another object
# Perhaps I can leverage that idea to split up the log settings like that. I could just aswell
# use an inner class.
# NetfoxLogger._make_setting("netfox/logging/netfox_log_level"),

@export_category('time')

@export
var tickrate:int = 30

@export
var max_ticks_per_frame:int = 8

@export
var recalibrate_threshold:float = 8.0

var stall_threshold:float = 1.0

@export_range(_NetworkTimeSynchronizer.MIN_SYNC_INTERVAL, 2, 0.01, "or_greater")
## Time to wait between time syncs
var sync_interval:float = 0.25

@export
var sync_samples:int = 8

@export
var sync_adjust_steps:int = 8

@export
## @Deprecated Time to wait between time sync samples
var sync_sample_interval:float = 0.1

@export
var sync_to_physics:bool = false

@export_range(1,2,0.05,"or_greater")
var max_time_stretch:float = 1.25

@export_enum("Warn", "Disconnect", "Adjust", "Signal")
var tickrate_mismatch_action:int = NetworkTickrateHandshake.WARN

@export
var suppress_offline_peer_warning:bool = false

@export_category("rollback")

@export
var enabled:bool = true

@export
var history_limit:int = 64

@export
var input_redundancy:int = 3

@export_range(0,4,0.01,"or_greater")
var display_offset:int = 0

@export_range(0,4,0.01,"or_greater")
var input_delay:int = 0

@export
var enable_input_broadcast:bool = false

@export
var enable_diff_states:bool = true

@export_range(0,60,0.1, "or_greater")
var full_state_interval:int = 24

@export_category("state_synchroniser")

@export
var sync_enable_diff_states:bool = true
# FIXME: ^^ I had to add sync_ prefix due to a name clash.

@export
var sync_history_limit:int = 64
# FIXME: ^^ I had to add sync_ prefix due to a name clash.

@export_range(0,60,0.1,"or_greater")
var sync_full_state_interval:int = 24
# FIXME: ^^ I had to add sync_ prefix due to a name clash.

@export_category("events")

@export
var events_enabled:bool = true
# FIXME: ^^ I had to add events_ prefix due to a name clash.
