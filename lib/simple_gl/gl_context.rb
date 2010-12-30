require 'opengl'
require 'simple_gl/constants'

class GlContext
  include Constants

  def clear
    GL.Clear(GL_COLOR_BUFFER_BIT)
  end

  def color(*args)
    args.map! &:to_f
    GL.Color(*args)
  end

  def point_size=(v)
    GL.PointSize(v.to_f)
  end

  def begin(type, &block)
    GL.Begin(gl_constant(type))

    instance_eval(&block)

    GL.End
  end

  def vertex(*args)
    args.map! &:to_f
    GL.Vertex(*args)
  end
end
