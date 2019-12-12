class BankAccount
    attr_accessor :balance, :status
    attr_reader :name

    def initialize(name)
        @name = name
        @balance = 1000
        @status = "open"
    end
    #deposit money into account
    def deposit(amount)
        @balance += amount
    end
    #remove money from account
    def withdraw(amount)
        @balance -= amount
    end
    #return balance in account
    def display_balance
        return "Your balance is $#{@balance}."
    end
    #returns true if account is open and balance is >0
    def valid?
        @balance > 0 && @status == "open"
    end
    #changes status to closed
    def close_account
        @status = "closed"
    end

end