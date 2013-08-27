require "rspec"

require_relative "account"

describe Account do
  let(:account) { Account.new("4532145896", 10000)}

  describe "#initialize" do
    it "creates an Account object" do
      expect(account).to be_an_instance_of Account
    end
    it "should raise error if account number is too short" do
      expect{ Account.new("45") }.to raise_error(InvalidAccountNumberError)
    end
    
    it "should raise error if account number not numeric" do
      expect{ Account.new("Ponies") }.to raise_error(InvalidAccountNumberError)
    end
  end

  describe "#transactions" do
    it "should have transactions" do
      expect(account.transactions).to be_true
    end

    it "should be equal to starting_balance" do
      expect(account.transactions).to start_with [10000]
    end
  end

  describe "#balance" do
    it "shiould return sum of transactions" do
      account.stub(:transactions => [200, 100])
      expect(account.balance).to eq 300
    end
  end

  describe "#account_number" do
    it "should hide first 6 digits" do
      expect(account.acct_number).to start_with "******"
    end
    
    it "should show the last 4 digits" do
      expect(account.acct_number).to end_with "5896"
    end
  end

  describe "deposit!" do
    it "should raise an error if deposit amount is negative" do
      expect{ account.deposit!(-1) }.to raise_error(NegativeDepositError)
    end
    
    it "should add amount to transactions array" do
      account.deposit!(100)
      expect(account.transactions.length).to eq 2
    end
  end

  describe "withdraw!" do
    it "should be raise an error if withdraw amound is greater than balance" do
      expect{ account.withdraw!(11000) }.to raise_error(OverdraftError)
    end
    it "should add amount to transactions array" do
      account.withdraw!(100)
      expect(account.transactions.length).to eq 2
    end
    it "should add a negative amount to transactions array" do
      account.withdraw!(100)
      expect(account.transactions).to end_with [-100]
    end
  end
end
