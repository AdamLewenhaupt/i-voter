isOnline = false
isAutenticated = false

toRad = (Value) -> Value * Math.PI / 180

distance = (long1, lat1, long2, lat2) ->
  R = 6371
  # earth radius in km
  dLat = toRad(lat2 - lat1)
  dLon = toRad(long2 - long1)
  lat1 = toRad(lat1)
  lat2 = toRad(lat2)
  a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2)
  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  R * c * 1000

updateVote = () ->
	$("#current-vote").html $("#vote option:selected").text()


handleMsg = (msg) ->
	parts = msg.split(":")
	type = parts[0]
	content = parts[1]

	if type == "count"
		$("#voter-count").html(content)


debug = (msg) ->
	$("#debug").html(msg)


auth = (lat, long, acc) ->

	targetLat = 59.348430
	targetLong = 18.073814

	params = 
		dist: distance(targetLat, targetLong, lat, long)
		acc: acc


	debug "Distance to SingSing: #{Math.round(params.dist)}m +/- #{Math.round(params.acc)}m"

	$.post "/auth", params, (data) ->
		auth = data.auth
		if auth
			$("#allowed").removeClass("hidden")
			$("#denied").addClass("hidden")
			isAutenticated = true


handlePos = (pos) ->
	auth pos.coords.latitude, pos.coords.longitude, pos.coords.accuracy


posError = (err) ->
	switch err.code
		when 1
			console.log "denied"
		when 2
			console.log "no pos :("
		when 3
			console.log "to slow"


posOptions = 
	enableHighAccuracy: true

$(document).ready () ->

	# Check position if possible
	if navigator.geolocation
		navigator.geolocation.getCurrentPosition handlePos, posError, posOptions
	else
		console.log "no pos :("

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
		handleMsg msg

	updateVote()

	$("#vote").change () ->
		updateVote()

	$("#vote-btn").click () ->
		if isAutenticated
			$(this).addClass("btn-success")
			$(this).html("Tack för din röst")
		else
			alert("Du har ej rätt att rösta")