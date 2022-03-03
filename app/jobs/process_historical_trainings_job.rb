# frozen_string_literal: true

require 'json'

class ProcessHistoricalTrainingsJob < ApplicationJob
  queue_as :default

  def perform
    load_workouts_and_workout_items

    # filter out the rest days.
    @workouts.select! { |w| w['rest_day'] == false }
    @missing_items = 0

    @workouts.each(&method(:process_workout))

    p 'Completed Processing of Historical Trainings and Results.'
  end

  def load_workouts_and_workout_items
    workouts_json = '/Users/kasey/Desktop/tc backup/truecoach_workouts.json'
    workout_item_json = '/Users/kasey/Desktop/tc backup/truecoach_workout_items.json'

    workouts_file = File.read(workouts_json)
    workout_items_file = File.read(workout_item_json)

    @workouts = JSON.parse(workouts_file)
    workout_items = JSON.parse(workout_items_file)

    @workout_items = workout_items.each_with_object({}) do |item, obj|
      obj[item['id']] = item
    end

    p "There are #{@workouts.length} workouts"
    p "There are #{@workout_items.length} workout items"
  end

  def process_workout(workout)
    id = workout['id']
    date = workout['due'] # raw_trainings.id
    state = workout['state']
    title = workout['title'] # raw_trainings.name
    warmup = workout['warmup'] # raw_trainings.warmup
    cooldown = workout['cooldown'] # raw_trainings.cooldown
    item_ids = workout['workout_item_ids']

    item_ids.map { |item_id| @workout_items[item_id] }
            .each(&method(:process_workout_item))
  end

  def process_workout_item(workout_item)
    item_id = workout_item['id']
    item_name = workout_item['name'] # raw_training_item.name
    item_info = workout_item['info'] # raw_training_item.description
    item_state = workout_item['state']
    item_superset = workout_item['linked'] # raw_training_item.superset
    item_result = workout_item['result'] # raw_training_item.results
    item_index = workout_item['position']
  end

  def process_results(training_item, results); end
end
