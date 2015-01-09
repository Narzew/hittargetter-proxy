#**Hit Targetter Proxy Ultimate by Narzew. All rights reserved! Use at your own risk!
require 'open-uri'
print ("*"*60<<"\n"<<"**Hit Targetter Proxy Ultimate\n"<<"**by Narzew\n"<<"**28.09.2013\n"<<"**I don\'t take responsibility for this software!\n**All responsibility takes user!\n**Use at your own risk!\n"<<"*"*60<<"\n")
sleep(5)
if ARGV[0] == nil || ARGV[1] == nil
	print "Enter path to file containing proxy with format ip:port :\n"
	$proxyfile = ($stdin.gets.chomp!).to_s
	print "Enter the target site :\n"
	$site = ($stdin.gets.chomp!).to_s
	print "\n"
else
	$proxyfile,$site = ARGV[0].to_s,ARGV[1].to_s
end
$goodproxies = ""
File.open($proxyfile,'rb'){|f|$proxy=f.read}
$proxy.each_line{|x|
	a = x.split(":")
	ip = a[0]
	port = a[1]
	Thread.new{lambda{
	proxy_uri = URI.parse("http://#{ip}:#{port}")
	hit = open($site, :proxy_http_basic_authentication => [proxy_uri, "", ""]).read
	lambda{$goodproxies<<"#{ip}:#{port}";print "Hit from #{ip}:#{port}".gsub("\n","")<<("\n")}.call
	}.call rescue lambda{}.call }
}
sleep(60)
puts "Saving proxy..."
file = File.open("GoodProxy.txt","wb"){|f|f.write($goodproxies)}
puts "Done."
exit
