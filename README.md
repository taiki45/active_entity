# ActiveEntity

An extension for Active Model to encourage implementing entity.
It's like [Virtus gem](https://github.com/solnic/virtus) but more simple and
on Active Model way.

[![Build Status](https://travis-ci.org/taiki45/active_entity.svg?branch=master)](https://travis-ci.org/taiki45/active_entity) [![Coverage Status](https://coveralls.io/repos/taiki45/active_entity/badge.svg)](https://coveralls.io/r/taiki45/active_entity) [![Code Climate](https://codeclimate.com/github/taiki45/active_entity/badges/gpa.svg)](https://codeclimate.com/github/taiki45/active_entity) [![Gem Version](https://badge.fury.io/rb/active_entity.svg)](http://badge.fury.io/rb/active_entity)

## Installation

Add this line to your application's Gemfile:

```
gem 'active_entity'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_entity

## Synopsis

```ruby
# = Define model attributes with accessor and define identities =
class Message
  include ActiveModel::Model
  include ActiveEntity::Accessor
  include ActiveEntity::Identity

  attribute :title
  attribute :body

  identity_attribute :title

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
end

message = Message.new(title: 'A README of ActiveEntity')
expect(message.valid?).to be_falsy
expect(message.errors).to be_a(ActiveModel::Errors)

message = Message.new(title: 'A README of ActiveEntity', body: 'No contents!')
expect(message.valid?).to be_truthy
expect(message.attributes).to eq({ "title" => "A README of ActiveEntity", "body" => "No contents!" })

another_messsage = Message.new(title: 'A README of ActiveEntity', body: '')
expect(message).to eq(another_messsage)


# = Coercion =
class Person
  include ActiveModel::Model
  include ActiveEntity::Accessor
  include ActiveEntity::Coercion

  attribute :name, type: String
  attribute :age, type: Integer
end

alice = Person.new(name: 'Alice', age: '1')
expect(alice.name).to eq('Alice')
expect(alice.age).to eq(1)


# = Typecasting =
class Recipe
  include ActiveModel::Model
  include ActiveEntity::Accessor
  include ActiveEntity::Typecasting

  attribute :title, type: String
  attribute :steps, type: Integer
  attribute :likes, type: Integer
end

waffle = Recipe.new(title: 'Waffle', steps: '12', likes: 'abc')
expect { waffle.cast! }.to raise_error(ActiveEntity::CastError)

expect(waffle.title).to eq('Waffle')
expect(waffle.steps).to eq('12')  #=> rollbacks casted value on error
expect(waffle.likes).to eq('abc')
```

## TODOs
- `to_param` helper.
- Default value support.
- Custom coercion with object.
- Value object.
- Docs for typecasting custom procedures.

## Contributing

1. Fork it ( https://github.com/taiki45/active_entity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
