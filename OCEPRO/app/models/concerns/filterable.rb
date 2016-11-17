##
# Concern para agregar funcionalidad de filtrado a modelos.
#
# Call scopes directly from your URL params:
#
#     @products = Product.filter(params.slice(:status, :location, :starts_with))

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    
    # Call the class methods with the same name as the keys in <tt>filtering_params</tt>
    # with their associated values. Most useful for calling named scopes from 
    # URL params. Make sure you don't pass stuff directly from the web without 
    # whitelisting only the params you care about first!
    def filter(filtering_params, any_value: nil)
      filtering_params ||= {}
      results = self.where(nil) # create an anonymous scope
      filtering_params.each do |key, value|
        value = nil if value.blank? && value != false
        results = results.public_send(key, value) if (value.present? || value == false) && value != any_value
      end
      results
    end
  end
end
