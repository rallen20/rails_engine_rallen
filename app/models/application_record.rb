class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # return an array of all IDs then use ruby to sample an index of that array
  # refactor for optimization?
  def self.random
    find(self.pluck(:id).sample)
  end
end
