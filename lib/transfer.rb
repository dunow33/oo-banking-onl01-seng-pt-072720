class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    return (sender.valid?) & (receiver.valid?)
  end

  def execute_transaction
    if (valid?) && (@sender.balance >= @amount) && (@status == "pending")
      @receiver.balance += @amount
      @sender.balance -= @amount
      @status = "complete"
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if (valid?) && (@receiver.balance >= @amount) && (@status == "complete")
      @receiver.balance -= @amount
      @sender.balance += @amount
      @status = "reversed"
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end
end
