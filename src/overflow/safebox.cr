struct SafeBox(T)
  getter value : T
  getter type : T.class = T

  forward_missing_to @value

  def initialize(@value : T)
    {{ raise "Safebox(T) only supports Int::Primitive types!" unless Int::Primitive.union_types.includes?(@type.type_vars.first) }}
  end
end
