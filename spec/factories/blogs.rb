FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Lorem.paragraph(sentence_count: 3) }
    published { false }

    trait :published do
      published { true }
    end
  end
end
