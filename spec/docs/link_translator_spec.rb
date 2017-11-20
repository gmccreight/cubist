require_relative '../spec_helper'

describe Cubist::Docs::LinkTranslator do
  before :each do
    @klass = Cubist::Docs::LinkTranslator
  end

  it 'should be able to identify that you are within the special link' do
    line = 'this [[logger.rb:/def readme/]] foo [[test.rb:/def yolo/]] bar'
    file, regex = @klass.link_regex_for(line: line, cursor_column: 0)
    expect(file).to eq(nil)
    file, regex = @klass.link_regex_for(line: line, cursor_column: 4)
    expect(file).to eq(nil)
    file, regex = @klass.link_regex_for(line: line, cursor_column: 5)
    expect(file).to eq('logger.rb')
    expect(regex).to eq('/def readme/')
    file, regex = @klass.link_regex_for(line: line, cursor_column: 30)
    expect(file).to eq('logger.rb')
    expect(regex).to eq('/def readme/')
    file, regex = @klass.link_regex_for(line: line, cursor_column: 31)
    expect(file).to eq(nil)
    file, regex = @klass.link_regex_for(line: line, cursor_column: 36)
    expect(file).to eq('test.rb')
    expect(regex).to eq('/def yolo/')
  end
end
