FactoryGirl.define do
  factory(:source) do
    ignore do
      citation do
        Scholar::Citation.new({
          :type => 'book',
          :title => 'The Hitchhiker\'s Guide to the Galaxy',
          :contributors => [
            {
              :role => :author,
              :first => 'Douglas',
              :last => 'Adams'
            }
          ],
          :publisher => 'Ballantine',
          :city => 'New York',
          :year => '2005'
        })
      end
    end

    initialize_with { Source.new(:citation => citation) }

    project { |project| project.association(:project) }
  end
end
