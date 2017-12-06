FactoryGirl.define do 
  factory :category do
    sequence(:name) { |n| "name#{n}" }
    sequence(:branch) { |n| "branch#{n}" }
  end
end