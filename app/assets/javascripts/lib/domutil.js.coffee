this.toggleHidden = (doms) ->
	for el in doms
		$(el).toggleClass 'hidden'