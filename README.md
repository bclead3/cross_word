This project generates an array of two words, with the earliest intersection of the same
character.

There are a couple of ways this could be run. There are Rake tasks defined in a Rakefile at 
the base of the project. By running `rake -T` we see three tasks
```bazaar
% rake -T
rake crossword:cop    # cop {runs rubocop, a ruby linter}
rake crossword:rspec  # rspec {runs tests}
rake crossword:run    # run word1 word2
```

if one types in `rake crossword:run dad road` the output is
```bazaar
% rake crossword:run dad road
/Users/a_user_name/.rvm/rubies/ruby-2.6.3/bin/ruby ./lib/cross_word.rb dad road
word 1 is:dad
word 2 is:road
---
 r 
 o 
dad
 d 
```
One can also directly run the script by typing
`ruby ./lib/cross_word.rb balloon bat`

giving output

```bazaar
 % ruby ./lib/cross_word.rb balloon bat
word 1 is:balloon
word 2 is:bat
-------
balloon
a     
t     
```
To run the tests, run `rake crossword:rspec`
It should generate a coverage report in `/coverage/index.html`

To run Rubocop, a Ruby linter, run `rake crossword:cop`
