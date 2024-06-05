require 'rails_helper'

RSpec.describe QuestionnaireController, type: :controller do

  let(:sample_responses) { { q1: 'Yes', q2: 'No', q3: 'Yes' } }

  describe "GET #index" do
    it "assigns questions" do
      get :index
      expect(assigns(:questions)).to eq(QUESTIONS)
    end

    it "assigns @score if params are present" do
      get :index, params: { score: 80 }
      expect(assigns(:score)).to eq(80)
    end

    it "assigns @average_rating" do
      allow(Questionnaire).to receive(:do_report).and_return(75)
      get :index
      expect(assigns(:average_rating)).to eq(75)
    end

    it "sets flash alert if notice is present in params" do
      get :index, params: { notice: "Test notice" }
      expect(flash[:alert]).to eq("Test notice")
    end
  end

  describe "POST #submit" do
    let(:sample_responses) { { q1: 'Yes', q2: 'No', q3: 'Yes' } }

    it "redirects to root with score and notice if responses are submitted" do
      post :submit, params: { responses: sample_responses }
      expect(response).to redirect_to(root_path(score: 66, notice: "Survey submitted successfully!"))
    end

    it "redirects to root with score and notice if no responses are submitted" do
      post :submit
      expect(response).to redirect_to(root_path(score: nil, notice: "Please select some value to submit response"))
    end

    it "stores responses in PStore" do
      expect_any_instance_of(PStore).to receive(:transaction)
      post :submit, params: { responses: sample_responses }
    end
  end
end