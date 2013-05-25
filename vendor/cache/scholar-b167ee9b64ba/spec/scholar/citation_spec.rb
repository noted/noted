require 'spec_helper'

describe Scholar::Citation do
  let(:c) do
    Scholar::Citation.new({
      :type => :book,
      :media => :print,
      :title => "The Hitchhiker's Guide to the Galaxy",
      :contributors => [
        {
          :role => :author,
          :first => "Douglas",
          :middle => "Noel",
          :last => "Adams"
        },
        {
          :role => :editor,
          :first => "Peter",
          :last => "Guzzardi"
        },
        {
          :role => :translator,
          :first => "Les",
          :last => "Grossman"
        },
        {
          :role => :compiler,
          :first => "Eion",
          :last => "Colfer"
        }
      ],
      :edition => 1,
      :volume => 1,
      :publisher => "Random House",
      :city => "London",
      :year => "1972",
      :series => "The Hitchhiker's Guide to the Galaxy"
    })
  end

  describe "#to_hash" do
    it { c.to_hash.keys.should =~ [:attributes, :raw, :html] }
  end
end
