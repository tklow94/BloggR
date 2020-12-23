class ApplicationController < ActionController::Base #only available to controllers
    
    helper_method :current_user, :logged_in? #allows this method available to our views too
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        # so we don't have to hit the db everytime, we check to see if we have a current user first before hitting the db.
    end

    def logged_in?
        !!current_user #turns current_user into a boolean. It will return true or false depending on if logged in.
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end

end
