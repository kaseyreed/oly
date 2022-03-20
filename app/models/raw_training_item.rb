# frozen_string_literal: true

class RawTrainingItem < ApplicationRecord
  belongs_to :raw_training

  class << self
    def process_raw_training_item(raw_training_item, training_id:)
      movements = Movement.find_by_raw(raw_training_item.name)

      complex = movements.length > 1
      num_sets = parse_sets(raw_training_item.description)
      rep_scheme = parse_rep_scheme(raw_training_item.description, complex)

      training_item = TrainingItem.create!(
        training_id:,
        index: raw_training_item.index,
        complex:,
        num_sets:,
        rep_scheme:,
        state: TrainingItem.states[raw_training_item[:state]],
        superset: raw_training_item.superset,
        raw_training_items_id: raw_training_item.id,
        movements:
      )

      TrainingItemsResult.process_raw_results(
        training_item.id,
        movements.first,
        raw_training_item[:results]
      ) if raw_training_item[:results].present?
    end

    # should support variable sets parsing, for example: working to a max or an rm,
    # we don't know how many sets that'll be...
    # consider a tuple response (type, num) type = exact, variable, tbd ...
    def parse_sets(original_info)
      info = original_info.downcase

      ['top single', 'top set', 'top technical set'].each do |s|
        return 1 if info.include? s
      end

      groups = /(?<num_sets>\d{1,2}) ?(?:working )?(?:sets|singles)/.match info
      return groups[:num_sets].to_i if groups

      # 20X1; 12, 10, 8, 6-F; rest 1 min
      # 12, 10, 8-F; Rest 1-2 mins\n\n*attachment #2
      # let something_re = Regex::new(r"(\d{1,2}, ?)+;").unwrap();
      if info.include? 'rm'
        # let some_rm_re = Regex::new(r"(Work to |Top )(top set|\dRM).*(then [^\d] (back offs|drops))?").unwrap();
        return 3 if info.include?('back offs') || info.include?('drops')

        return 1
      end

      -1
    end

    def parse_rep_scheme(original_info, complex)
      info = original_info.downcase

      # 1+1 to top set x 3 working sets -> [ [1,1] ]
      # 321+1 working to top single -> [ [3,1], [2,1], [1,1] ]
      # Work to top set of 1+1
      # 1+1; Work to top set
      # Work to moderate 1+1 for 3 sets
      if complex
        return [1, 1] if info.include?('321+1')

        match = /(\d\+)+\d/.match(info)

        if match.present?
          return match.to_s.split('+')
                      .map(&:to_i)
        end

        return []
      end

      [parse_rep_scheme_single(info)]
    end

    # basic example: 10 reps x 3 sets
    # medium example: 2-15 reps x 3 sets
    # 8-10 reps x 3 working sets
    # 2112; 10 reps each side x 3 sets
    # new todo:  5 reps x 3-4 sets
    def parse_rep_scheme_single(info)
      groups = /(?<num_reps>\d{1,2})(-\d{1,2})? (reps )?(each leg )?(each arm )?(pull throughs each side )?x \d{1,2} (working |top )?sets?/.match info
      return groups[:num_reps].to_i if groups.present?

      groups = /(?<num_reps>\d)RM/.match info
      return groups[:num_reps].to_i if groups.present?

      match = /\d+ singles/
      return 1 if match.present?

      # light technical triples x 3 working sets
      # Work to moderate triple for 3 sets; Rest 2 min
      # Work to moderate double for 3 sets
      groups = /Work to moderate (?<rep_str>triple|double) (?:for |x )?\d sets/.match info
      if groups.present?
        return 3 if groups[:rep_str].eql? 'triple'
        return 2 if groups[:rep_str].eql? 'double'
      end

      # also need to handle 3,2,1 working to...
      stripped_info = info.gsub(',', '')
      match = /(321 )?(working )?to (top )?single/.match stripped_info
      return 1 if match.present?

      # cluster singles
      # cluster singles. "1.1.1. reps x 3 working sets; Rest 1 min btw clusters; 2 min btw sets"

      1 # More work to do.
    end
  end
end
