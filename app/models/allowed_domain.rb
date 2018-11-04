class AllowedDomain < ApplicationRecord
    validates_uniqueness_of :domain
end
