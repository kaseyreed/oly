class TrainingItemsResult < ApplicationRecord

  default_scope { order(:index) }

  enum set_type: {
    ramp_up_set: 0,
    working_set: 1,
    backoff_set: 2,
    drop_set: 3,
  }

  enum weight_unit: {
    kg: 0,
    lb: 1,
  }

  class << self
    def process_raw_results(training_item_id, movement, raw_results)
      training_item = TrainingItem.find(training_item_id)
      training = training_item.training

      raw_set_strs = raw_results.split(/\n/)
                                .select { |str| !str.blank? }
                                .map { |str| str.strip }

      results = []

      current_weight_unit = guess_weight_unit(training.date, movement)

      raw_set_strs.each do |raw_set_str|
        set_str = raw_set_str.downcase

        miss = set_str.match(/(miss|fail|:\(|❌)/).present?

        current_weight_unit = :kg if set_str.match(/kg/).present?
        current_weight_unit = :lb if set_str.match(/lb/).present?

        # 3x40
        result = /(?<reps>\d{1,2})x(?<weight>\d{1,3})/.match set_str
        if result.present?
          reps = result[:reps].to_i
          weight = result[:weight].to_i

          results << {
            reps: reps,
            weight: weight,
            miss: miss,
            weight_unit: current_weight_unit,
          }
          next
        end

        result = /^(?<weight>\d{1,3})/.match set_str
        if result.present?
          weight = result[:weight].to_i

          results << {
            # TODO: this isn't quite right, cause sometimes I actually go for singles
            reps: if training_item.rep_scheme.empty?
                    1
                  else
                    movement.complex ? 1 : training_item.rep_scheme.first
                  end,
            weight: weight,
            miss: miss,
            weight_unit: current_weight_unit,
          }
          next
        end

        # TODO: how many of these are there?
        p "Unable to parse results: #{set_str}"
      end

      results.each_with_index do |result, index|
        TrainingItemsResult.create!(
          training_item_id: training_item.id,
          reps: result[:reps],
          weight: result[:weight],
          miss: result[:miss],
          unit: result[:weight_unit],
          set_type: :working_set,
          index: index
        )
      end

    end

    private

    def guess_weight_unit(date, movement)
      return :kg if movement.complex
      return :kg if date.after?(Date.new(2020, 12, 31)) and kilo_movement?(movement)

      # TODO: not sure we're going to deal with these or now.
      :lb
    end

    def kilo_movement?(movement)
      kilo_movements = %w[snatch squat jerk clean pull deadlift press bench]
      kilo_movements.include?(movement.type)
    end
  end
end
