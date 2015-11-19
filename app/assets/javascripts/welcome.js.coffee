isOnline = false
isAutenticated = false
hasVoted = false

updateVote = () ->
    $("#current-vote").html $("#vote option:selected").text()

startFn = (data) ->
    options = data.options.split '|'
    $("#current-vote").html("--")
    toggleHidden(["#inactive", "#display"])
    $("#vote option").remove()

    for opt,i in options
        $("<option value='#{i}'>#{opt}</option>").appendTo $("#vote")

    $("#vote").trigger('change')

endFn = (data) ->
    toggleHidden(["#inactive", "#display"])
    hasVoted = false

initFn = (data) ->
    if data.options != undefined
        startFn data

debug = (msg) ->
    $("#debug").html(msg)


auth = (lat, long, acc) ->

    params = 
        lat: lat
        long: long
        acc: acc

    $.post "/auth", params, (data) ->
        auth = data.auth
        if auth
            $("#allowed").removeClass("hidden")
            $("#denied").addClass("hidden")
            isAutenticated = true


handlePos = (pos) ->
    #auth pos.coords.latitude, pos.coords.longitude, pos.coords.accuracy
    auth 0, 0, 0


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
    # if navigator.geolocation
    #     navigator.geolocation.getCurrentPosition handlePos, posError, posOptions
    # else
    #     console.log "no pos :("

    dispatcher = new WebSocketRails 'localhost:3000/websocket'

    dispatcher.on_open =(data) ->
        isOnline = true
        $("#ws-online").removeClass 'hidden'
        $("#ws-offline").addClass 'hidden'

    dispatcher.trigger 'init', { admin: false }

    dispatcher.bind 'start_vote', startFn
    dispatcher.bind 'x', endFn
    dispatcher.bind 'i', initFn

    updateVote()

    $("#vote").change () ->
        updateVote()

    $("#vote-btn").click () ->
        if isAutenticated
            if not hasVoted
                $(this).addClass("btn-success")
                dispatcher.trigger 'vote', { user: $("#user").html(), id: $("#vote").val() }
                $(this).html("Tack för din röst")
                hasVoted = true
            else
                alert "Du har redan röstat"
        else
            alert("Du har ej rätt att rösta")

