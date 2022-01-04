module Admin
  class ApplicationController < ActionController::Base
    layout 'admin'

    before_action :authenticate_user!

    include Pagy::Backend
  end
end
