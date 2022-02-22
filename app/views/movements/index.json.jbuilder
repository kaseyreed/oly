# frozen_string_literal: true

json.movements do
  json.array! @movements do |movement|
    json.partial! 'movements/movement', movement:
  end
end
json.count @movements.length
