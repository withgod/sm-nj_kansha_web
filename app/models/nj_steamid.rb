class NjSteamid < ActiveRecord::Base
  has_many :nj_steam_nicknames
  has_many :nicknames, :class_name => "NjSteamNickname"
  has_many :nj_kansha_results
  has_many :results, :class_name => "NjKanshaResult"

  def total_count
    return self.results.sum(:jump_count)
  end
  def last_nick
    return self.nicknames.last.nickname
  end
  def average_count_per_jump
    return self.total_count / self.results.size
  end
end
