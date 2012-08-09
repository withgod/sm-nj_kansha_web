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
  scope :ranking_scope_sol, select('nj_steamids.*, sum(nj_kansha_results.jump_count) as jump_count')
  .joins('left join nj_kansha_results on nj_kansha_results.nj_steamid_id = nj_steamids.id')
  .group('nj_steamids.id')
  .order('jump_count desc')
  .where('jump_count > 0 and nj_kansha_results.nj_class_id = 3')
  scope :ranking_scope_demo, select('nj_steamids.*, sum(nj_kansha_results.jump_count) as jump_count')
  .joins('left join nj_kansha_results on nj_kansha_results.nj_steamid_id = nj_steamids.id')
  .group('nj_steamids.id')
  .order('jump_count desc')
  .where('jump_count > 0 and nj_kansha_results.nj_class_id = 4')
  scope :ranking_scope_starters, select('nj_steamids.*, sum(nj_kansha_results.jump_count) as jump_count')
  .joins('left join nj_kansha_results on nj_kansha_results.nj_steamid_id = nj_steamids.id')
  .group('nj_steamids.id')
  .order('jump_count desc')
  .where('jump_count > 0 and nj_kansha_results.nj_map_id in (8, 89)')
  scope :ranking_scope_xxx, lambda {|mapname| select('nj_steamids.*, sum(nj_kansha_results.jump_count) as jump_count')
  .joins('left join nj_kansha_results on nj_kansha_results.nj_steamid_id = nj_steamids.id')
  .group('nj_steamids.id')
  .order('jump_count desc')
  .where("jump_count > 0 and nj_kansha_results.nj_map_id = #{mapname}")}

  def total_count
    return self.results.sum(:jump_count)
  end
  def total_challenge
    return self.results.count(:id)
  end
  def last_nick
    return self.nicknames.last.nickname
  end
  def last_challenge
    return self.nicknames.last.created
  end
  def since_at
    if self.results.size != 0 then
      return self.results.first().created_at.to_s().sub(" UTC", "")
    else
      return "na"
    end
  end
end
