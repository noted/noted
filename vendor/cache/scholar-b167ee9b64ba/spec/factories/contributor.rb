FactoryGirl.define do
  factory :contributor, class: Scholar::Utilities::Contributor do
    trait :first do
      hash = {
        :role => :editor,
        :first => "John",
        :middle => "Quentin",
        :last => "Sample",
        :suffix => "PhD"
      }

      initialize_with { Scholar::Utilities::Contributor.new(hash) }
    end

    trait :last do
      hash = {
        :role => :author,
        :first => "L",
        :middle => "Randy",
        :last => "Grossman",
        :suffix => "Esq"
      }

      initialize_with { Scholar::Utilities::Contributor.new(hash, :last) }
    end
  end
end
