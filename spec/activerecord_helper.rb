require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database:':memory:'
)

unless ActiveRecord::Base.connection.table_exists?(:users)
  ActiveRecord::Base.connection.create_table :users do |t|
    t.date   :dob
    t.string :last_name
    t.string :name
  end
end

class User < ActiveRecord::Base; end
