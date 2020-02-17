require 'twitter'

class StreamingService
  MAX_TOPIC_COUNT = 5

  def initialize
    build_client
  end

  def track(topics)
    topics_array = topics.split(",").first(MAX_TOPIC_COUNT).map(&:strip)

    threads = []
    topics_array.each do |topic|
      threads << Thread.new do
        File.open("#{topic}.txt", "w") do |file|
          client.filter(track: topic) do |object|
            # puts "#{topic}: #{object.text}"
            file.puts(object.text) if object.is_a?(Twitter::Tweet)
            # Add a blank line to make reading tweets easier
            file.puts("")
          end
        end
      end
    end
    threads.each(&:join)
  end

  private

  attr_reader :client

  def build_client
    @client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end

begin
  # prompt user to enter a topic
  puts "Welcome to Tweet Steaming!"
  puts ""
  puts "You can get live tweets for up to 5 topics."

  puts ""
  print "You can enter up to 5 topics separated by commas to follow: "
  topics = gets.chomp.strip

  puts ""
  puts "We're streaming tweets related to the first 5 topics you entered..."
  puts ""
  puts "You can stop the application at any time."

  streaming_service = StreamingService.new
  streaming_service.track(topics)
# Gracefully close the application
rescue Interrupt
  puts ""
  puts "Goodbye! Files with the fetched tweets have been saved in the current directory."
end
