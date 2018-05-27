class Search::Group < Search::Base
  ATTRIBUTES = %i(
    name
  )
  attr_accessor(*ATTRIBUTES)

  def matches
    t = ::Group.arel_table
    results = ::Group.all
    results = results.where(contains(t[:name], name)) if name.present?
    results
  end
end