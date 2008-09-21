module Admin::DashboardHelper
  def updater_name_for(obj, options={})
    associations = *options[:associations] || [:updated_by, :created_by]
    attribute = options[:attribute] || :name
    not_found = options[:not_found] || 'Radiant System'
    answer = ""
    for association in associations
      if obj.respond_to?(association.to_sym)
        if obj.send(association.to_sym).nil?
          answer = not_found
        else
          answer = obj.send(association.to_sym).send(attribute.to_sym)
          break
        end
      end
    end
    answer
  end
end