#!/usr/bin/env ruby
#coding: utf-8

require "fileutils"

FileUtils::mkdir_p "./logs"
log = File.new "./logs/starter", "w"

loop do
	log.puts "start bot at #{Time.now}"
	log.puts
	#ret = `./bot.rb`
	ret = system("./bot.rb", out: $stdout, err: :out)
	log.puts "finish bot #{Time.now}"

	puts ret

	if ret == false then
		log.puts "finish starter at #{Time.now}"
		exit 0 
	end
end