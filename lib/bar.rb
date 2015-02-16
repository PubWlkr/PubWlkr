require 'active_record'
require_relative '../db/connection.rb'

class Bar < ActiveRecord::Base
	has_many :trips, {through: :stops}
	has_many :stops
end
