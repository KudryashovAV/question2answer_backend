class ActivityMaker
  def self.call(activity_type)
    new(activity_type).call
  end

  def initialize(activity_type)
    @activity_type = activity_type
  end

  attr_reader :activity_type

  def call
    if activity_type === "question"
      unreserve_questions_comment
      unreserve_questions_answer
    else
      unreserve_answers_comment
    end
  end

  private

  def unreserve_questions_comment
    questions = Question.where("last_user_commented_type = 'generated' OR last_user_commented_type = 'test'")

    questions.each do |question|
      reserved_comment = question.comments.where(reserved: true).first

      if reserved_comment
        reserved_comment.update(reserved: false, published: true)
      else
        next
      end
    end
  end

  def unreserve_questions_answer
    questions = Question.where("last_user_answered_type = 'generated' OR last_user_answered_type = 'test'")

    questions.each do |question|
      reserved_answer = question.answers.where(reserved: true).first

      if reserved_answer
        reserved_answer.update(reserved: false, published: true)
      else
        next
      end
    end
  end

  def unreserve_answers_comment
    answers = Answer.where("last_user_commented_type = 'generated' OR last_user_commented_type = 'test'")

    answers.each do |answer|
      reserved_comment = answer.comments.where(reserved: true).first

      if reserved_comment
        reserved_comment.update(reserved: false, published: true)
      else
        next
      end
    end
  end
end
