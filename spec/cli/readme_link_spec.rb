require_relative "./cli_helper"

describe "readme_link" do

  it 'gets the file under the cursor' do
    `cd #{temp_dir}; touch .cubist_angle`
    `cd #{temp_dir}; echo testing > some_target_file`
    `cd #{temp_dir}; ln -s some_target_file my_alias`
    `cd #{temp_dir}; echo "link to [[my_alias]]" > doc.markdown`
    destination_json = run("--doc=#{temp_dir}/doc.markdown --doc_row=0 --doc_column=10").chomp
    result = JSON.parse(destination_json)
    expect(result["result"]).to eq("success")
    expect(result["filename"]).to match(/my_alias/)
  end

end
