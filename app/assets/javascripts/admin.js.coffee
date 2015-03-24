# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

loggedIn = false

login = (text) ->

	params =
		pass: text

	$.post "/admin/auth", params, (data) ->
		loggedIn = data.valid
		if loggedIn
			$("#login").addClass("hidden")
			$("#panel").removeClass("hidden")


handleVote = (id) ->
	

handleMsg = (msg) ->
	parts = msg.split(":")
	type = parts[0]
	content = parts[1]

	if type == "count"
		$("#voter-count").html(content)


setVote = (options) ->
	$vOpts = $("#voting-options")
	$vOpts.html("")

	for opt in options
		$("<h2>#{opt}</h2>").appendTo $vOpts
		$("<div class='progress'><div class='progress-bar' role='progressbar' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100' style='width:50%;'>50%</div></div>").appendTo $vOpts




$(document).ready () ->

	client = new Faye.Client('/faye')
	voteSub = client.subscribe '/vote', handleMsg
	voteWatcherSub = client.subscribe '/vote-watcher', handleVote

	$(document).keypress (e) ->
		if not loggedIn and e.which == 13 
			login($("#pass").val())

	$("#add").click () ->

		$option = $("<div class='input-group' />")
		$btn = $("<span class='input-group-btn'><div class='btn btn-danger'><span class='glyphicon glyphicon-minus'></span></div></span>")
		$btn.click () ->
			$option.remove()

		$input = $("<input class='form-control' type='text' placeholder='Alternativ..' />")

		$input.appendTo $option
		$btn.appendTo $option

		$option.appendTo $("#options")

	$("#begin").click () ->
		window.options = $("#options div input").map () -> $(this).val()
			.get()

		if options.length < 1
			alert "Det finns inget att rösta på"
			return false

		else
			setVote(window.options)

		params = 
			options: window.options

		$.post "/admin/start", params, (data) ->
			$(".vote-init").addClass "hidden"
			$(".vote-active").removeClass "hidden"
			$("#new").addClass "hidden"

	$("#end").click () ->
		$.post "/admin/end", (data) ->
			console.log data
			$("#end").attr("disabled", true)
			$("#new").removeClass "hidden"
			$("#is-voting").addClass "hidden"
			$("#done-voting").removeClass "hidden"

	$("#new").click () ->
		$(".vote-init").removeClass "hidden"
		$(".vote-active").addClass "hidden"
		$("#options").html("")
		$("#end").attr("disabled", false)
		$("#is-voting").removeClass "hidden"
		$("#done-voting").addClass "hidden"
