FactoryGirl.define do
  @info = {
    'author' => [
      {
        'given' => 'Edgar Allen',
        'family' => 'Poe'
      }
    ],
    'title' => 'Poetry, Tales, and Selected Essays',
    'type' => 'book',
    'issued' => {
      'date-parts'=> [ [ 1996 ] ]
    },
    'editor' => [
      {
        'family' => 'Quinn',
        'given' => 'Patrick F.'
      },
      {
        'family' => 'Thompson',
        'given' => 'G.R.'
      }
    ],
    'publisher' => 'Library of America',
    'publisher-place' => 'New York'
  }

  factory :source do
    information({
      'author' => [
        {
          'given' => 'Edgar Allen',
          'family' => 'Poe'
        }
      ],
      'title' => 'Poetry, Tales, and Selected Essays',
      'type' => 'book',
      'issued' => {
        'date-parts'=> [ [ 1996 ] ]
      },
      'editor' => [
        {
          'family' => 'Quinn',
          'given' => 'Patrick F.'
        },
        {
          'family' => 'Thompson',
          'given' => 'G.R.'
        }
      ],
      'publisher' => 'Library of America',
      'publisher-place' => 'New York'
    })

    project
  end
end
