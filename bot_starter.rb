#!/usr/bin/env ruby
#coding: utf-8

$dirname = "/home/mirmik/project/atom_telegram_bot/"

require "fileutils"

FileUtils::mkdir_p $dirname + "logs"
log = File.new $dirname + "logs/starter", "a"

loop do
	log.puts "start bot at #{Time.now}"
	log.puts
	#ret = `./bot.rb`
	ret = system($dirname + "bot.rb", out: $stdout, err: :out)
	log.puts "finish bot #{Time.now}"

	puts ret

	if ret == false then
		log.puts "finish starter at #{Time.now}"
		exit 0 
	end
end