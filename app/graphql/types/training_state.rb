module Types
  class TrainingState < Types::BaseEnum
    value "READY", value: :ready
    value "COMPLETED", value: :completed
    value "MISSED", value: :missed
    value "SKIPPED", value: :skipped
  end
end