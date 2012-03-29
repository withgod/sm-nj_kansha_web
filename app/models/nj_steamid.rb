class NjSteamid < ActiveRecord::Base
  paginates_per 50
  has_many :nj_steam_nicknames
  has_many :nicknames, :class_name => "NjSteamNickname"
  has_many :nj_kansha_results
  has_many :results, :class_name => "NjKanshaResult"

  scope :ranking_scope, select('nj_steamids.*, sum(nj_kansha_results.jump_count) as jump_count')
  .joins('left join nj_kansha_results on nj_kansha_results.nj_steamid_id = nj_steamids.id')
  .group('nj_steamids.id')
  .order('jump_count desc')
  .where('jump_count > 0')

  def total_count
    return self.results.sum(:jump_count)
  end
  def last_nick
    return self.nicknames.last.nickname
  end
  def last_challenge
    return self.nicknames.last.created
  end
  def average_count_per_jump
    if self.total_count != 0 && self.results.size != 0 then
      return self.total_count / self.results.size
    else
      return 0
    end
  end

end
