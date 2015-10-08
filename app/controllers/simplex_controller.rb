require 'simplex/simplex'

class SimplexController < ApplicationController
  
  def index

  end

  def max
    @matrix_step_by_step = Simplex::Simplex.run(params[:expression], params[:restrictions])

    render layout: false
  end

  def min
    render layout: false
  end

end
