# frozen_string_literal: true

class HistoryService

  def self.get_movement_history(movement_id:, variance: nil)
    select_expressions = [
      'trainings.date as date',
      'rep_scheme[1] as rep_scheme',
      'max(weight) as weight',
      'training_items_results.id as training_items_result_id',
      'training_items.id as training_items_id',
      'trainings.id as trainings_id'
    ]

    #noinspection RubyLiteralArrayInspection
    group_expressions = [
      'trainings.date',
      'rep_scheme[1]',
      'training_items_results.id',
      'training_items.id',
      'trainings.id'
    ]

    result = TrainingItem
       .joins(:training_items_movements, :training_items_results, :training)
       .where(
         training_items_movements: { movement_id: movement_id },
         training_items_results: { unit: 'kg', miss: false }
       )
       .where('trainings.date > ?', DateTime.new(2021, 01, 01))
       .where('reps = rep_scheme[1]')
       .order(date: :asc)
       .order(Arel.sql('rep_scheme[1] desc'))
       .select(select_expressions.join(', '))
       .group(group_expressions.join(', '))

    p result.length
    mapped_result = result.map do |row|
      {
        training_id: row.trainings_id,
        training_item_id: row.training_items_id,
        training_item_result_id: row.training_items_result_id,
        num_reps: row.rep_scheme,
        date: row.date,
        weight: row.weight,
      }
    end

    history_hash = {}
    current_max_for_rep_scheme_hash = {}

    mapped_result.each do |row|
      history_hash[row[:num_reps]] ||= []
      current_max_for_rep_scheme_hash[row[:num_reps]] ||= row[:weight]

      current_max = current_max_for_rep_scheme_hash[row[:num_reps]]
      if row[:weight] > current_max
        list = history_hash[row[:num_reps]]
        list << row
        current_max_for_rep_scheme_hash[row[:num_reps]] = row[:weight]

      elsif variance.present? && row[:weight] > current_max * (1.0 - variance)
        list = history_hash[row[:num_reps]]
        list << row
        # we don't add this to the current max. variance is just to get a few
        # more data points around the maxes for the graph.
      end
    end

    p history_hash

    history_hash
  end
end
