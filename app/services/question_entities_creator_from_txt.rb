class QuestionEntitiesCreatorFromTxt
  def self.call(file_data, days_count)
    new(file_data, days_count).call
  end

  def initialize(file_data, days_count)
    @file_data = file_data
    @days_count = days_count
  end

  attr_reader :file_data, :days_count

  def call
    user_ids = User.pluck(:id)

    return if user_ids.blank?

    questions_data = file_data.split("\n")
    questions_data.each do |data|
      # start prepare data for question, answers, and comments creation
      begin
        raw_q_data = data.split("-{Tags}-")
        q_data = raw_q_data.shift
        raw_tags_data = raw_q_data

        divided_data = q_data.split("-{Answer}-")

        question_data = divided_data.shift
        answers_data = divided_data
      end
      # finish prepare data for question, answers, and comments creation
      # start of question creation

      question_user_id = user_ids.sample

      question = Question.new

      raw_q_data = question_data.split("-{QComment}-")
      raw_question_attrs = raw_q_data.shift.gsub("-{Question}-", "")

      q_comments_attrs = raw_q_data

      question_attrs = raw_question_attrs.split("!@#")

      question_attrs.each do |attr|
        key_value = attr.split(":")

        question.send("#{key_value.shift.strip}=", key_value.join("").strip)

        question.published = false
        question.user_id = question_user_id
        question.slug = question.title.gsub(/[^a-zа-яёË]/i, "-")
                                .gsub(/-+/, "-")
                                .gsub(/\W$/, "")
                                .downcase
        question.creation_type = "generated"
        data_of_creation = (1..days_count).to_a.sample
        question.created_at = data_of_creation.days.ago

      rescue StandardError
        next
      end

      if question.valid?
        question.save
      else
        next
      end

      user = User.find(question_user_id)
      user.update_column(:questions_count, user.questions_count + 1)

      # finish of question creation
      # start of comments creation for question
      begin
        question_commented_user_ids = []
        last_user_commented_id = 0
        q_comments_count = 0

        q_comments_attrs.each do |q_comment_attrs|
          current_commented_user_id = (user_ids - [question_user_id] - question_commented_user_ids).sample
          question_commented_user_ids << current_commented_user_id
          last_user_commented_id = current_commented_user_id

          q_comment = Comment.new

          key_value = q_comment_attrs.split(":")
          begin
            q_comment.send("#{key_value.shift.strip}=", key_value.join("").strip)

            q_comment.user_id = current_commented_user_id
            q_comment.commented_to_id = question.id
            q_comment.commented_to_type = "Question"
            q_comment.creation_type = "generated"
            q_comment.published = true
            q_comment.reserved = q_comments_count > 0 ? true : false

            q_comments_count += 1
            data_of_creation = (1..days_count).to_a.sample
            q_comment.created_at = data_of_creation.days.ago
          rescue StandardError
            next
          end

          if q_comment.valid?
            q_comment.save
            q_comments_count += 1
          else
            next
          end

          user = User.find(current_commented_user_id)
          user.update_column(:comments_count, user.comments_count + 1)
        end
      end
      # finish of comments creation for question
      # start of answers creation

      answered_user_ids = []
      last_user_answered_id = 0
      q_answers_count = 0

      answers_data.each do |answer_data|
        raw_data = answer_data.split("-{AComment}-")

        answer_attrs = raw_data.shift
        a_comments_data = raw_data

        current_answered_user_id = (user_ids - [question_user_id] - answered_user_ids).sample
        answered_user_ids << current_answered_user_id
        last_user_answered_id = current_answered_user_id

        answer = Answer.new


        begin
          key_value = answer_attrs.split(":")

          answer.send("#{key_value.shift.strip}=", key_value.join("").strip)

          answer.user_id = current_answered_user_id
          answer.question_id = question.id
          answer.creation_type = "generated"
          answer.published = true
          answer.reserved = q_answers_count > 0 ? true : false

          q_answers_count += 1

          data_of_creation = (1..days_count).to_a.sample
          answer.created_at = data_of_creation.days.ago

        rescue StandardError
          next
        end

        if answer.valid?
          answer.save
        else
          puts answer.errors
          next
        end

        user = User.find(current_answered_user_id)
        user.update_column(:comments_count, user.answers_count + 1)

        # start of comments creation for answer
        begin
          commented_user_ids = []
          last_user_answer_commented_id = 0
          a_comments_count = 0

          a_comments_data.each do |attr|
            current_commented_user_id = (user_ids - commented_user_ids).sample
            commented_user_ids << current_commented_user_id
            last_user_answer_commented_id = current_commented_user_id

            a_comment = Comment.new

            begin
              key_value = attr.split(":")

              a_comment.send("#{key_value.shift.strip}=", key_value.join("").strip)

              a_comment.user_id = current_commented_user_id
              a_comment.commented_to_id = answer.id
              a_comment.commented_to_type = "Answer"
              a_comment.creation_type = "generated"
              a_comment.published = true
              a_comment.reserved = a_comments_count > 0 ? true : false

              a_comments_count += 1

              data_of_creation = (1..days_count).to_a.sample
              a_comment.created_at = data_of_creation.days.ago

            rescue StandardError
              next
            end

            if a_comment.valid?
              a_comment.save
            else
              next
            end

            user = User.find(current_commented_user_id)
            user.update_column(:comments_count, user.comments_count + 1)
          end

          answer.update_columns(comments_count: a_comments_count,
                                last_user_commented_id: last_user_answer_commented_id,
                                last_user_commented_type: "generated")
        end
        # finish of comments creation for answer
      end

      # finish of answers creation
      # start of tag creation
      begin
        tags_data = raw_tags_data.flatten.first.split(":").last
        tags_names = tags_data.split("!@#")

        tags_names.each do |t_name|
          tag = Tag.find_or_create_by(name: t_name.downcase)
          QuestionTag.create(tag_id: tag.id, question: question)
        end
      end
      # finish of tag creation

      question.update_columns(answers_count: q_answers_count,
                              comments_count: q_comments_count,
                              last_user_commented_id: last_user_commented_id,
                              last_user_answered_id: last_user_answered_id,
                              last_user_commented_type: "generated",
                              last_user_answered_type: "generated")
    end
  end
end
