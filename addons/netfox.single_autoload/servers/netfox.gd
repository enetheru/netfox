extends Node

const SettingsResource = preload("uid://mq3y6sk5aedg")
static var opts:SettingsResource

## Children
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

	NetworkRollback = _NetworkRollback.new()
	NetworkHistoryServer = _NetworkHistoryServer.new()
	NetworkTime = _NetworkTime.new()
	NetworkTimeSynchronizer = _NetworkTimeSynchronizer.new()
	NetworkEvents = _NetworkEvents.new()
	NetworkPerformance = _NetworkPerformance.new()
	RollbackSimulationServer = _RollbackSimulationServer.new()
	NetworkSynchronizationServer = _NetworkSynchronizationServer.new()
	NetworkIdentityServer = _NetworkIdentityServer.new()
	NetworkCommandServer = _NetworkCommandServer.new()
	RollbackLivenessServer = _RollbackLivenessServer.new()

	for key:StringName in [
		&'NetworkTime',
		&'NetworkTimeSynchronizer',
		&'NetworkRollback',
		&'NetworkEvents',
		&'NetworkPerformance',
		&'RollbackSimulationServer',
		&'NetworkHistoryServer',
		&'NetworkSynchronizationServer',
		&'NetworkIdentityServer',
		&'NetworkCommandServer',
		&'RollbackLivenessServer' ]:
			var node:Node = get(key)
			node.name = key
			add_child( node, true )
