# frozen_string_literal: true

require 'csv'

class TeamsController < ApplicationController
  before_action :set_team, only: %i[update show destroy download_logo return_multiple_sizes_logo]

  def index
    @teams = Team.all

    TeamMailer.send_report.deliver_later
  end

  def bulk_upload
    csv_file = CSV.read(bulk_params[:input_file].path)
    BulkUploadJob.perform_later(csv_file)
  end

  def return_multiple_sizes_logo
    @logo_variants = []
    @team.logo.each do |logo|
      @logo_variants << logo.variant(resize: '100x100')
      @logo_variants << logo.variant(resize: '640x640')
    end
    @logo_variants
  end

  def show
    head :not_found unless @team.present?
  end

  def download_logo
    # send_data(@team.logo.download, filename: 'logo.jpg')
    redirect_to rails_blob_url(@team.logo)
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      render :show, status: :created
    else
      handle_error(@team.errors)
    end
  end

  def update
    if @team.update(team_params)
      render :show
    else
      handle_error(@team.errors)
    end
  end

  def destroy
    if @team.destroy
      render :head
    else
      handle_error(@team.errors)
    end
  end

  private

  def bulk_params
    params.permit(:input_file)
  end

  def permitted_params
    params.permit(:id)
  end

  def team_params
    params.require(:team).permit(:name,
                                 :abbreviation,
                                 logo: [] )
  end

  def set_team
    @team = Team.find(permitted_params[:id])
  end
end
