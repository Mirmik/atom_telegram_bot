require 'fileutils'
require "yaml"

$__chats = {}

def chats
	return $__chats
end

def chats_initialize
	Dir.foreach "./chats" do |file|
		next if file == "." or file == ".." 
		chat = YAML::load(File.new("./chats/#{file}").read())
		chats[chat.chat.id] = chat

		puts "load chat #{chat.chat.id}, #{chat.chat.username}"
	end
end

class Chat
	attr_accessor :chat

	def initialize
		puts "empty chat"
	end

	def initialize(chat)
		if chat == nil then return end
		@chat = chat
		puts "new chat initialize id: #{@chat.id}, username: #{@chat.username}"
		chatfile = File.new "./chats/#{@chat.id}", "w"
		chatfile.puts YAML::dump(self)
	end

	def receive(message)
		print("#{@chat.id}@#{@chat.username}$ ")
		puts "#{message.text}"

		if message.text == "/stop" then delete_chat @chat.id end
		
		broadcast_message("mirmik")
	end
end