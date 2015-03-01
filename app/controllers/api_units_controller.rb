class ApiUnitsController < ApplicationController

  before_filter :find_unit, only: [:show, :update]

  before_filter only: :create do
    @unit = Unit.find_by_key(@json['unit']['key'])
  end

  before_filter only: :create do |c|
    meth = c.method(:validate_json)
    meth.call (@json.has_key?('project') && @json['project'].responds_to?(:[]) && @json['project']['name'])
  end

  before_filter only: :update do |c|
    meth = c.method(:validate_json)
    meth.call (@json.has_key?('project'))
  end

  before_filter only: :create do |c|
    meth = c.method(:check_existence)
    meth.call(@project, "Project", "find_by_name(@json['project']['name'])")
  end

  def index
    render json: Unit.all
  end

  def show
    render json: @unit
  end

  def create
    if @project.present?
      render nothing: true, status: :conflict
    else
      @project = Project.new
      update_values :@project, @json['project']
    end
  end

  def update
    @project.assign_attributes(@json['unit'])
    if @project.save
      render json: @project
    else
      render nothing: true, status: :bad_request
    end
  end

  private
  def find_unit
    @unit = Unit.find_by_key(params[:key])
    render nothing: true, status: :not_found unless @unit.present?
  end
end

