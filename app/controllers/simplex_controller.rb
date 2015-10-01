class SimplexController < ApplicationController
  
  def index
    @expressao = "2x + 3y"
    @tabela = ['1','2']
  end

  def max
    render layout: false
  end

  def min
    render layout: false
  end

end
