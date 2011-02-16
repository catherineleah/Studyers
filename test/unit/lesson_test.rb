require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Lesson title, user & notebook must not be empty" do
    lesson = Lesson.new
    assert lesson.invalid?
    assert lesson.errors[:title].any?
    assert lesson.errors[:user_id].any?
    assert lesson.errors[:notebook_id].any?
  end
end
