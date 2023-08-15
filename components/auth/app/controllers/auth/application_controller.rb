module Auth
  class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
      Auth.config.after_sign_in_path
    end

    def after_sign_out_path_for(resource)
      Auth.config.after_sign_out_path
    end
  end
end
