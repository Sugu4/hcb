# frozen_string_literal: true

class RafflesController < ApplicationController
  skip_after_action :verify_authorized, only: [:new, :create]

  def new
  end

  def create
    if Raffle.where(user: current_user, program: params[:program]).any?
      flash[:error] = "You are already entered in this raffle."
      redirect_to root_path
    else
      raffle = Raffle.new(user: current_user, program: params[:program])
      if raffle.save
        flash[:success] = "Raffle joined!"
        redirect_to root_path
      else
        flash[:error] = raffle.errors.full_messages.to_sentence
        redirect_to new_raffle_path
      end
    end
  end

end
