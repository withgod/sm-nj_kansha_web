class NjKanshaResult < ActiveRecord::Base
  belongs_to :nj_steamid
  belongs_to :nj_map
  belongs_to :nj_class

  scope :soldier, where('nj_class_id = 3')
  scope :demoman, where('nj_class_id = 4')
  scope :daily_count,
    select('date(nj_kansha_results.created_at) as created_at, sum(jump_count) as cnt')
    .group('date(nj_kansha_results.created_at)')
    .order('created_at desc')
  scope :map_count,
    select('nj_map_id, count(nj_map_id) as cnt')
    .group('nj_map_id')
    .order('cnt desc')
#    .includes(:nj_map_id => :nj_map);
    #select('nj_map_id, count(nj_kansha_results.nj_map_id) as cnt')
    #.joins('left join nj_maps on nj_kansha_results.nj_map_id = nj_maps.id')
    #.group('nj_kansha_results.nj_map_id')
    #.order('cnt desc')

  def mapname
    return self.nj_map.mapname
  end

  def created
    return self.created_at.to_s.sub(' UTC', '')
  end

  def classname
    return self.nj_class.classname
  end
end
