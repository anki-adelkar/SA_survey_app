# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise


## My approach
- Accept users input on given questions list, and validate response if it's in "Yes/No"
- questions will display one by one which are already defined in constant.
- if input/response given by user doen't match with valid response i.e. "Yes/No" it will not proceed with next question.
- After getting all the responses rating for current response is calculated using formula: "100 * number of yes answers / number of questions".
- And at the last display average rating considering all the responses given by user
total_rating = sum all the rating per user
total_runs = number of users has given survey.
average_rating = total_rating / total_runs
- do prompt and do_report methods are called in loop to accept survey input for another next user. if we get response in 'Yes/Y' case insensitive on question "Do you want to run the survey again? (Yes/No)"
