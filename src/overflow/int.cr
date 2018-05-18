# TODO: Int / SafeBox
struct Int
  include Comparable(SafeBox)

  def <=>(other : SafeBox)
    self <=> other.value
  end

  {% for operator in ["+", "-", "*"] %}
    def {{operator.id}}(other : SafeBox) : SafeBox(self)
      SafeBox.new(self) {{operator.id}} other
    end
  {% end %}
end

struct Float
  include Comparable(SafeBox)

  def <=>(other : SafeBox)
    self <=> other.value
  end
  
  {% for operator in ["+", "-", "*", "/"] %}
    def {{operator.id}}(other : SafeBox) : self
      self {{operator.id}} other.to_f64
    end
  {% end %}
end
