class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    instructors = Instructor.all
    render json: instructors
  end

  def show
    instructor = find_icr
    render json: instructor
  end

  def create
    instructor = Instructor.create(icr_params)
    render json: instructor, status: :created
  end

  def update
    instructor = find_icr
    instructor.update(icr_params)
    render json: instructor
  end 

  def destroy
    instructor = find_icr
    instructor.destroy
    head :no_content
  end

  private

  def find_icr
    Instructor.find_by(id: params[:id])
  end

  def icr_params
    params.permit(:name)
  end

  def render_not_found_response
    render json: { error: "Instructor not found" }, status: :not_found
  end

end