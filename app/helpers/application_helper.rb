module ApplicationHelper
	def field_class(resource, field_name)
		Rails.logger.debug("#{resource.errors.inspect}")
	  if resource.errors[field_name]
	    return "error".html_safe
	  else
	    return "".html_safe
	  end
	end

 	def sortable(column, title = nil)
		direction = (column == sort_column.to_sym && sort_direction == "asc") ? "desc" : "asc"
		title =  direction == "asc" ?  ' ▼ ' : ' ▲ ' 
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil)
	end

  
end

