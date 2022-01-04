module Admin
  class UsersController < ApplicationController
    before_action :init_service

    def index
      @pagy, @users = pagy(@user_service.list)
    end

    def new
      result = @user_service.new

      @user = result.user
    end

    def edit
      result = @user_service.edit(params[:id])

      @user = result.user
    end

    def create
      result = @user_service.create(create_user_params)

      @user = result.user

      if result.success?
        redirect_to admin_users_path, notice: I18n.t('admin.users.notices.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      result = @user_service.update(params[:id], update_user_params)

      @user = result.user

     if result.success?
       redirect_to admin_users_path, notice: I18n.t('admin.users.notices.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      result = @user_service.delete(params[:id])

      if result.success?
        redirect_to admin_users_path, notice: I18n.t('admin.users.notices.deleted')
      end
    end

    private

    def init_service
      @user_service = Users::UserService.new(@current_user)
    end

    def create_user_params
      params.require(:user).permit(:full_name, :email, :active, :password, :password_confirmation)
    end

    def update_user_params
      params.require(:user).permit(:id, :full_name, :email, :active)
    end
  end
end
