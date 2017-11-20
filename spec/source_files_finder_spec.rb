require_relative './spec_helper'

describe Cubist::SourceFilesFinder do
  before :each do
    @finder = Cubist::SourceFilesFinder.new(conf: conf)
  end

  it 'should get all the files' do
    file_and_link('app/models/item.rb', 'availability/models/item.rb')
    expect(@finder.run.size).to eq(1)
    file_and_link('app/models/product.rb', 'availability/models/product.rb')
    expect(@finder.run.size).to eq(2)
  end

  it 'should be able to resolve the symlink' do
    file_and_link('app/models/item.rb', 'availability/models/item.rb')
    expect(@finder.run.size).to eq(1)
    expect(File.readlink(@finder.run.last)).to eq(project_dir + '/app/models/item.rb')
  end

  describe 'angle files' do
    it 'should find them' do
      make_angle_file_at('availability')
      file_and_link('app/models/item.rb', 'availability/app/models/item.rb')

      make_angle_file_at('items')
      file_and_link('app/models/item.rb', 'items/app/models/item.rb')

      make_angle_file_at('features/cops_interface')
      file_and_link('app/models/item.rb', 'features/cops_interface/app/models/item.rb')

      make_angle_file_at('features/messaging')
      file_and_link('app/models/item.rb', 'features/messaging/app/models/item.rb')

      expect(@finder.get_angles.size).to eq(4)
    end
  end
end
