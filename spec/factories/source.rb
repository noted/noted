FactoryGirl.define do
  @h2g2 = {
    "title" => "The Hitchhikers Guide to the Galaxy"
  }

  factory(:source) do
    attributes @h2g2

    project {|project| project.association(:project)}
  end
end