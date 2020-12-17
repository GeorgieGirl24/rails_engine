class ApplicationController < ActionController::API
  def self.reset_primary_key(model_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(model_name)
  end
end
