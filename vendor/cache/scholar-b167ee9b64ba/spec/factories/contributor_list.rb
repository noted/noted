FactoryGirl.define do
  factory :contributors, class: Scholar::Utilities::ContributorList do
    trait :author do
      arr = [
        {
          :role => :author,
          :first => "John",
          :last => "Green"
        },
        {
          :role => :author,
          :first => "Douglas",
          :middle => "Noel",
          :last => "Adams"
        },
        {
          :role => :author,
          :first => "Neil",
          :middle => "deGrasse",
          :last => "Tyson",
          :suffix => "PhD"
        }
      ]

      initialize_with { Scholar::Utilities::ContributorList.new(arr, :author) }
    end

    trait :nonauthor do
      arr = [
        {
          :role => :editor,
          :first => "Carl",
          :last => "Sagan"
        },
        {
          :role => :editor,
          :first => "Neil",
          :middle => "deGrasse",
          :last => "Tyson",
          :suffix => "PhD"
        }
      ]

      initialize_with { Scholar::Utilities::ContributorList.new(arr) }
    end
  end
end
