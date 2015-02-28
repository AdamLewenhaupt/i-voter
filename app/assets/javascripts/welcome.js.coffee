isOnline = false

updateVote = () ->
	$("#current-vote").html $("#vote option:selected").text()

$(document).ready () ->

	client = new Faye.Client('/faye')
	client.on 'transport:down', () ->
		isOnline = true
		$("#ws-offline").removeClass("hidden")
		$("#ws-online").addClass("hidden")
	client.on 'transport:up', () ->
		isOnline = true
		$("#ws-offline").addClass("hidden")
		$("#ws-online").removeClass("hidden")

	voteSub = client.subscribe '/vote', (msg) ->
		console.log(msg)

	updateVote()

	$("#vote").change () ->
		updateVote()

	$("#vote-btn").click () ->
		$(this).addClass("btn-success")
		$(this).html("Tack för din röst")