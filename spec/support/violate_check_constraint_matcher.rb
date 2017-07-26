RSpec::Matchers.define :violate_check_constraint do |constraint_name|
  supports_block_expectations ## cause we're gonna hurl

  match do |code_to_test|
    begin
      code_to_test.()
      false
    rescue ActiveRecord::StatementInvalid => ex
      ex.message =~ /#{constraint_name}/
    end
  end
end
