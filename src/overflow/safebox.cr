struct SafeBox(T)
  getter value : T

  forward_missing_to @value

  def initialize(@value : T); end
end
