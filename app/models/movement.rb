# frozen_string_literal: true

class Movement < ApplicationRecord
  validates :name, uniqueness: true

  def type
    movement_type
  end

  class << self
    TYPES = %w[snatch squat jerk clean pull deadlift press pullup pulldown row plank bench other].freeze

    def find_by_raw(raw_movement)
      movements = parse_into_movements(sanitize(raw_movement))
      movements.map { |m| Movement.find_by(**m) }
    end

    def sanitize(raw_movement)
      raw_movement.downcase.strip
    end

    def process_raw_movements(raw_movements)
      movements = raw_movements.map { |rm| Movement.sanitize(rm) }
                               .map { |a| Movement.parse_into_movements(a) }
                               .flatten
                               .uniq

      p "processed movements #{movements}"

      Movement.upsert_all(movements, unique_by: :name, returning: %i[id name complex])
    end

    def parse_into_movements(raw_movement)
      p raw_movement
      splits = raw_movement.split(/\+|and/)
                           .map(&:strip)
                           .filter { |s| !s.blank? }

      movements = splits.map { |s| { name: s, movement_type: guess_type(s), complex: false } }

      movements.insert(0, { name: raw_movement, movement_type: 'Complex', complex: true }) if splits.length > 1
      movements
    end

    def guess_type(raw_movement)
      TYPES.each do |movement_type|
        return movement_type if raw_movement.include? movement_type
      end

      TYPES.last
    end
  end
end
