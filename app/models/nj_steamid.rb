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
  def total_challenge
    return self.results.count(:id)
  end
  def total_challenge_date_count
    return self.results.select('date(created_at) as c').group('c').all().count()
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
  def average_count_per_date
    if self.total_count != 0 && self.results.size != 0 then
      return self.total_count / self.total_challenge_date_count
    else
      return 0
    end
  end
  def average_count_per_period
    if self.total_count != 0 && self.results.size != 0 then
      return self.total_count / self.jump_period
    else
      return 0
    end
  end
  def since_at
    if self.results.size != 0 then
      return self.results.first().created_at.to_s().sub(" UTC", "")
    else
      return "na"
    end
  end
  def jump_period
    if self.results.size != 0 then
      return self.results.select('CURRENT_DATE - date(created_at) as c').first().c.to_i + 1
    else
      return "0"
    end
  end

end
