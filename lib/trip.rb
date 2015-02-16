require 'active_record'
require_relative '../db/connection.rb'

class Trip < ActiveRecord::Base
	has_many :bars, {through: :stops}
	has_many :stops
	belongs_to :user
end