require_relative '../spec_helper'

module Cubist
  describe Docs::LinkToFileLine do
    before :each do
      @klass = Docs::LinkToFileLine
      @aliases = [
        Alias.new(
          'folder1',
          'file1',
          'folder1',
          'file1',
          "line0\nline1\nline2\n"
        ),
        Alias.new(
          'folder2',
          'file2',
          'folder2',
          'file2',
          "line0\nline1\nline2\n"
        )
      ]
    end

    context 'cursor on the link' do
      def link_for_doc_content(readme)
        @klass.dest_for(
          doc_content: readme,
          row: 0,
          column: 9,
          aliases: @aliases
        )
      end

      it 'should be able to identify the whole file you should go to if no regex' do
        readme = 'Before [[file1]] after'
        result_hash = link_for_doc_content(readme)
        expect(result_hash[:status]).to eq(:success)
        expect(result_hash[:file]).to eq('folder1/file1')
      end

      context 'where link has regex' do
        it 'should be able to identify the file and line if regex' do
          readme = 'Before [[file1:/line2/]] after'
          result_hash = link_for_doc_content(readme)
          expect(result_hash[:status]).to eq(:success)
          expect(result_hash[:file]).to eq('folder1/file1')
          expect(result_hash[:line_num]).to eq(2)
        end

        it 'should return the first line matching regex' do
          readme = 'Before [[file1:/line/]] after'
          result_hash = link_for_doc_content(readme)
          expect(result_hash[:status]).to eq(:success)
          expect(result_hash[:file]).to eq('folder1/file1')
          expect(result_hash[:line_num]).to eq(0)
        end
      end

      it 'should fail if multiple aliases match' do
        @aliases << Alias.new(
          'folder3',
          'file1',
          'folder3',
          'file1',
          "line0\nline1\nline2\n"
        )
        readme = 'Before [[file1]] after'
        result_hash = link_for_doc_content(readme)
        expect(result_hash[:status]).to eq(:failure)
        expect(result_hash[:message]).to eq(:more_than_one_matching)
      end

      it 'should not me able to find a file that does not exist' do
        readme = 'Before [[file8]] after'
        result_hash = link_for_doc_content(readme)
        expect(result_hash[:status]).to eq(:failure)
        expect(result_hash[:message]).to eq(:no_matching_file)
      end

      it 'should work in a multi-line readme' do
        readme = "Line before\n[[file1]] after"
        result_hash = @klass.dest_for(
          doc_content: readme,
          row: 1,
          column: 2,
          aliases: @aliases
        )
        expect(result_hash[:status]).to eq(:success)
        expect(result_hash[:file]).to eq('folder1/file1')
      end
    end

    context 'cursor not on the link' do
      it 'should not return a file' do
        readme = 'Before [[file1]] after'
        result_hash = @klass.dest_for(doc_content: readme, row: 0, column: 0, aliases: @aliases)
        expect(result_hash[:status]).to eq(:failure)
        expect(result_hash[:message]).to eq(:no_link)
      end
    end
  end
end
