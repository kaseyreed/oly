module Mutations
  class TestMutation < Mutations::BaseMutation
    null true

    argument :name, String, required: true
    argument :age, Integer, required: false

    field :name, String, null: true
    field :age, Integer, null: true

    def resolve(name:, age:)
      {
        name:,
        age:
      }
    end
  end
end