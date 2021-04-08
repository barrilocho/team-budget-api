require "byebug"
class CategorySearchService

  def self.search(curr_categories, query)
    data = curr_categories.where(family_id: query.to_i)
    data
  end
end