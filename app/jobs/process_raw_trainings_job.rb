# frozen_string_literal: true

class ProcessRawTrainingsJob < ApplicationJob
  queue_as :default

  def perform(request_id:)
    p "the request to process #{request_id}"

    request = EmailWebhookRequest.find_by! id: request_id
    payload = request.payload

    # parse subject line
    date, weekly = parse_subject_line(payload['subject'])

    # parse text into raw trainings + raw training items
    parsed_raw_trainings = parse_text(text: payload['text'], date:, weekly:)

    # persist raw trainings and items
    raw_trainings = parsed_raw_trainings.map do |prt|
      raw_training = RawTraining.create! date:, name: prt[:name], warmup: prt[:warmup], cooldown: prt[:cooldown]
      prt[:items].each { |prti| raw_training.raw_training_items.create!(**prti) }
      raw_training
    end

    # process movements from raw training items
    raw_movements = parsed_raw_trainings.map { |prt| prt[:items].map { |i| i[:name] } }.flatten
    movements = Movement.process_raw_movements(raw_movements)

    RawTraining.process_raw_trainings(raw_trainings)
  end

  private

  def parse_subject_line(subject)
    subject_re = /(?:Fwd: )?(?<name>[^,]+), (?:here's your workout|your programming has arrived) for (?<weekly>the week of)?(?<day_of_week>\w+)? (?<month>\w+) (?<day_of_month>\d{1,2})(?:th|nd|st|rd)?, (?<year>\d{4})/

    groups = subject_re.match(subject)

    month = Date::MONTHNAMES.index(groups[:month])
    month = Date::ABBR_MONTHNAMES.index(groups[:month]) if month.nil?

    raise ArgumentError('Subject line does not have valid month') if month.nil?

    date = DateTime.new(groups[:year].to_i, month, groups[:day_of_month].to_i)
    is_weekly = groups[:weekly].present?

    [date, is_weekly]
  end

  def parse_text(text:, date:, weekly:)
    text_parse_re = /(?<content>\*[^*]+\*[\S\s]+?)\n\n\n+- Your Coach,\n(?<coach>[\S\s]+?)\n/

    groups = text_parse_re.match text

    if weekly
      parse_weekly(content: groups[:content], date:)
    else
      parse_single_day(content: groups[:content], date:)
    end
  end

  def parse_weekly(content:, date:)
    raise NotImplementedError('weekly parsing not implemented.')
  end

  def parse_single_day(content:, date:)
    single_day_re = /\*(?<name>[^*]+)\*\n\n\*Warmup: \*\n(?<warmup>[^*]+)\n\n(?<items>[\S\s]+)(?:\*Cooldown: \*\n(?<cooldown>[\S\s]+?))?$/

    groups = single_day_re.match content
    items = parse_items(items_content: groups[:items])

    [{
      date:,
      name: groups[:name],
      warmup: groups[:warmup],
      cooldown: groups[:cooldown],
      items:
    }]
  end

  def parse_items(items_content:)
    p items_content
    items_re = /\*?(?<prefix>\w\d?)\) (?<name>[^*]+)\*\n\n(?<description>[^)]+)(?:\n\n\*|$)/

    parsed_items = []
    index = 0
    prefixes = []
    items_content.scan(items_re) do |prefix, name, description|
      prefixes << prefix

      parsed_items << {
        name:,
        description:,
        superset: prefix.length > 1,
        index:
      }

      index += 1
    end

    raise ArgumentError('expected items len to eq prefixes') if prefixes.length != parsed_items.length

    letter = 'Z'
    prefixes = prefixes.reverse
    parsed_items = parsed_items.reverse
    parsed_items.each_index do |idx|
      item = parsed_items[idx]
      prefix = prefixes[idx]
      curr_letter = prefix[0]

      item[:superset] = false if curr_letter != letter
      letter = curr_letter
    end

    parsed_items.reverse
  end
end
