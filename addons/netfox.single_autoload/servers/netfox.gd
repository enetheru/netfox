extends Node

# When godot is started, the autoloads, and the main scene are loaded like they
# are in a scene file themselves. So static init, init, enter tree, ready,
# in the typical order. So the main scene script can override the default
# settings any time before enter_tree. If settings remain null, then during
# enter tree, the default settings file will be loaded.
var settings:NetfoxSettings = null

# Children
# I guess technically I dont need to keep these as variables like this.
# It just makes sense to have as little disruption as possible with the code.
# adding an alias to the top of files with a reference to Netfox.* is more
# straight forward than using a function to fetch the values.
var NetworkTime:_NetworkTime
var NetworkTimeSynchronizer:_NetworkTimeSynchronizer
var NetworkRollback:_NetworkRollback
var NetworkEvents:_NetworkEvents
var NetworkPerformance:_NetworkPerformance
var RollbackSimulationServer:_RollbackSimulationServer
var NetworkHistoryServer:_NetworkHistoryServer
var NetworkSynchronizationServer:_NetworkSynchronizationServer
var NetworkIdentityServer:_NetworkIdentityServer
var NetworkCommandServer:_NetworkCommandServer
var RollbackLivenessServer:_RollbackLivenessServer

func _enter_tree() -> void:
	print("I'm MR Meeseeks, look at me!")
	if settings == null:
		settings = load("uid://htpl2iowt2lu")

	# network Command server doesnt rely on any other object.
	NetworkCommandServer = _NetworkCommandServer.new()
	NetworkCommandServer.name = &'NetworkCommandServer'
	add_child( NetworkCommandServer, true )

	# Network Time Synchroniser is independent of other items.
	if settings.time_sync_enabled:
		NetworkTimeSynchronizer = _NetworkTimeSynchronizer.new()
		NetworkTimeSynchronizer.name = &'NetworkTimeSynchronizer'
		add_child( NetworkTimeSynchronizer, true )

	# Identity Server is used by network syncrhonisation server,

	# events relies on Time.
	if settings.events_enabled:
		NetworkEvents = _NetworkEvents.new()
		NetworkEvents.name = &'NetworkEvents'
		NetworkEvents.enabled = true
		add_child( NetworkEvents, true )

	# Now here I wish to instantiate as little as possible for the project I
	# am using. How can I make this happen before the autoload is generated
	# based on the scene.

	# I dont understand the objects and their dependencies entirely by their
	# names I guess some experimentation will have to be done to figure out
	# what is what.

	# Are there any classes that exist independently?
	# I guess its back to building the dependency graph in obsidian again.
#
	#NetworkTime = _NetworkTime.new()
	#NetworkTimeSynchronizer = _NetworkTimeSynchronizer.new()
#
	#NetworkHistoryServer = _NetworkHistoryServer.new()
	#NetworkSynchronizationServer = _NetworkSynchronizationServer.new()
	#NetworkIdentityServer = _NetworkIdentityServer.new()
#
#
	#NetworkRollback = _NetworkRollback.new()
	#RollbackSimulationServer = _RollbackSimulationServer.new()
	#RollbackLivenessServer = _RollbackLivenessServer.new()
#
	#NetworkPerformance = _NetworkPerformance.new()
#
	#for key:StringName in [
		#&'NetworkTime',
		#&'NetworkTimeSynchronizer',
		#&'NetworkRollback',
		#&'NetworkPerformance',
		#&'RollbackSimulationServer',
		#&'NetworkHistoryServer',
		#&'NetworkSynchronizationServer',
		#&'NetworkIdentityServer',
		#&'RollbackLivenessServer' ]:
			#var node:Node = get(key)
			#node.name = key
			#add_child( node, true )
