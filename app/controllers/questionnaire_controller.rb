class QuestionnaireController < ApplicationController
  def index
    @questions = QUESTIONS
    @score = params[:score] if params.present?
    flash[:alert] = params[:notice]
    @average_rating = Questionnaire.do_report
  end

  def submit
    responses = params[:responses]
    if responses
      store_responses(responses)
      @score = 100 * responses.values.count('Yes') / QUESTIONS.count
      redirect_to root_path(score: @score, notice: "Survey submitted successfully!")
    else
      redirect_to root_path(score: @score, notice: "Please select some value to submit response")
    end
  end

  private

  def store_responses(responses)
    store = PStore.new(STORE_NAME)
    store.transaction do
      store[Time.now] = responses
    end
  end
  
end
