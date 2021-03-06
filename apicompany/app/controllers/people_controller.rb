# frozen_string_literal: true

class PeopleController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  # GET /people
  def index
    @people = Person.all

    render json: @people, include: { project: { only: [:name] },
                                     country: { only: [:name] },
                                     rol: { only: [:name] } }
  end

  # GET /people/1
  def show
    render json: @person
  end

  # POST /people
  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, status: :created, location: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      render json: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
  end

  # GET employees
  def employees
    @people = Person.with_employee

    render json: @people, include: { project: { only: [:name] },
                                     country: { only: [:name] },
                                     rol: { only: [:name] } }
  end

  # GET customers
  def customers
    @people = Person.with_customer

    render json: @people
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(:name, :person_type, :project_id, :country_id, :rol_id)
  end
end
