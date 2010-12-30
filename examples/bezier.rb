require 'rubygems'
require 'simple_gl/glut_app'

include SimpleGl

$ctrlpoints = [
[ -4, -4, 0 ],
[ -2, 4, 0 ],
[ 2, -4, 0 ],
[ 4, 4, 0 ],
]

app = GlutApp.new do
  init do
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
    glutInitWindowSize(500, 500)
    glutInitWindowPosition(100, 100)
    glutCreateWindow

    glClearColor(0.0, 0.0, 0.0, 0.0)
    glShadeModel(GL_FLAT)
    glMap1d(GL_MAP1_VERTEX_3, 0.0, 1.0, 3, 4, $ctrlpoints.flatten)
    glEnable(GL_MAP1_VERTEX_3)
  end

  display do
    @gl.clear
    @gl.color 1, 1, 1
    @gl.begin :line_strip do
      for i in 0..30
        glEvalCoord1d(i.to_f/30.0)
      end
    end

    # The following code displays the control points as dots.
    @gl.point_size = 5
    @gl.color 1, 1, 0

    @gl.begin :points do
      for i in 0...4
        vertex -4, -4, 0
        vertex -2, 4, 0
        vertex 2, -4, 0
        vertex 4, 4, 0
      end
    end

    glutSwapBuffers
  end

  reshape do |w, h|
    glViewport(0, 0, w, h)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity
    if (w <= h)
      glOrtho(-5.0, 5.0, -5.0*h/w, 5.0*h/w, -5.0, 5.0)
    else
      glOrtho(-5.0*w/h, 5.0*w/h, -5.0, 5.0, -5.0, 5.0)
    end
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity
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
