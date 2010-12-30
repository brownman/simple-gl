module Constants
  def gl_constant(type)
    case type
    when :line_strip then GL_LINE_STRIP
    when :points     then GL_POINTS
    else
      raise "Unknown constant lookup"
    end
  end
end
