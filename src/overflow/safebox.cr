struct SafeBox(T)
  getter value : T
  getter type : T.class = T

  forward_missing_to @value

  def initialize(@value : T); end
end
