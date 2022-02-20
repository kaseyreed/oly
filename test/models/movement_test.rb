require 'test_helper'

class MovementTest < ActiveSupport::TestCase
  test 'identifies clean movement type' do
    guess = Movement.guess_type('no feet clean')
    assert_equal('clean', guess)
  end

  test "doesn't identify the movement, but it's okay" do
    guess = Movement.guess_type('some movement')
    assert_equal('other', guess)
  end
end
