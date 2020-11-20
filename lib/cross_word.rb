# frozen_string_literal: true

class CrossWord
  SPACE_CHAR = ' '

  def initialize(*args)
    args = args.flatten
    # puts "args:#{args}"
    return if args.size < 2

    args.each_with_index do |element, indx|
      puts "word #{indx + 1} is:#{element}"
    end
    puts '-' * args[0]&.length unless args[0].nil?
    arr = CrossWord.build_array(args[0]&.downcase, args[1]&.downcase)
    puts arr
  end

  class << self
    def process(first_word, second_word)
      return '' if first_word.nil? || first_word.empty?
      return '' if second_word.nil? || second_word.empty?

      arr = build_array(first_word, second_word)
      arr.each do |line|
        puts line
      end
      nil
    end

    # Check for the EARLIEST instance of intersection
    # Calculate this by running scale, which takes the sum of the squares
    # of the array, and select the smaller one
    def find_intersection(first_arr, second_arr)
      first_index_arr = find_intersection_first(first_arr, second_arr)
      second_index_arr = find_intersection_reverse(first_arr, second_arr)
      if scale(first_index_arr) < scale(second_index_arr)
        first_index_arr
      elsif scale(second_index_arr) < scale(first_index_arr)
        second_index_arr
      else
        first_index_arr
      end
    end

    def find_intersection_first(first_arr, second_arr)
      intersect_arr = []
      first_arr.to_a.each_with_index do |first_char, first_index|
        second_arr.to_a.each_with_index do |second_char, second_index|
          return [first_index, second_index] if first_char == second_char
        end
      end
      intersect_arr
    end

    def find_intersection_reverse(first_arr, second_arr)
      intersect_arr = []
      second_arr.to_a.each_with_index do |second_char, second_index|
        first_arr.to_a.each_with_index do |first_char, first_index|
          return [first_index, second_index] if first_char == second_char
        end
      end
      intersect_arr
    end

    # Earliest instance probably found by squaring each element, summing the squares,
    # and selecting the smaller value
    def scale(arr)
      arr.sum(0){ |e| e * e } if arr.is_a?(Array)
    end

    def build_array(first_word, second_word)
      first_word_arr = first_word&.split('')
      second_word_arr = second_word&.split('')
      output_arr = find_intersection(first_word_arr, second_word_arr)
      first_word_start_index = output_arr[1]
      second_word_start_index = output_arr[0]
      add_lines_to_array(first_word_arr, first_word_start_index, second_word_arr, second_word_start_index)
    end

    # first word starts at second index number from the top
    # second word starts at first index number from the left
    #
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength
    def add_lines_to_array(first_word_arr, first_wrd_strt_indx, second_word_arr, second_wrd_strt_indx)
      arr = []
      return arr if first_word_arr.nil? || first_word_arr.empty?
      return arr if second_word_arr.nil? || second_word_arr.empty?

      (0..second_word_arr.length - 1).each do |second_index|
        line_str = ''
        (0..first_word_arr.length - 1).each do |first_index|
          line_str += if second_index == first_wrd_strt_indx
                        first_word_arr[first_index]
                      elsif first_index == second_wrd_strt_indx
                        second_word_arr[second_index]
                      else
                        SPACE_CHAR
                      end
        end
        arr << line_str
      end
      arr
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end

CrossWord.new(ARGV)
