class Todo < ActiveRecord::Base
  scope :done, -> {where(done: false)}
  scope :todo, -> {where(done: true)}
end
