class Buses::BuilderController < ApplicationController
  include Wicked::Wizard

  before_action :set_bus, only: [:show, :update]

  params_for :bus, :name, :capacity, :year, :model, seats_attributes: [:id, :_destroy, :row, :number]

  steps :details, :seats


  def create
    @bus = Bus.new {|b| b.save(validate: false)}
    redirect_to wizard_path(steps.first, bus_id: @bus)
  end

  def show
    render_wizard
  end

  def update
    @bus.update(bus_params)
    render_wizard @bus
  end

  private
  def finish_wizard_path
    buses_url
  end

  def set_bus
    @bus =  Bus.find(params[:bus_id])
  end
end