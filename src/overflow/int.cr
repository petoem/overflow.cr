# TODO: Int / SafeBox
# Int comparison ?
struct Int
  include Comparable(SafeBox)

  def <=>(other : SafeBox)
    self <=> other.value
  end

  {% for operator in ["+", "-", "*"] %}
    def {{operator.id}}(other : SafeBox(T)) : SafeBox(self) forall T
      SafeBox.new(self) {{operator.id}} other
    end
  {% end %}
end

# TODO: Float comparison ?
struct Float
  include Comparable(SafeBox)

  def <=>(other : SafeBox)
    self <=> other.value
  end
  
  {% for operator in ["+", "-", "*", "/"] %}
    def {{operator.id}}(other : SafeBox(T)) : self forall T
      self {{operator.id}} other.to_f64
    end
  {% end %}
end
