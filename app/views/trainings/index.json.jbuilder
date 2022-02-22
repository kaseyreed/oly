# frozen_string_literal: true

json.trainings do
  # trainings
  json.array! @trainings do |training|
    json.partial! 'trainings/training', training:
  end
end