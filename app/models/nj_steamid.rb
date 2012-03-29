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
    if self.total_count != 0 && self.results.size != 0 then
      return self.total_count / self.results.size
    else
      return 0
    end
  end
end
