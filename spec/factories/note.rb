FactoryGirl.define do
  factory(:note) do
    title "Alpha Centauri"
    body "Foo to the bar to the foo."

    project {|project| project.association(:project)}
  end
end