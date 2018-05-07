{% begin %}
  {% ints = {Int8 => ".to_i8", Int16 => ".to_i16", Int32 => ".to_i32", Int64 => ".to_i64", Int128 => ".to_i128", UInt8 => ".to_u8", UInt16 => ".to_u16", UInt32 => ".to_u32", UInt64 => ".to_u64", UInt128 => ".to_u128" }%}
  {% for name, type in {i16: Int16, i32: Int32, i64: Int64, i128: Int128} %}
    struct {{type}}
      {% for int_type in ints.keys %}
        {% for oper, sign in {add: "+", sub: "-", mul: "*"} %}
          @[AlwaysInline]
          def {{sign.id}}(other : {{int_type}}) : {{type}}
            result, overflow = Intrinsics.s{{oper.id}}_{{name}}_with_overflow(self, other{{ints[type].id if int_type != type}})
            return result unless overflow
            raise IntegerOverflow.new "{{type}} s{{oper.id}} #{self}, #{other}"
          end
        {% end %}
      {% end %}
    end
  {% end %}

  {% for name, type in {i16: UInt16, i32: UInt32, i64: UInt64, i128: UInt128} %}
    struct {{type}}
      {% for int_type in ints.keys %}
        {% for oper, sign in {add: "+", sub: "-", mul: "*"} %}
          @[AlwaysInline]
          def {{sign.id}}(other : {{int_type}}) : {{type}}
            result, overflow = Intrinsics.u{{oper.id}}_{{name}}_with_overflow(self, other{{ints[type].id if int_type != type}})
            return result unless overflow
            raise IntegerOverflow.new "{{type}} u{{oper.id}} #{self}, #{other}"
          end
        {% end %}
      {% end %}
    end
  {% end %}
{% end %}
