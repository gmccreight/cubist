require_relative "./spec_helper"

describe Cubist do
  it 'has a version number' do
    expect(Cubist::VERSION).not_to be nil
  end
  describe 'cli' do
    def run(dir, command)
      `ruby -Ilib ./exe/cubist --dir=#{dir} #{command}`
    end
    describe 'show help' do
      it 'when it gets the right flags' do
        expect(run(temp_dir, '-h')).to match(/Usage:/)
        expect(run(temp_dir, '--help')).to match(/Usage:/)
      end
    end
    describe 'make a perspective' do
      it 'when it gets the right flags' do
        run(temp_dir, '--make_perspective=features/coupons')
        expect(`find #{temp_dir}`).to match(/features\/coupons\/.cubist_perspective/)
      end
    end
  end
end
