require 'spec_helper'

RSpec.describe ActiveEntity::Entity do
  let(:test_class) do
    Class.new do
      include ActiveEntity::Entity

      attribute :title
      attribute :body

      identity_attribute :title

      validates :title, presence: true, length: { maximum: 255 }
      validates :body, presence: true

      def self.name
        'Message'
      end
    end
  end

  specify 'it has all the basic features' do
    message = test_class.new(title: 'A README of ActiveEntity')
    expect(message).to be_invalid
    expect(message.errors).not_to be_empty

    message = test_class.new(title: 'A README of ActiveEntity', body: 'No contents!')
    expect(message).to be_valid
    expect(message.attributes).to eq(
      'title' => 'A README of ActiveEntity',
      'body' => 'No contents!',
    )

    another_messsage = test_class.new(title: 'A README of ActiveEntity', body: '')
    expect(message == another_messsage).to be_truthy
  end
end
