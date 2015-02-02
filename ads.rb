require 'rubygems'
require 'httparty'
require 'date'
require 'fileutils'
require 'pry'

urls = [
    'http://pastebin.com/raw.php?i=7G8f8S2W', 
    'https://easylist-downloads.adblockplus.org/fb_annoyances_full.txt'
]

header = <<-SQL
[Adblock]
! Homepage: https://github.com/hnq90/fmsf/
! Title: FMSF 2.0
! Expires: 1 days
! Version: 2.0
! Last modified: #{DateTime.now}
! ============================== Different ====================================
SQL

def process_res(str, count)
    File.write("file_#{count}", str)
end

def process_file(file, count)
    File.read("file_#{count}")
end

fullstr = "" << header
i = 0
urls.each do |u|
    i += 1
    res = HTTParty.get(u)
    process_res(res, i)
end

j = 0
IO.foreach("file_1") do |line|
    j += 1
    if j > 7
        fullstr << line
    end
end

fullstr << "\n!Facebook Filters\n"

k = 0
IO.foreach("file_2") do |line|
    k += 1
    if k > 6
        fullstr << line
    end
end

File.delete("filter.txt")
File.write("filter.txt", fullstr)

`git add -A && git commit -m "Update filter.txt && git push origin master"`

