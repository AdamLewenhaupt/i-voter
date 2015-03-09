# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

loggedIn = false

logIn = (text) ->

	params =
		pass = text

	$.post "/admin/auth", params, (data) ->
		loggedIn = data
		$("#login").addClass("hidden")
		$("#panel").removeClass("hidden")

$(document).ready () ->

	$(document).keypress (e) ->
		if not loggedIn and e.which == 13 
			login($("#pass").val())