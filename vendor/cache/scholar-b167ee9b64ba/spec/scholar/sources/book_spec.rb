require 'spec_helper'

describe Scholar::Sources::Book do
  let(:data) do
    {
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
    }
  end

  let(:citation) do
    "Adams, Douglas N. <em>The Hitchhiker's Guide to the Galaxy</em>. Ed. Peter Guzzardi. Comp. Eion Colfer. Trans. Les Grossman. 1st ed. Vol. 1. London: Random House, 1972. Print. The Hitchhiker's Guide to the Galaxy."
  end

  let(:c) { Scholar::Citation.new(data) }

  it { c.html.should eql citation }
end
