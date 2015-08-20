module ApplicationHelper
  # Converts rails flash keys to boostrap classes
  def flash_class(key)
  	case key
  	when 'error'
  		'alert-danger'
  	when 'notice'
  		'alert-info'
  	else
  		"alert-#{key}"
  	end
  end
end
