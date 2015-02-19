require 'active_record'

if ENV["DB_INFO"]
	# when accessing in production
	ActiveRecord::Base.establish_connection ('postgresql://' + ENV["DB_INFO"] + '@127.0.0.1/pubwlkr')

	ActiveRecord::Base.logger = Logger.new(STDOUT)
else
	# when accessing in development
	ActiveRecord::Base.establish_connection ({
		:adapter => "postgresql",
		:database => "pubwlkr"
	})
	ActiveRecord::Base.logger = Logger.new(STDOUT)
end