require_relative "./cli_helper"

describe 'get related files' do
  it 'gets a single related file' do
    `cd #{temp_dir}; git init`
    `cd #{temp_dir}; echo 1 > 1.txt; git add .; git commit -m 'commit 1'`
    `cd #{temp_dir}; echo 2 > 2.txt; git add .; git commit -m 'commit 2'`
    `cd #{temp_dir}; echo 3 > 3.txt; echo 1_2 >> 1.txt; git add .; git commit -m 'commit 3'`

    related_files = run('--get_related_files=3.txt', "CUBIST_ADAPTER_GIT_BINARY=git CUBIST_ADAPTER_GIT_DIRECTORY=#{temp_dir}").chomp
    expect(related_files).to eq("alive 1.txt")
  end
  it 'gets multiple related files' do
    `cd #{temp_dir}; git init`
    `cd #{temp_dir}; echo 1 > 1.txt; git add .; git commit -m 'commit 1'`
    `cd #{temp_dir}; echo 2 > 2.txt; git add .; git commit -m 'commit 2'`
    `cd #{temp_dir}; echo 3 > 3.txt; echo 1_2 >> 1.txt; git add .; git commit -m 'commit 3'`
    `cd #{temp_dir}; echo 3_2 >> 3.txt; echo 2_2 >> 2.txt; git add .; git commit -m 'commit 4'`

    related_files = run('--get_related_files=3.txt', "CUBIST_ADAPTER_GIT_BINARY=git CUBIST_ADAPTER_GIT_DIRECTORY=#{temp_dir}").chomp
    expect(related_files).to eq("alive 1.txt\nalive 2.txt")
  end
  it 'gets multiple related files... marking subsequently deleted ones as unlinked and sorting last' do
    `cd #{temp_dir}; git init`
    `cd #{temp_dir}; echo 1 > 1.txt; git add .; git commit -m 'commit 1'`
    `cd #{temp_dir}; echo 2 > 2.txt; git add .; git commit -m 'commit 2'`
    `cd #{temp_dir}; echo 3 > 3.txt; echo 1_2 >> 1.txt; git add .; git commit -m 'commit 3'`
    `cd #{temp_dir}; echo 3_2 >> 3.txt; echo 2_2 >> 2.txt; git add .; git commit -m 'commit 4'`
    `cd #{temp_dir}; git rm 1.txt; git commit -m 'commit 5'`

    related_files = run('--get_related_files=3.txt', "CUBIST_ADAPTER_GIT_BINARY=git CUBIST_ADAPTER_GIT_DIRECTORY=#{temp_dir}").chomp
    expect(related_files).to eq("alive 2.txt\nunlinked 1.txt")
  end
end
