class SessionsController < ApplicationController

    def new
     
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)

        if user && user.authenticate(params[:session][:password])
            #sessions enable an application to maintain a specific user's state. Rails session object is provided to store user info. Stores in a session cookie. Cryptographically signed and encrypted.
            session[:user_id] = user.id
            flash[:notice] = "Logged in successfully"
            redirect_to user
        else
            flash.now[:alert] = "There was something wrong with your login details"
            # need .now because we are using a render not a redirect. Rendering the new template again the flash message would go away. Flash persits for one full http request which is what a redirect does so the flash message shows up after. With render, without .now, the message will show up after a redirect to another page and not upon the re render.
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "You have been logged out"
        redirect_to root_path
    end
end