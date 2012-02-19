exit 0

def debug(content)
  puts content
end

def unshelve_change(unshelved_change_num)
  `p4 unshelve -s "#{unshelved_change_num}"`
end

def dump_changes_to_files(default_output_fn, unshelved_output_fn, unshelved_change_num)
  `p4 change -o > "#{default_output_fn}"`
  `p4 change -o "#{unshelved_change_num}" > "#{unshelved_output_fn}"`
end

def read_desc(filename)
  desc_label = "Description:"
  desc_content = ""
  desc_started = false
  File.open(filename, 'r') do |infile|
    while (line = infile.gets)
      desc_content = desc_content + line if desc_started
      if line.start_with? (desc_label)
        desc_started = true
      end 
    end
  end
  desc_content
end

def rewrite_pending_change(default_output_fn, desc_content, new_output_fn)
  desc_label = "Description:"
  desc_started = false
  new_change = ""

  File.open(default_output_fn, 'r') do |infile|
    while (line = infile.gets)
      if desc_started
        new_change = new_change + desc_content if desc_started
        desc_started = false
      else
        new_change = new_change + line
      end

      if line.start_with? (desc_label)
        desc_started = true
      end
    end
  end

  File.open(new_output_fn, 'w') {|f| f.write(new_change)}
end

def submit_change(change_spec_file)
  `p4 submit -i < "#{change_spec_file}"`
end

if ARGV.nil? || ARGV.length != 1
  puts "Wrong arguments"
  puts "Example: ruby p4dq.rb 158616"
  exit 1
end

output_file = "output/p4_change_output"
new_output_file = "output/p4_change_output_new"
unshelved_file = "output/p4_change_output_unshelved"
unshelved_num = ARGV[0]

unshelve_change(unshelved_num)
dump_changes_to_files(output_file, unshelved_file, unshelved_num)
description = read_desc unshelved_file
debug description
rewrite_pending_change(output_file, description, new_output_file)
submit_change(new_output_file)

