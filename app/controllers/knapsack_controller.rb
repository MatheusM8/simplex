class KnapsackController < ApplicationController
  
  def table
  end

  def calc
    @result, @matrix = Knapsack::Knapsack.knapsack_table(params[:capacity], params[:weights], params[:values])

    render layout: false
  end

end
