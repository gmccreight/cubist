require_relative "./spec_helper"

describe "cubist cli" do
  def run(command)
    `ruby -Ilib ./exe/cubist --dir=#{temp_dir} #{command}`
  end
  describe 'show help' do
    it 'when it gets the right flags' do
      expect(run('-h')).to match(/Usage:/)
      expect(run('--help')).to match(/Usage:/)
    end
  end
  describe 'make a perspective' do
    it 'when it gets the right flags' do
      run('--make_perspective=features/coupons')
      perspectives = run('--get_perspectives').chomp
      expect(perspectives).to eq("features/coupons")
    end
  end
end