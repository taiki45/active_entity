# ActiveEntity

To make an entity with ease according to ActiveModel way.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_entity'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_entity

## Synopsis

```ruby
class Message
  include ActiveEntity::Entity

  attribute :title
  attribute :body

  identity_attribute :title

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
end

message = Message.new(title: 'A README of ActiveEntity')
message.valid? #=> false
message.errors #=> returns a ActiveModel::Errors

message = Message.new(title: 'A README of ActiveEntity', body: 'No contents!')
message.valid? #=> true
message.attributes #=> { title: "A README of ActiveEntity", body: "No contents!" }

another_messsage = Message.new(title: 'A README of ActiveEntity', body: '')
message == another_messsage #=> true
```

## Contributing

1. Fork it ( https://github.com/taiki45/active_entity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
