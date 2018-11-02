require "adamite"

class Registration < Granite::Base
  adapter sqlite
  table_name registration

  primary id : Int64
  field internal_id : String
  field address : String
  field username : String
end
