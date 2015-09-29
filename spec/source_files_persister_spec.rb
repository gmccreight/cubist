require_relative "./spec_helper"

describe Cubist::SourceFilesPersister do

  before :each do
    @persister = Cubist::SourceFilesPersister.new(conf: conf)
  end

  xit "should persist the files into an excellent, hand-readable and editable data structure" do
    file_and_link("app/models/item.rb", "features/availability/models/item.rb")
    file_and_link("app/models/product.rb", "features/availability/models/product.rb")
    file_and_link("app/services/product_finder_service.rb", "features/availability/services/product_finder_service.rb")
    link_file_paths = Cubist::SourceFilesFinder.new(conf: conf).run(relative: true)
    expect(@persister.persist_paths(link_file_paths)).to eq(nil)
  end

end
