require_relative "./cli_helper"

describe "docs_link" do

  before :each do
    `cd #{temp_dir}; touch .cubist_angle`
    `cd #{temp_dir}; echo "testing\\nhello\\ngoodbye" > some_target_file`
    `cd #{temp_dir}; ln -s some_target_file my_alias`
    `cd #{temp_dir}; echo "link to [[my_alias]] [[not_a_file]] [[my_alias:/bye/]]" > doc.markdown`
  end

  def for_column(column)
    x = run("--doc=#{temp_dir}/doc.markdown --doc_row=0 --doc_column=#{column}")
    JSON.parse(x)
  end

  context "cursor over a link" do
    it 'should return file info if actually points to a file' do
      x = for_column(10)
      expect(x["status"]).to eq("success")
      expect(x["file"]).to match(/my_alias$/)
      expect(x["line_num"]).to eq(nil)
    end
    it 'should additionally return the line for a regex link' do
      x = for_column(40)
      expect(x["status"]).to eq("success")
      expect(x["file"]).to match(/my_alias$/)
      expect(x["line_num"]).to eq(2)
    end
    it 'should return no file if link does not match a file' do
      x = for_column(24)
      expect(x["status"]).to eq("failure")
      expect(x["message"]).to eq('no_matching_file')
    end
  end

  context "cursor not over a link" do
    it 'should return failure' do
      x = for_column(2)
      expect(x["status"]).to eq("failure")
      expect(x["message"]).to eq('no_link')
    end
  end

end
