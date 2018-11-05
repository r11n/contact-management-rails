class Admin::AllowedDomainsController < AdminController
    def index
        @domains = AllowedDomain.all
        render json: @domains
    end

    def save_domains
        @domains = AllowedDomain.save_domains(params.permit[:domains])
        render json: @domains
    end
end