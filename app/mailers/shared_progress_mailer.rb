class SharedProgressMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def shared_email
        email = params[:email]
        @user = params[:user]
        token = params[:token]
        @url  = "https://nameless-taiga-57160.herokuapp.com/dashboard/?auth_code=#{token}"
        #@url = "http://127.0.0.1:3000/dashboard/?auth_code=#{token}"
        mail(to: email, subject: 'Welcome to My Track Progress')
    end
end
