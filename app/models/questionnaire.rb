require "pstore" # https://github.com/ruby/pstore
class Questionnaire < ApplicationRecord

  def self.do_report
    # calculate total rating and total runs
    store = PStore.new(STORE_NAME)
    total_rating = 0
    total_runs = 0
    store.transaction(true) do
      store.roots.each do |timestamp|
        responses = store[timestamp]
        if responses
          rating = 100 * responses.values.count("Yes") / QUESTIONS.count
          total_rating += rating
          total_runs += 1
        end
      end

      # calculate average rating over all runs based on yes responses given by each user, only if total runs are greater than 0.
      @average_rating = (total_rating/total_runs) if total_runs > 0
      puts "Avarage Rating over all run : #{@average_rating}"
    end
    
    @average_rating
  end

end
