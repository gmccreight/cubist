require_relative '../spec_helper'

describe Cubist::Adapter::Git do
  describe 'parse log' do
    it 'should parse logs into commit objects' do
      log = ''
      log += "3f49c7d move from report to reports folder, remove old folder\n"
      log += " reports/README.md | 34 ----------------------------------\n"
      log += " reports/slack.rb  | 15 ---------------\n"
      log += " 2 files changed, 49 deletions(-)\n"
      log += "908b28a Build\n"
      log += " reports/README.md | 2 +-\n"
      log += " 1 file changed, 1 insertion(+), 1 deletion(-)\n"
      log += "2e53231 Build\n"
      log += " reports/README.md | 2 +-\n"
      log += " 1 file changed, 1 insertion(+), 1 deletion(-)\n"
      log += "148e289 Move app into reports/\n"
      log += " reports/README.md | 34 ++++++++++++++++++++++++++++++++++\n"
      log += " reports/edit.rb   | 15 +++++++++++++++\n"
      commits = Cubist::Adapter::Git.new.parse_to_commits(log_lines: log.lines)
      expect(commits.size).to eq(4)
      expect(commits[0].sha).to eq('3f49c7d')
      expect(commits[0].files.to_a).to eq(['reports/README.md', 'reports/slack.rb'])
      expect(commits[3].sha).to eq('148e289')
      expect(commits[3].files.to_a).to eq(['reports/README.md', 'reports/edit.rb'])
    end
  end
end
