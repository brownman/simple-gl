require 'rubygems'
require 'simple_gl/glut_app'

include SimpleGl

$ctrlpoints = [
	[-4.0,-4.0, 0.0],
	[-2.0, 4.0, 0.0],
	[ 2.0,-4.0, 0.0],
	[ 4.0, 4.0, 0.0]
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
    glClear(GL_COLOR_BUFFER_BIT)
    glColor(1.0, 1.0, 1.0)
    glBegin(GL_LINE_STRIP)
    for i in 0..30
      glEvalCoord1d(i.to_f/30.0)
    end
    glEnd
    # The following code displays the control points as dots.
    glPointSize(5.0)
    glColor(1.0, 1.0, 0.0)
    glBegin(GL_POINTS)
    for i in 0...4
      glVertex($ctrlpoints[i])
    end
    glEnd
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
