class User < ApplicationRecord
    require "securerandom"
    

    has_many :facts
    has_and_belongs_to_many :categories
    accepts_nested_attributes_for :categories
    has_secure_password

    
end
