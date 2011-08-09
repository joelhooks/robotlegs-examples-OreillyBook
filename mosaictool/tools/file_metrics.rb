require 'find'

if ARGV.length != 2
  raise ArgumentError.new('Two arguments are required: path, extension')
end

path = ARGV[0]
extension = ARGV[1]

numFiles = 0
totalLines = 0

count_60_or_less = 0
count_61_to_70 = 0
count_71_to_80 = 0
count_81_or_more = 0

files_over_60_lines = []                                                  

Find.find(path) do |f|
  if File.file?(f) && File.fnmatch('*.' + extension, f)
    results = []
    
    File.new(f, "r").each { |line| results << line }
    
    lines = results.size
    totalLines += lines
                   
    if(lines <= 60 )
      count_60_or_less += 1
    elsif(lines <= 70)
      count_61_to_70 += 1
      files_over_60_lines.push( [lines, f])
    elsif(lines <= 80)
      count_71_to_80 += 1
      files_over_60_lines.push( [lines, f]) 
    else
      count_81_or_more += 1
      files_over_60_lines.push( [lines, f]) 
    end
      
    numFiles += 1
  end
end       

files_over_60_lines = files_over_60_lines.sort.reverse

puts ".#{extension} - #{numFiles} files"
puts "60 lines or less: #{count_60_or_less}"
puts "61 - 70 lines:    #{count_61_to_70}"
puts "71 - 80 lines:    #{count_71_to_80}"
puts "81 lines or more: #{count_81_or_more}"

puts "files over 60 lines (largest first): "
files_over_60_lines.each do |f|
  puts f 
end