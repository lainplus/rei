#!/usr/bin/env ruby

`complete -o bashdefault -o default -o filenames -o nospace -C ~/.rei/autocomplete.rb rei`

if ARGV.length==0
  puts "rei: autocomplete installed."
  exit
end

words = ARGV[1..-1].reverse.join(" ")
last = ARGV[2]
current = ARGV[1]

if last == "rei"
  puts "count" if "count".start_with? current
  puts "find" if "find".start_with? current
  puts "show" if "show".start_with? current
  puts "what" if "what".start_with? current
  puts "convert" if "convert".start_with? current
end

if last == "count"
  puts "words" if "words".start_with? current
  puts "lines" if "lines".start_with? current
  puts "chars" if "chars".start_with? current
end

if last == "convert"
  `COMPREPLY=()`
end

