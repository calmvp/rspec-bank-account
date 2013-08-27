require "rspec"

require_relative "account"

describe Account do
  let(:account) { Account.new("4532145896", 10000)}

  describe "#initialize" do
    it "creates an Account object" do
      account.should be_an_instance_of Account
    end

    it "should raise error if account number not numeric" do
      expect{ Account.new("Ponies") }.to raise_error(InvalidAccountNumberError)
    end
  end

  describe "#transactions" do
    it "should have transactions" do
      account.transactions.should be_true
    end

    it "should be equal to starting_balance" do
      account.transactions.should start_with [10000]
    end
  end

  describe "#balance" do
    
  end

  describe "#account_number" do
    it "should hide first 6 digits" do
      account.acct_number.should start_with "******"
    end
    it "should show the last 4 digits" do
      account.acct_number.should end_with "5896"
    end
  end

  describe "deposit!" do
    it "should raise an error if deposit amount is negative" do
      expect{ account.deposit!(-1) }.to raise_error(NegativeDepositError)
    end
  end

  describe "withdraw!" do

  end
end
