require 'pry'

class SessionsController < ApplicationController
  skip_before_action :authenticate_user


    def create
      client_id = ENV['GITHUB_CLIENT_ID']
      client_secret = ENV['GITHUB_CLIENT_SECRET']
      code = params['code']

      resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
        req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
        req.headers['Accept'] = 'application/json'
      end


      body = JSON.parse(resp.body)
      session[:token] = body['access_token']
      redirect_to root_path
    end

  # def authenticate_user
  #   if logged_in?
  #     render 'index'
  #   else
  #     resp = Faraday.get("https://github.com/login/oauth/authorize") do |req|
  #       req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
  #       # req.params['client_secret'] = ENV['GITHUB_SECRET']
  #       # req.params['grant_type'] = 'authorization_code'
  #       req.params['redirect_uri'] = "http://localhost:3000/auth"
  #       req.params['login'] = 'emilyjennings'
  #       # req.params['code'] = params[:code]
  #     end
  #
  #     body = JSON.parse(resp.body)
  #     @login = body["login"]
  #     redirect_to root_path
  #
  #   end
  # end

end
