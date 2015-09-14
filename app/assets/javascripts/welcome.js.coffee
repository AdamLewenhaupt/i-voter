isOnline = false
isAutenticated = false

updateVote = () ->
    $("#current-vote").html $("#vote option:selected").text()


handleMsg = (msg) ->
    parts = msg.split(":")
    type = parts[0]
    content = parts[1]

    console.log type, content

    switch type
        when "count"
            $("#voter-count span").html(content)

        when "start"
            $("#current-vote").html("--")
            toggleHidden(["#inactive", "#display"])
            options = content.split("|")
            $("#vote option").remove()

            for opt,i in options
                $("<option value='#{i}'>#{opt}</option>").appendTo $("#vote")

            $("#vote").trigger('change')

        when "end"
            toggleHidden(["#inactive", "#display"])



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
        client.publish '/vote', "vote:" + $("#vote").val()
        if isAutenticated
            $(this).addClass("btn-success")
            $(this).html("Tack för din röst")
        else
            alert("Du har ej rätt att rösta")
