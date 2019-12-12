require 'pry'

class Transfer
  attr_accessor :status, :amount, :sender, :receiver

  @@completed_transactions = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end
  #returns array of transactions
  def self.completed_transactions
    @@completed_transactions
  end
  #checks to see if both accounts are valid
  def valid?
    @sender.valid? && @receiver.valid?
  end
  #transfer money from sender to receiver and record transaction if valid
  def execute_transaction
    if !self.valid? || @status != "pending" || @sender.balance < @amount
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    else
      transfer_money(@sender, @receiver, @amount)
      record_transfer
    end
  end
  #check to see if transaction can go through
  def transfer_money(from, to, amount)
    from.withdraw(amount)
    to.deposit(amount)
  end
  #record transaction and chacge status to complete
  def record_transfer
    @status = "complete"
    @@completed_transactions << self
  end
  #reverse last transfer
  def reverse_transfer
    if Transfer.completed_transactions.last.status != "complete"
      "This transaction has not been completed."
    else
      transfer_money(Transfer.completed_transactions.last.receiver, Transfer.completed_transactions.last.sender, Transfer.completed_transactions.last.amount)
      Transfer.completed_transactions.last.status = "reversed"
    end
  end
end