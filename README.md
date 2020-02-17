# fetch-live-tweets

This is a Ruby console application that allows you to get live tweets on up to 5 topics saved to TXT files.

You'll be prompted to enter comma-separated topics you'd like to follow. 
The app will start fetching tweets and writing to the current directory until system exit. 

Each topic will have its own file.

## Dependencies

This app requires that you have the [twitter](https://github.com/sferik/twitter) gem installed.
```bash
gem install twitter
```

It also requires that you have the following Twitter credentials environment variables set. You can apply for the credentials [here](https://developer.twitter.com/en/apply-for-access).

```
TWITTER_CONSUMER_KEY
TWITTER_CONSUMER_SECRET
TWITTER_ACCESS_TOKEN
TWITTER_ACCESS_TOKEN_SECRET
```

## Usage

```ruby
ruby app.rb
```
