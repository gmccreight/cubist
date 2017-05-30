require_relative "./cli_helper"

describe 'make a angle' do
  it 'when it gets the right flags' do
    run('--make_angle=features/coupons')
    angles = run('--get_angles').chomp
    expect(angles).to eq("features/coupons")
  end
end
