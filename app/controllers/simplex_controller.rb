require 'simplex/simplex'

class SimplexController < ApplicationController
  
  def index

  end

  def max
    @matrix_step_by_step = Simplex::Simplex.run(params[:expression], params[:restrictions], params[:action])

    render layout: false
  end

  def min
    @matrix_step_by_step = Simplex::Simplex.run(params[:expression], params[:restrictions], params[:action])
    
    render layout: false
  end

end
