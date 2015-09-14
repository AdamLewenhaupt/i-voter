# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

loggedIn = false
votes = 0
voteCounter = []
userCheck = []

login = (text) ->

    params =
        pass: text

    $.post "/admin/auth", params, (data) ->
        loggedIn = data.valid
        if loggedIn
            $("#login").addClass("hidden")
            $("#panel").removeClass("hidden")


handleMsg = (msg) ->
    parts = msg.split(":")
    type = parts[0]
    user = parts[1]
    content = parts[2]

    console.log user, userCheck

    if user in userCheck
       return false 
    else
        userCheck.push user

    if type == "vote"
        id = +content
        voteCounter[id] += 1
        votes += 1

        $(".opt").each (i) ->
            percent = voteCounter[i] / votes * 100

            $(".opt-title-#{i} span").html voteCounter[i]
            $(this).children(".progress-bar").attr("aria-valuenow", Math.round percent)
                .css("width", "#{percent}%")
                .html "#{ percent.toFixed 2 }%" 



setVote = (options) ->
    $vOpts = $("#voting-options")
    $vOpts.html("")

    votes = 0
    userCheck = []
    voteCounter = [1..options.length].map -> 0

    for opt,i in options
        $("<p class='opt-title-#{i}'>#{opt} - <span>0</span> röst(er)</p>").appendTo $vOpts
        $("<div class='progress opt'><div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width:0%;'>0%</div></div>").appendTo $vOpts




$(document).ready () ->

    client = new Faye.Client('/faye')
    voteSub = client.subscribe '/vote', handleMsg

    $(document).keypress (e) ->
        if not loggedIn and e.which == 13 
            login($("#pass").val())

    votes = +$("#total").html()
    voteCounter = $(".votes").map(-> +$(this).html()).get()

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

        client.publish '/vote', "start:#{window.options.join '|'}"

        $(".vote-init").addClass "hidden"
        $(".vote-active").removeClass "hidden"
        $("#new").addClass "hidden"

    $("#end").click () ->

        client.publish '/vote', "end:"

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

    $("#map").locationpicker
        location: { latitude: 59.348430,  longitude: 18.073814 }

        radius: 500
        onchanged: (loc) ->
            $.post "/update-location", loc
