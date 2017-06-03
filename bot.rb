#!/usr/bin/env ruby
#coding: utf-8

require 'telegram/bot'
require './chat.rb'

$botref = nil
tokenFile = File.new "token", "r" 
token = tokenFile.readline

def broadcast_message(text)
	chats().each do |key,c|
		$botref.api.sendMessage(chat_id: c.chat.id, text: "broadcast: " + text)
	end
end

def restart
	Thread.new do
		broadcast_message "system: restart"
		sleep 3
		exit 0
	end
end

def shutdown
	Thread.new do
		broadcast_message "system: shutdown"
		sleep 3
		exit 1
	end
end

def delete_chat(id)
	chats.delete id
	File.delete "./chats/#{id}"
	puts "chat #{id} was deleted"
end

def logmessage(message)
	puts "input message:"
	puts "\tid: " + message.chat.id.to_s
	puts "\ttext: " + message.text
end


dirpath = Dir.pwd + '/chats'
FileUtils::mkdir_p dirpath
chats_initialize

Thread.new do
	i = 0 
	loop do
		i = i + 1
		broadcast_message "empty thread spam #{i}"
		sleep 5
	end
end

Telegram::Bot::Client.run(token) do |bot|
	$botref = bot
	bot.listen do |message|
		id = message.chat.id

		if (chats()[id] == nil) then chats()[id] = Chat.new message.chat end
		chats()[id].receive message
	end
end