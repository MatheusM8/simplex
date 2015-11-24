class KnapsackController < ApplicationController
  
  def table
  end

  def calc
    @matrix = Knapsack::Knapsack.knapsack_table(params[:capacity], params[:weights], params[:values])

    puts @matrix

    render layout: false
  end

end
