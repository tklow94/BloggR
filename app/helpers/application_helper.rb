module ApplicationHelper

    def gravatar_for(user, options = { size: 80 })
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        # so we don't have to hit the db everytime, we check to see if we have a current user first before hitting the db.
            

    end

    def logged_in?
        !!current_user #turns current_user into a boolean. It will return true or false depending on if logged in.
    end

end
