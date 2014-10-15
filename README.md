# Nntp::Client

This gem is a lightweight solution for connecting to a NNTP-Server and retrieving news

## Installation

Add this line to your application's Gemfile:

    gem 'nntp-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nntp-client

## Usage

NNTP::Client::Session provides a simple API for retrieving newsgroups and posts from a NNTP-Server

```ruby
NNTP::Client::Session.start("some.nntp.host") do |nntp|
  # Fetch all newsgroups
  nntp.newsgroups

  # Fetch specific newsgroup
  group = nntp.group "some.news.group"
  group.posts.each do |post|
    # get the contents of a post
    post.raw
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
