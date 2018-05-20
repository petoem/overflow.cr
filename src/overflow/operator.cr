{% begin %}
  struct SafeBox(T)
    # All operators for other : Int16, ...
    # TODO: Forward to method below ?
    {% for type in [Int8, Int16, Int32, Int64, Int128, UInt8, UInt16, UInt32, UInt64, UInt128] %}
      {% for operation, sign in {add: "+", sub: "-", mul: "*"} %}
        @[AlwaysInline]
        def {{sign.id}}(other : {{type}}) : SafeBox(T)
          \{% begin %}
            \{% to_int = {Int8 => ".to_i8", Int16 => ".to_i16", Int32 => ".to_i32", Int64 => ".to_i64", Int128 => ".to_i128", UInt8 => ".to_u8", UInt16 => ".to_u16", UInt32 => ".to_u32", UInt64 => ".to_u64", UInt128 => ".to_u128" }%}
            \{% names = {Int8 => :i8, Int16 => :i16, Int32 => :i32, Int64 => :i64, Int128 => :i128, UInt8 => :i8, UInt16 => :i16, UInt32 => :i32, UInt64 => :i64, UInt128 => :i128} %}      
            result, overflow = Intrinsics.\{{Int::Unsigned.union_types.includes?(@type.type_vars.first) ? "u".id : "s".id}}{{operation.id}}_\{{names[@type.type_vars.first].id}}_with_overflow(value, SafeBox.new(other)\{{to_int[@type.type_vars.first].id}})
            return SafeBox(T).new result unless overflow
            raise IntegerOverflow.new "\{{@type}} \{{Int::Unsigned.union_types.includes?(@type.type_vars.first) ? :u.id : :s.id}}{{operation.id}} {{type}}"
          \{% end %}
        end
      {% end %}
    {% end %}

    # All operators for other : SafeBox(Int16), ...
    {% for type in [Int8, Int16, Int32, Int64, Int128, UInt8, UInt16, UInt32, UInt64, UInt128] %}
      {% for operation, sign in {add: "+", sub: "-", mul: "*"} %}
        @[AlwaysInline]
        def {{sign.id}}(other : SafeBox({{type}})) : SafeBox(T)
          \{% begin %}
            \{% to_int = {Int8 => ".to_i8", Int16 => ".to_i16", Int32 => ".to_i32", Int64 => ".to_i64", Int128 => ".to_i128", UInt8 => ".to_u8", UInt16 => ".to_u16", UInt32 => ".to_u32", UInt64 => ".to_u64", UInt128 => ".to_u128" }%}
            \{% names = {Int8 => :i8, Int16 => :i16, Int32 => :i32, Int64 => :i64, Int128 => :i128, UInt8 => :i8, UInt16 => :i16, UInt32 => :i32, UInt64 => :i64, UInt128 => :i128} %}      
            result, overflow = Intrinsics.\{{Int::Unsigned.union_types.includes?(@type.type_vars.first) ? "u".id : "s".id}}{{operation.id}}_\{{names[@type.type_vars.first].id}}_with_overflow(value, other\{{to_int[@type.type_vars.first].id}})
            return SafeBox(T).new result unless overflow
            raise IntegerOverflow.new "\{{@type}} \{{Int::Unsigned.union_types.includes?(@type.type_vars.first) ? :u.id : :s.id}}{{operation.id}} SafeBox({{type}})"
          \{% end %}
        end
      {% end %}
    {% end %}
  end
{% end %}
