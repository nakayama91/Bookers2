class ApplicationController < ActionController::Base
    
    #deviseコントローラーの修正
    #初期設定では用意されていないカラムを追加したので、下記を追記
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
