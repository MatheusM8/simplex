#
# Knapsack v1.3
#
# Cesar Torralvo
# Gabriel Caires
# Vitor Derobe
#

module Knapsack

  class Knapsack

    # weight | cost
    # 1      | 31
    # 2      | 47
    # 3      | 14

    #   | 0 | 1  | 2  | 3  | 4
    # 0 | 0 | 0  | 0  | 0  | 0
    # 1 | 0 | 14 | 14 | 14 | 14
    # 2 | 0 | 14 | 31 | 45 | 45
    # 3 | 0 | 14 | 31 | 47 | 61

    def self.knapsack_table(capacity, weights = [], values = [])

      capacity = capacity.gsub(/[\s\*]/, '').strip
      weights  = weights.compact.reject(&:blank?)
      values   = values.compact.reject(&:blank?)

      # capacity = 4
      # weights  = %w{ 2 3 1 }
      # values   = %w{ 31 47 14}

      # capacity = 23
      # weights  = %w{ 1 2 5 6 7 9 11 }
      # values   = %w{ 1 6 18 22 28 40 60}

      @wc_hsh = Hash[weights.zip values]

      matrix = []
      # matrix << Array.new(capacity+1) { |idx| idx }

      weights_int = weights.map do |item|
        item.to_i
      end

      (weights_int.max+1).times do |item| 
        matrix << Array.new(capacity.to_i+1, 0)
      end

      fill_table(matrix)
    end

    def self.fill_table(matrix)
      matrix.each_with_index do |line, weight|
        line.each_with_index do |item, idx|
          
          if weight.to_i <= idx.to_i
            value = @wc_hsh[weight.to_s].to_i
            if weight == 0
              value = 0
            elsif value.nil?
              value = matrix[weight-1][idx]
            elsif weight.to_i < idx.to_i
              diff  = idx.to_i - weight.to_i
              value = value.to_i + matrix[weight-1][diff].to_i
            end
            
            if value < matrix[weight-1][idx].to_i
              value = matrix[weight-1][idx].to_i
            end
            
          else
            value = matrix[weight-1][idx]
          end

          matrix[weight][idx] = value.to_s
        end
      end

      matrix.each do |line|
        p line
      end

      find_itens(matrix)
    end

    def self.find_itens(matrix)
      i = matrix.size-1
      j = matrix.last.size-1

      result = []

      begin 
        if matrix[i][j] != matrix[i-1][j]
          result << { i.to_s => @wc_hsh[i.to_s] }
          j -= i
          i -= 1
        else
          i -= 1
        end
      end while i > 0

      result
    end

  end
end
