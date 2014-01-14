class AccessController < ApplicationController
  def index
      @monthly_count = NjKanshaResult.monthly_count.all
  end
end
