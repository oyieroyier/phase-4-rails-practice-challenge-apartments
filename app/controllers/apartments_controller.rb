class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message

  def index
    apartments = Apartment.all
    render json: apartments, status: :ok
  end

  def show
    apartment = find_apartment
    render json: apartment, status: :ok
  end

  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  def update
    apartment = find_apartment
    apartment.update!(apartment_params)
    render json: apartment, status: :accepted
  end

  def destroy
    apartment = find_apartment
    apartment.destroy

    head :no_content
  end

  private

  def find_apartment
    Apartment.find(params[:id])
  end

  def apartment_params
    params.permit(:number)
  end

  def render_unprocessable_entity(invalid)
    render json: { error: invalid.record.errors }, status: :unprocessable_entity
  end

  def not_found_message
    render json: { error: 'No such apartment' }, status: :not_found
  end
end
