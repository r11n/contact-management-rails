class AdminController < ApplicationController
    before_action :verify_admin
end