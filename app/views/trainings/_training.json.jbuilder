json.id training.id
json.title training.title
json.date training.date.to_date.to_formatted_s(:long)
json.warmup training.warmup
json.cooldown training.cooldown

json.items do
  items = training.training_items.sort_by(&:index)
  # items
  json.partial! 'training_items/training_items', training_items: items
end