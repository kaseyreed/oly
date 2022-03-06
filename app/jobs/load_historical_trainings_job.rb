# frozen_string_literal: true

require 'json'

class LoadHistoricalTrainingsJob < ApplicationJob
  queue_as :default

  def perform
    load_workouts_and_workout_items

    # filter out the rest days.
    @workouts.select! { |w| w[:rest_day] == false }
    @missing_items = 0

    @workouts.each(&method(:load_workout))

    p 'Completed Processing of Historical Trainings and Results.'
  end

  def load_workouts_and_workout_items
    workouts_json = '/Users/kasey/Desktop/tc backup/truecoach_workouts.json'
    workout_item_json = '/Users/kasey/Desktop/tc backup/truecoach_workout_items.json'

    workouts_file = File.read(workouts_json)
    workout_items_file = File.read(workout_item_json)

    @workouts = JSON.parse(workouts_file, symbolize_names: true)
    workout_items = JSON.parse(workout_items_file, symbolize_names: true)

    @workout_items = workout_items.each_with_object({}) do |item, obj|
      obj[item[:id]] = item
      obj
    end

    p "There are #{@workouts.length} workouts"
    p "There are #{@workout_items.length} workout items"
  end

  def load_workout(workout)
    raw_training = RawTraining.new

    raw_training.date = workout[:due] # raw_trainings.date "2021"
    raw_training.state = workout[:state] # training.state
    raw_training.name = workout[:title] # raw_trainings.name
    raw_training.warmup = workout[:warmup] # raw_trainings.warmup
    raw_training.cooldown = workout[:cooldown] # raw_trainings.cooldown

    item_ids = workout[:workout_item_ids]
    item_ids.map { |item_id| @workout_items[item_id] }
            .each { |workout_item| load_workout_item(raw_training, workout_item) }

    raw_training.processed = false
    raw_training.save!
  end

  def load_workout_item(raw_training, workout_item)
    raw_training_item = raw_training.items.build

    raw_training_item.id = workout_item[:id]
    raw_training_item.state = workout_item[:state]
    raw_training_item.name = workout_item[:name]
    raw_training_item.description = workout_item[:info]
    raw_training_item.superset = workout_item[:linked]
    raw_training_item.index = workout_item[:position]
    raw_training_item.results = workout_item[:result]
    raw_training_item.processed = false
    raw_training_item.save!
  end
end
