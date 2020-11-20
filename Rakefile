# frozen_string_literal: true

require 'rake'
require 'byebug'

namespace :crossword do
  desc 'run word1 word2'
  task :run do
    puts 'Inadequate number of arguments. Need two words.' if ARGV.length < 3
    exit if ARGV.length < 3

    ARGV.each { |a| task a.to_sym }
    ruby "./lib/cross_word.rb #{ARGV[1]} #{ARGV[2]}"
  end

  desc 'rspec {runs tests}'
  task :rspec do
    sh 'rspec ./spec/lib/cross_word_spec.rb'
  end

  desc 'cop {runs rubocop, a ruby linter}'
  task :cop do
    sh 'rubocop -a'
  end
end
