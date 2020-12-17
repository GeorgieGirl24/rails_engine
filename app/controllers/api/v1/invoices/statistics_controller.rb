class Api::V1::Invoices::StatisticsController < ApplicationController
  def most_expensive
    quantity = params[:quantity]
    render json: InvoiceSerializer.new(Invoice.most_expensive(quantity))
    # binding.pry
  end
end
