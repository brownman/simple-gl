require 'rubygems'
require 'simple_gl/glut_app'

include SimpleGl

$ctrlpoints = [
  [ -4, -4, 0 ],
  [ -2,  4, 0 ],
  [  2, -4, 0 ],
  [  4,  4, 0 ],
]

app = GlutApp.new do
  init do
    glut.init_display_mode(GLUT_DOUBLE | GLUT_RGB)
    glut.init_window_size(500, 500)
    glut.init_window_position(100, 100)
    glut.create_window

    gl.clear_color(0.0, 0.0, 0.0, 0.0)
    gl.shade_model(GL_FLAT)
    gl.map1d(GL_MAP1_VERTEX_3, 0.0, 1.0, 3, 4, $ctrlpoints.flatten)
    gl.enable(GL_MAP1_VERTEX_3)
  end

  display do
    gl.clear
    gl.color 1, 1, 1
    gl.begin :line_strip do
      for i in 0..30
        eval_coord1d(i.to_f/30.0)
      end
    end

    # The following code displays the control points as dots.
    gl.point_size = 5
    gl.color 1, 1, 0

    gl.begin :points do
      vertex -4, -4, 0
      vertex -2,  4, 0
      vertex  2, -4, 0
      vertex  4,  4, 0
    end

    glut.swap_buffers
  end

  reshape do |w, h|
    gl.viewport(0, 0, w, h)

    gl.matrix_mode(GL_PROJECTION)
    gl.load_identity
    if (w <= h)
      gl.ortho(-5.0, 5.0, -5.0*h/w, 5.0*h/w, -5.0, 5.0)
    else
      gl.ortho(-5.0*w/h, 5.0*w/h, -5.0, 5.0, -5.0, 5.0)
    end
    gl.matrix_mode(GL_MODELVIEW)
    gl.load_identity
  end

  keyboard do |key, x, y|
    case (key)
    when ?\e
      exit(0)
    end
  end
end

app.start
app.main_loop
