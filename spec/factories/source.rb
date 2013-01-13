FactoryGirl.define do
  @h2g2 = {
    :type => "book",
    :title => "The Hitchhiker's Guide to the Galaxy",
    :contributors => [
      {
        :type => "author",
        :first => "Douglas",
        :last => "Adams"
      }
    ],
    :publisher => {
      :name => "Ballantine",
      :location => "New York"
    },
    :year => "2005"
  }

  factory(:source) do
    data {{ :title => "The Hitchhiker's Guide to the Galaxy" }}

    project {|project| project.association(:project)}
  end
end