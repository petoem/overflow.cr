struct SafeBox(T)
  {% begin %}
    {% ints = {to_i: Int32, to_i8: Int8, to_i16: Int16, to_i32: Int32, to_i64: Int64, to_i128: Int128, to_u: UInt32, to_u8: UInt8, to_u16: UInt16, to_u32: UInt32, to_u64: UInt64, to_u128: UInt128} %}
    {% for method, type in ints %}
      def {{method.id}} : {{type}}
        \{% if Int::Unsigned.union_types.includes?(@type.type_vars.first) %}
          return @value.{{method.id}} if @value <= {{type}}::MAX
        \{% else %}
          return @value.{{method.id}} if {{type}}::MIN <= @value <= {{type}}::MAX
        \{% end %}
        raise IntegerOverflow.new "#{typeof(self)}\u0023{{method.id}}"
      end
    {% end %}
  {% end %}
end
