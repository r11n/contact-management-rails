class Admin::AllowedDomainsController < AdminController
    def index
        @domains = AllowedDomain.all.pluck(:domain)
        render json: {domains: @domains}
    end

    def save_domains
        @domains = AllowedDomain.save_domains(params[:domains] || [])
        render json: {domains: @domains}
    end
end