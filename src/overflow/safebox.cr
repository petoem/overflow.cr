struct SafeBox(T)
  getter value : T
  getter type : T.class

  forward_missing_to @value

  def initialize(@value : T)
    @type = T
  end
end
