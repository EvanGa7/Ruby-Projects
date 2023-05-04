#rubyex1.rb - parse MU news using regex
#Evan Gardner
#s1270495
#CS-371
#Spring 2023

#read the html file as a file object
f = File.new('munews.html', 'r')
html=f.read # read f as one big string
#puts html

#alternatively , could use STDIN to read from the keyboard
#html = $stdin.read    # use built in global variable $stdin

#create titles regex pattern object
title_re = %r|target="_self" >(.+?)</a></h2>|
titles = html.scan(title_re)
#puts titles
#print titles    #using print shows the titles is an array of arrays

#create link regex pattern object
link_re = %r|<a href="(.+?)" target="_self">|
links = html.scan(link_re)
#puts links

#iterate through the lists to print the titles and links
titles.each do |title|
    puts title
end

for link in links
    puts link
end

# create newsfeed hash
newsfeed = {}   #start with an empty hash
ind = 0
titles.each do |title|
    newsfeed[title] = links[ind]      #add a key/value pair to the hash
    # newsfeed[title] = links[index]    #this is the same as the above line
    ind += 1  #ind++ works also
end

