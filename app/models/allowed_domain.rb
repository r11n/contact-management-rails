class AllowedDomain < ApplicationRecord
    validates_uniqueness_of :domain
    validates_presence_of :domain

    def self.save_domains(domain_params)
        puts domain_params
        puts '---------------------------------'
        domains = domain_params.uniq.map{|k| k.strip}.reject{|l| !l.present? }
        prev_domains = self.all.pluck(:domain)
        new_domains = domains - prev_domains
        del_domains = prev_domains - domains
        AllowedDomain.where(domain: del_domains).delete_all
        AllowedDomain.import(new_domains.map{|k| AllowedDomain.new(domain: k)})
        return self.all.pluck(:domain)
    end
end
