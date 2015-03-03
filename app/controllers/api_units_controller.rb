class ApiUnitsController < ApplicationController

  before_filter :find_unit, only: [:show, :update]

  before_filter only: :create do
    @unit = Unit.find_by_key(@json['unit']['key'])
  end

  before_filter only: :create do |c|
    meth = c.method(:validate_json)
    meth.call (@json.has_key?('unit') && @json['unit'].responds_to?(:[]) && @json['unit']['key'])
  end

  before_filter only: :update do |c|
    meth = c.method(:validate_json)
    meth.call (@json.has_key?('unit'))
  end

  before_filter only: :create do |c|
    meth = c.method(:check_existence)
    meth.call(@unit, "Unit", "find_by_key(@json['unit']['key'])")
  end

  def index
    render json: Unit.all
  end

  def show
    render json: @unit
  end

  def create
    if @unit.present?
      render nothing: true, status: :conflict
    else
      @unit = Unit.new
      update_values :@unit, @json['unit']
    end
  end

  def update
    @unit.assign_attributes(@json['unit'])
    if @unit.save
      render json: @unit
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

