require_relative "./cli_helper"

describe 'show help' do
  it 'when it gets the right flags' do
    expect(run('-h')).to match(/Usage:/)
    expect(run('--help')).to match(/Usage:/)
  end
end
