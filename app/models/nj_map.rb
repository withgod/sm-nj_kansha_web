class NjMap < ActiveRecord::Base
  has_many :nj_kansha_results
  has_many :results, :class_name => "NjKanshaResult"
end
