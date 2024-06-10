class ApplicationsController < ApplicationController
    before_action :set_application, only: [:show, :update]

    def index
        @applications = Application.all
        render json: @applications
    end

    def create
        @application = Application.create(application_params)
        if @application.save
          render json: @application, status: :created
        else
          render json: @application.errors, status: :unprocessable_entity
        end
    end

    def update
        if @application.update(application_params)
          render json: @application
        else
          render json: @application.errors, status: :unprocessable_entity
        end
      end

    def show
        application = Application.find_by(token: params[:token])
        render json: application
    end

    private

    def set_application
        @application = Application.find_by(token: params[:token])
        render json: { error: 'Application not found' }, status: :not_found unless @application
    end

    def application_params
        params.require(:application).permit(:name)
    end
end
