module ApplicationHelper
  def total_challenge_date_count(results)
    if results.blank?
      return 0
    end
    return results.select('date(created_at) as c').group('c').all().count()
  end
  def average_count_per_challenge(results)
    if results.blank?
      return 0
    end
    return results.sum(:jump_count) / results.size
  end
  def average_count_per_date(results)
    if results.blank?
      return 0
    end
    return results.sum(:jump_count) / total_challenge_date_count(results)
  end
  def average_count_per_period(results)
    if results.blank?
      return 0
    end
    _period = jump_period(results)
    return results.sum(:jump_count) / _period
  end
  def jump_period(results)
    if results.blank?
      return 0
    end
      return results.select('datediff(CURRENT_DATE, date(created_at)) as c').order('id').first().c.to_i
  end
end
