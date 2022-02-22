json.id item.id
complex_movement = item.movements.select { |m| m[:complex] == true }.first
json.title complex_movement.present? ? complex_movement[:name] : item.movements.first[:name].titleize
json.index item.index
json.complex item.complex
json.num_sets item.num_sets
json.rep_scheme item.rep_scheme
json.state item.state
json.superset item.superset

json.movements do
  # movements
  json.array! item.movements do |movement|
    json.partial! 'movements/movement', movement:
  end
end