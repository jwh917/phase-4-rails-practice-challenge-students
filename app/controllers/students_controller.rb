class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    students = Student.all
    render json: students
  end

  def show
    student = find_std
    render json: student
  end

  def create
    student = Student.create(std_params)
    render json: student, include: :instructor, status: :created
  end

  def update
    student = find_std
    student.update(std_params)
    render json: student, include: :instructor
  end 

  def destroy
    student = find_std
    student.destroy
    head :no_content
  end

  private

  def find_std
    Student.find_by(id: params[:id])
  end

  def std_params
    params.permit(:name, :age, :major, :instructor_id)
  end

  def render_not_found_response
    render json: { error: "Student not found" }, status: :not_found
  end

end