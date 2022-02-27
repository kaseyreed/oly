module Types
  class MovementType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :type, String, null: false
    field :complex, Boolean, null: false
  end
end