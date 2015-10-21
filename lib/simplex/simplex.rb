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

    # Min Z = -3x1 - 5x2
    #         x1 <= 4
    #         x2 <= 6
    #         3x1 + 2x2 <= 18

    # | Base | x1 | x2 | f1 | f2 | f3 | B  |
    # | f1   | 1  | 0  | 1  | 0  | 0  | 4  |
    # | f2   | 0  | 1  | 0  | 1  | 0  | 6  |
    # | f3   | 3  | 2  | 0  | 0  | 1  | 18 |
    # | Z    | -3 | -5 | 0  | 0  | 0  | 0  |

    def self.simplex_table(expression, restrictions = [], action)

      restrictions = restrictions.compact.reject(&:blank?)

      expression = expression.gsub(/[\s\*]/, '').strip
      restrictions.map do |r|
        r.gsub!(/[\s\*]/, '').strip!
      end
      
      values    = expression.scan(/\-*\w*\,*\.*\w+/)      # [Array] values for each variable of the expression. Ex: ['3x1', '5x2'].
      variables = expression.scan(/[a-zA-Z]\d*/) # [Array] the variables of the expression. Ex: ['x1', 'x2'].

      breaks = []                                        
      restrictions.each_with_index do |restriction, idx| # [Array] all the breaks of the restrictions.
        breaks << "f#{idx+1}"                            # Ex: ['f1','f2','f3'].
      end

      @breaks = breaks.clone # Store the break values for further use.                                                

      matrix =  []                                    # [Array] the initial array to represent the table.
      matrix << ["Base"] + variables + breaks + ["B"] # [Array] first row of the table.

      (breaks.size + 1).times do |idx|                  
        matrix << Array.new(matrix[0].size) { |el| 0.to_f } # [Array] an array of arrays to represent the table filled with 0.
      end                                              

      breaks.each_with_index do |brk, idx| # Fill the first column with breaks.  
        matrix[idx+1][0] = brk             
      end                                  

      if action == "max"
        matrix.last[0] = "Z"
      else
        matrix.last[0] = "-Z"
      end

      values.each_with_index do |value, idx|
        val = value.match(/(^-*\d*\,*\.*\d*)[a-zA-Z].*/)[1] # Fill the last row with the values.

        val.gsub!(/\,/, '.')
          
        if val.empty?
          val = 1.0
        elsif val == "-"
          val = -1.0
        else
          val = val.to_f
        end

        if action == "max"
          matrix.last[idx+1] = val * -1
        else
          matrix.last[idx+1] = val
        end

      end

      @last_column_values = []

      restrictions.each_with_index do |restriction, idx| # Fill the rest of the table.

        pos = matrix[0].find_index("f#{idx+1}") # Fill the value of the breaks.
        matrix[idx+1][pos] = 1.to_f

        restriction_value = restriction.match(/\d+$/)[0].to_f

        matrix[idx+1][-1] = restriction_value # Fill the last column with the values.
        @last_column_values << restriction_value # Store the last column values for the sensibility table.

        variables.each do |variable|

          if restriction.match(/.*#{variable}.*/)
            pos     = matrix[0].find_index(variable)
            element = restriction.match(/(^*-*\d*)#{variable}.*/)[1] # Fill the variables values.

            if element.empty?
              matrix[idx+1][pos] = 1.to_f
            elsif element == "-"
              matrix[idx+1][pos] = -1.to_f
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

    def self.column_stop_condition(array = [])
      array.each_with_index do |el, idx|
        if el != nil
          if el <= 0
            array[idx] = nil
          end
        end
      end

        array.compact!
        array.empty?
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

      # if var_in_column only has negative values, exit.
      if column_stop_condition(var_in_column.clone)
        matrix[-1][-1] = nil
        return matrix
      end

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

    def self.sensibility(matrix = [], restriction_values = [], break_values = [], restrictions_limit_vars = [])

      sensibility_matrix = []
      sensibility_matrix << ["Sensibilidade", "Preço Sombra", "Limite", "Valor"]

      matrix[1...-1].size.times do |idx|
        sensibility_matrix << Array.new(4) { |el| "R#{idx+1}" }
      end

      # Calculate limits
      limits = []
      restrictions_limit_vars[0...-1].each_with_index do |array, idx|
        
        limits << []
        limit_values = []
        array.each_with_index do |value, value_idx|
          if value != 0
            limit_values << (restrictions_limit_vars[-1][value_idx] / value * -1).round(0)
          end
        end

        limits[idx] << limit_values.max
        limits[idx] << limit_values.min
      end

      sensibility_matrix[1..-1].each_with_index do |array, idx|

        array[1] = break_values[idx]

        if restriction_values[idx] == nil
          array[-1] = @last_column_values[idx]
        else
          array[-1] = @last_column_values[idx] - restriction_values[idx]
        end        

        if array[1] != 0
          array[2] = "#{array[-1] + limits[idx].min} - #{array[-1] + limits[idx].max}"
        else
          array[2] = "-"
        end
      end

      sensibility_matrix
    end

    def self.run(expression, restrictions = [],  action)

      matrix_step_by_step = []
      loop_count          = 0

      matrix_step_by_step << simplex_table(expression, restrictions, action)

      while stop_condition(matrix_step_by_step[-1][-1])
        
        if matrix_step_by_step[-1][-1][-1] == nil
          matrix_step_by_step.pop
          return matrix_step_by_step
        end

        loop_count += 1
        if loop_count > 20
          return matrix_step_by_step
        end

        a = copy_matrix(matrix_step_by_step[-1])

        matrix_step_by_step << simplex(a)
      end

      last = copy_matrix(matrix_step_by_step[-1])

      restriction_values = []
      last[1...-1].each do |array|
        if array[0] =~ /f.*/
          restriction_values[array[0].gsub(/\D/, '').to_i - 1] = array[-1]
        end  
      end

      break_indexes = []
      break_values  = []
      @breaks.each do |value|
        break_indexes << last[0].find_index(value)
        break_values << last[-1][last[0].find_index(value)].round(3)
      end

      break_indexes << -1

      restrictions_limit_vars = []
      break_indexes.each_with_index do |br_val, br_idx|
        
        restrictions_limit_vars << []
        last[1...-1].each_with_index do |array, idx|
          restrictions_limit_vars[br_idx] << array[br_val].round(3)
        end
      end

      matrix_step_by_step << sensibility(last, restriction_values, break_values, restrictions_limit_vars)
    end

  end

end


