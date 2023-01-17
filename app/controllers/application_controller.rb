class ApplicationController < ActionController::Base
    before_action :authorize,except: %i[login]
    private
    def encode_token(payload)
        JWT.encode(payload,'secret')
    end    

    def decode_token
        auth = request.headers['Authorization']
        if auth
            token = auth.split(' ')[1]
            begin
                JWT.decode(token,'secret',true,algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end 
    end 

    def authorized_user
        decoded_token = decode_token()
        if decoded_token
            user = decoded_token[0]['user']
            @user = User.find_by(id:user)
        end   
    end

    def authorize
        render json: {message: "Please loged in"},status: :unauthorized unless authorized_user
    end


end
