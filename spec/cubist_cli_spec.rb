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
  describe 'make a angle' do
    it 'when it gets the right flags' do
      run('--make_angle=features/coupons')
      angles = run('--get_angles').chomp
      expect(angles).to eq("features/coupons")
    end
  end
end
