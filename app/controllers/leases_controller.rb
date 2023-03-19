class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message

  def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
  end

  def destroy
    lease = find_lease
    lease.destroy
  end

  private

  def lease_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end

  def find_lease
    Lease.find(params[:id])
  end

  def render_unprocessable_entity(invalid)
    render json: { error: invalid.record.errors }, status: :unprocessable_entity
  end

  def not_found_message
    render json: { error: 'No such lease has been issued' }, status: :not_found
  end
end
