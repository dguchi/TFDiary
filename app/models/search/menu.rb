class Search::Menu < Search::Base
  ATTRIBUTES = %i(
    name
    kind
  )
  attr_accessor(*ATTRIBUTES)

  def matches
    t = ::Menu.arel_table
    results = ::Menu.all
    results = results.where(contains(t[:name], name)) if name.present?
    results = results.where(t[:kind].eq(kind)) if kind.present?
    results
  end
end