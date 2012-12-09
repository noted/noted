FactoryGirl.define do
  factory(:note) do
    title "Alpha Centauri"
    body "Lorem ipsum."

    project {|project| project.association(:project)}
  end
end