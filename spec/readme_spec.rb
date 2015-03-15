require 'spec_helper'

RSpec.describe 'README code snipets' do
  let(:readme) { File.read(File.expand_path('../../README.md', __FILE__)) }
  let(:code) { readme.slice(/^```ruby$\n(.*)^```$/m, 1) }

  it 'runs suceessfully' do
    eval(code)
  end
end
