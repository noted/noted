FactoryGirl.define do
  factory(:note) do
    title "Alpha Centauri"
    body "Lorem ipsum."

    project {|project| project.association(:project)}

    after(:create) do |note, evaluator|
      note.project.notes << note
    end
  end
end
