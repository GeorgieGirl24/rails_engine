# before running "rake db:seed", do the following:
# - put the "rails-engine-development.pgdump" file in db/data/
# - put the "items.csv" file in db/data/
Transaction.destroy_all
InvoiceItem.destroy_all
Invoice.destroy_all
Item.destroy_all
Merchant.destroy_all
Customer.destroy_all

require 'csv'

cmd = 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails_engine_development db/data/rails-engine-development.pgdump'
puts 'Loading PostgreSQL Data dump into local database with command:'
puts cmd
system(cmd)

CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|
  row['unit_price'] = (row['unit_price'].to_f / 100).round(2)
  Item.create(row.to_h)
end

ActiveRecord::Base.connection.reset_pk_sequence!('customers')
ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
ActiveRecord::Base.connection.reset_pk_sequence!('items')
ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
# TODO
# - Import the CSV data into the Items table
# - Add code to reset the primary key sequences on all 6 tables (merchants, items, customers, invoices, invoice_items, transactions)
