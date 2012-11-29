FactoryGirl.define do
  factory(:note) do
    title "Alpha Centauri"

    project {|project| project.association(:project)}

    after(:create) do |note, evaluator|
      note.boxes << create(:box)
    end
  end

  factory(:box) do
    title "A Star"
    body "Red Giant"
  end
end