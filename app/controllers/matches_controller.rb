class MatchesController < ApplicationController
  def index
    if current_user.admin?
      @matches = Match.all
    elsif current_user.coordinator?
      @matches = Match.where(
        affiliate_id: Coordinator.find(
          current_user.coordinator_id
        ).affiliate_id
      )
    end
  end
end
