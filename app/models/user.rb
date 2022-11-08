class User < ApplicationRecord
  has_one :profile
  has_many :emergency_contacts
  has_many :conditions
  has_many :doctors
  has_many :consultations
  has_many :admssions

  
end
