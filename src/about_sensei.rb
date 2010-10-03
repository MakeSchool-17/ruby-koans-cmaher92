require File.expand_path(File.dirname(__FILE__) + '/edgecase')

class Sensei
  def observe(step)
    # Step Protocol: step.passed? | step.failure | step.koan_file | step.name
    # WRITE THIS CODE
    #--
    @pass_count ||= 0
    if step.passed?
      @pass_count += 1 
      "#{step.koan_file.class.to_s}##{step.name} has expanded your awareness."
    else
      @failure = step.failure
      "#{step.koan_file.class.to_s}##{step.name} has damaged your karma."
    end
    #++
  end

  def pass_count
    # WRITE THIS CODE
    #--
    @pass_count
    #++
  end

  def failed?
    # WRITE THIS CODE
    #--
    ! @failure.nil?
    #++
  end

  def instruct
    # WRITE THIS CODE
    #--
      if failed?
        "You have not yet reached enlightenment. You have passed #{pass_count} steps."
      else
        "The student has become the master"
      end
    #++
  end
end

def student_passes_test
  assert true  # DO NOT CHANGE YOUR STUDENT'S ANSWER
end

def student_fails_test
  assert false # DO NOT CHANGE YOUR STUDENT'S ANSWER
end

class AboutSensei < EdgeCase::Koan
  def test_sensei_comments_about_expanded_awareness
    you = Sensei.new
    student_step = EdgeCase::Koan.new(:student_passes_test, self)
    student_meditation = student_step.meditate
    observation = you.observe(student_meditation)
    assert_equal "AboutSensei#student_passes_test has expanded your awareness.", observation
  end

  def test_sensei_comments_about_damaged_karma
    you = Sensei.new
    student_step = EdgeCase::Koan.new(:student_fails_test, self)
    student_meditation = student_step.meditate
    observation = you.observe(student_meditation)
    assert_equal "AboutSensei#student_fails_test has damaged your karma.", observation
  end

  def test_sensei_counts_passed_steps
    you = Sensei.new
    student_steps = [EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_fails_test, self)]
    student_steps.each do |step|
      you.observe step.meditate
    end
    assert_equal 4, you.pass_count
  end

  def test_sensei_reports_failed_true
    you = Sensei.new
    student_steps = [EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_fails_test, self)]
    student_steps.each do |step|
      you.observe step
    end
    assert you.failed?
  end

  def test_sensei_reports_failed_true
    you = Sensei.new
    student_steps = [EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_passes_test, self)]
    student_steps.each do |step|
      you.observe step
    end
    assert ! you.failed?
  end

  def test_sensei_shows_beginning_progress
    you = Sensei.new
    student_steps = [EdgeCase::Koan.new(:student_fails_test, self),
                     EdgeCase::Koan.new(:student_fails_test, self),
                     EdgeCase::Koan.new(:student_fails_test, self),
                     EdgeCase::Koan.new(:student_fails_test, self),
                     EdgeCase::Koan.new(:student_fails_test, self)]
    student_steps.each do |step|
      you.observe step.meditate
    end
    instructions = you.instruct
    assert_match "You have not yet reached enlightenment", instructions
    assert_match "You have passed 0 steps", instructions
  end

  def test_sensei_shows_partial_progress
    you = Sensei.new
    student_steps = [EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_passes_test, self),
                     EdgeCase::Koan.new(:student_fails_test, self),
                     EdgeCase::Koan.new(:student_fails_test, self)]
    student_steps.each do |step|
      you.observe step.meditate
    end
    instructions = you.instruct
    assert_match "You have not yet reached enlightenment", instructions
    assert_match "You have passed 3 steps", instructions
  end

  def test_sensei_congratulates_student
    you = Sensei.new
    # run all of Ruby Koans with you as the sensei
    EdgeCase::ThePath.new(you).walk

    instructions = you.instruct
    assert_match "The student has become the master", instructions
  end
end
