require 'active_record'

ActiveRecord::Base.establish_connection({
	:adapter => "postgresql",
	:database => "pubwlkr"
})

ActiveRecord::Base.logger = Logger.new(STDOUT)