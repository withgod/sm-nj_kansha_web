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
