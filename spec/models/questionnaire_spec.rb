require 'rails_helper'
require "pstore" # https://github.com/ruby/pstore
require 'rails_helper'

RSpec.describe Questionnaire, type: :model do

  describe 'do_report' do
    let(:store) { instance_double(PStore) }
    let(:survey_1) { Time.now - 2.minutes}
    let(:survey_2) { Time.now}
    let(:timestamps) { [survey_1, survey_2] }
    let(:responses_user1) { { 'q1' => 'Yes', 'q2' => 'Yes', 'q3' => 'No', 'q4' => 'Yes', 'q5' => 'No' } }
    let(:responses_user2) { { 'q1' => 'Yes', 'q2' => 'No', 'q3' => 'Yes', 'q4' => 'No', 'q5' => 'Yes' } }

    before do
      allow(PStore).to receive(:new).with('tendable.pstore').and_return(store)
    end

    context 'when there are responses in the store' do
      before do
        allow(store).to receive(:transaction).and_yield
        allow(store).to receive(:roots).and_return(timestamps)
        allow(store).to receive(:[]).with(survey_1).and_return(responses_user1)
        allow(store).to receive(:[]).with(survey_2).and_return(responses_user2)
      end

      it "should return " do
        allow_any_instance_of(PStore).to receive(:roots).and_return(timestamps)
      end

      it 'calculates average rating over all runs' do
        expect(Questionnaire.do_report).to eq(60)
      end
    end
  end

end