class AllowedDomain < ApplicationRecord
    validates_uniqueness_of :domain

    def self.save_domains(domain_params)
        domains = domain_params[:domains].uniq.map{|k| k.strip}.reject{|l| !l.present? }
        prev_domains = self.all.pluck(:domain)
        new_domains = domains - prev_domains
        del_domains = prev_domains - domains
        AllowedDomain.where(domain: del_domains).delete_all
        AllowedDomain.import(new_domains.map{|k| AllowedDomain.new(domain: k)})
    end
end
