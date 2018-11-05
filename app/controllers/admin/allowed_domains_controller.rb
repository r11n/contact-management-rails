class Admin::AllowedDomainsController < AdminController
    def index
        @domains = AllowedDomain.all
        render json: @domains
    end

    def save_domains
    end
end