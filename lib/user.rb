require 'active_record'
require_relative '../db/connection.rb'

class User < ActiveRecord::Base
	has_secure_password
	self.has_many(:trips)
end