class ApplicationController < ActionController::Base
  # show alert when having no authorization
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_back fallback_location: root_path, :alert => exception.message }
    end
  end
end
