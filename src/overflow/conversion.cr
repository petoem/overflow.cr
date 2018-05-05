{% begin %}
  {% sizes = [8, 16, 32, 64, 128] %}
  {% ints = {to_i: 32, to_i8: 8, to_i16: 16, to_i32: 32, to_i64: 64, to_i128: 128} %}
  {% uints = {to_u: 32, to_u8: 8, to_u16: 16, to_u32: 32, to_u64: 64, to_u128: 128}%}
  {% for size in sizes %}
    struct Int{{size.id}}
      {% for method, method_size in ints %}
        def {{method.id}} : Int{{method_size.id}}
          {% if method_size >= size %}
            previous_def
          {% else %}
            return previous_def if Int{{method_size.id}}::MIN <= self <= Int{{method_size.id}}::MAX
            raise IntegerOverflow.new "#{self} too big or small for Int{{size.id}}\u0023{{method.id}}"
          {% end %}
        end
      {% end %}
    
      {% for method, method_size in uints %}
        def {{method.id}} : UInt{{method_size.id}}
          {% if method_size >= size %}
            return previous_def if UInt{{method_size.id}}::MIN <= self
          {% else %}
            return previous_def if UInt{{method_size.id}}::MIN <= self <= UInt{{method_size.id}}::MAX
          {% end %}
          raise IntegerOverflow.new "#{self} too big or small for Int{{size.id}}\u0023{{method.id}}"
        end
      {% end %}
    end

    struct UInt{{size.id}}
      {% for method, method_size in uints %}
        def {{method.id}} : UInt{{method_size.id}}
          {% if method_size >= size %}
            previous_def
          {% else %}
            return previous_def if self <= UInt{{method_size.id}}::MAX
            raise IntegerOverflow.new "#{self} too big for UInt{{size.id}}\u0023{{method.id}}"
          {% end %}
        end
      {% end %}

      {% for method, method_size in ints %}
        def {{method.id}} : Int{{method_size.id}}
          {% if method_size > size %}
            previous_def
          {% else %}
            return previous_def if self <= Int{{method_size.id}}::MAX
            raise IntegerOverflow.new "#{self} too big for UInt{{size.id}}\u0023{{method.id}}"
          {% end %}
        end
      {% end %}
    end
  {% end %}
{% end %}
