FactoryBot.define do
  factory :comment do
    user
    movie
    content "MyString"
  end
end
