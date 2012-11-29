FactoryGirl.define do
  factory(:note) do
    title "Alpha Centauri"

    project {|project| project.association(:project)}
  end
end