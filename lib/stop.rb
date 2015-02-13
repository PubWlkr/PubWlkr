require 'active_record'
require_relative '../db/connection.rb'

class Stop < ActiveRecord::Base
	belongs_to :bar
	belongs_to :trip
end