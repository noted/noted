FactoryGirl.define do
  factory(:note) do
    title "Alpha Centauri"

    project {|project| project.association(:project)}

    after(:create) do |note, evaluator|
      note.sections << create(:section)
    end
  end

  factory(:section) do
    title "A Star"
    body "Red Giant"
  end
end