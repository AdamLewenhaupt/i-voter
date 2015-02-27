# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

isOnline = false

updateVote = () ->
	$("#current-vote").html $("#vote option:selected").text()

$(document).ready () ->
	ws = new WebSocket "ws://localhost:8080/websocket"

	updateVote()

	$("#vote").change () ->
		updateVote()

	$("#vote-btn").click () ->
		$(this).addClass("btn-success")
		$(this).html("Tack för din röst")

	ws.onopen = () ->
		isOnline = true
		$("#ws-offline").addClass("hidden")
		$("#ws-online").removeClass("hidden")

	ws.onclose = () ->
		isOnline = false
		$("#ws-offline").removeClass("hidden")
		$("#ws-online").addClass("hidden")