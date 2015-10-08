#
# Simplex v1.0
#
# Cesar Torralvo
# Gabriel Caires
# Vitor Derobe
#

module Simplex

  class Simplex

    # Max Z = 3x1 + 5x2
    #         x1 <= 4
    #         x2 <= 6
    #         3x1 + 2x2 <= 18

    # | Base | x1 | x2 | f1 | f2 | f3 | B  |
    # | f1   | 1  | 0  | 1  | 0  | 0  | 4  |
    # | f2   | 0  | 1  | 0  | 1  | 0  | 6  |
    # | f3   | 3  | 2  | 0  | 0  | 1  | 18 |
    # | Z    | -3 | -5 | 0  | 0  | 0  | 0  |

    def self.simplex_table(expression, restrictions = [])
      
      values    = expression.scan(/\w+/)      # [Array] values for each variable of the expression. Ex: ['3x1', '5x2'].
      variables = expression.scan(/[a-z]\d*/) # [Array] the variables of the expression. Ex: ['x1', 'x2'].

      breaks = []                                        
      restrictions.each_with_index do |restriction, idx| # [Array] all the breaks of the restrictions.
        breaks << "f#{idx+1}"                            # Ex: ['f1','f2','f3'].
      end                                                

      matrix =  []                                    # [Array] the initial array to represent the table.
      matrix << ["Base"] + variables + breaks + ["B"] # [Array] first row of the table.

      (breaks.size + 1).times do |idx|                  
        matrix << Array.new(matrix[0].size) { |el| 0.to_f } # [Array] an array of arrays to represent the table filled with 0.
      end                                              

      breaks.each_with_index do |brk, idx| # Fill the first column with breaks.  
        matrix[idx+1][0] = brk             
      end                                  

      matrix.last[0] = "Z"

      values.each_with_index do |value, idx|
        matrix.last[idx+1] = value.match(/^\d+/)[0].to_f * -1 # Fill the last row with the values.
      end

      restrictions.each_with_index do |restriction, idx| # Fill the rest of the table.

        pos = matrix[0].find_index("f#{idx+1}") # Fill the value of the breaks.
        matrix[idx+1][pos] = 1.to_f

        matrix[idx+1][-1] = restriction.match(/\d+$/)[0].to_f # Fill the last column with the values.

        variables.each do |variable|

          if restriction.match(/.*#{variable}.*/)
            pos     = matrix[0].find_index(variable)
            element = restriction.match(/(\d*)#{variable}.*/)[1] # Fill the variables values.

            if element.empty?
              matrix[idx+1][pos] = 1.to_f
            else
              matrix[idx+1][pos] = element.to_f
            end 
          end

        end

      end

      matrix
    end

    def self.stop_condition(array =[])
      array[1..-1].each do |el|
        if el < 0
          return true
        end
      end

      false
    end

    def self.copy_matrix(x)
      copy = x.map do |el|
        el.map do |e|
          if e.class == Float
            e
          else
            e.dup
          end 
        end
      end
    end

    def self.simplex(matrix = [])

      #### while last row has negative values

      var_in     = matrix.last[1..-1].min
      var_in_idx = matrix.last.find_index(var_in)

      var_in_column = matrix[1..-1].map do |row|
        row[var_in_idx] if row[var_in_idx] > 0 
      end

      #### if var_in_column only has negative values, exit.

      var_out     = nil
      var_out_idx = nil
      matrix[1..-1].each_with_index do |row, idx|
        if var_in_column[idx] != nil
          var_out     ||= row[-1]/var_in_column[idx]
          var_out_idx ||= idx + 1

          if var_out > row[-1]/var_in_column[idx]
            var_out     = row[-1]/var_in_column[idx]
            var_out_idx = idx + 1
          end
        end
      end
      
      matrix[var_out_idx][0] = matrix[0][var_in_idx]

      pivo = matrix[var_out_idx][var_in_idx]

      matrix[var_out_idx][1..-1].each_with_index do |val, idx|
        matrix[var_out_idx][idx+1] = val/pivo
      end

      matrix[1..-1].each_with_index do |row, index|

        if index != var_out_idx -1
        
          el_to_turn_zero = row[var_in_idx]
          
          matrix[var_out_idx][1..-1].each_with_index do |el, el_idx|
            row[el_idx+1] = el * (el_to_turn_zero * - 1) + row[el_idx+1]
          end
        end
      end


      matrix
    end

    def self.run(expression, restrictions = [])

      matrix_step_by_step = []

      matrix_step_by_step << simplex_table(expression, restrictions)

      while stop_condition(matrix_step_by_step[-1][-1])
        a = copy_matrix(matrix_step_by_step[-1])
        matrix_step_by_step << simplex(a)
      end

      matrix_step_by_step
    end

  end

end


