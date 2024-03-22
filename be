#include<windows.h>
#include <GL/glut.h>
#include <stdlib.h>
#include<math.h>

class point
{
    public:
    int x,y;
    point(int xval,int yval)
    {
        x=xval;
        y=yval;
    }

    point()
    {
        x=0;
        y=0;
    }
};

point pts[100];
int i=0;
void init()
{
    glClearColor(1,1,1,0);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0,640,0,480);
}

void bezier_curve()
{
    point p0(pts[i-4]);
    point p1(pts[i-3]);
    point p2(pts[i-2]);
    point p3(pts[i-1]);
    float t=0;
    for(int i=0;i<100;i++)
    {
        float x=pow(1-t,3)*p0.x+3*pow(1-t,2)*t*p1.x+3*pow(1-t,1)*t*t*p2.x+pow(t,3)*p3.x;
        float y=pow(1-t,3)*p0.y+3*pow(1-t,2)*t*p1.y+3*pow(1-t,1)*t*t*p2.y+pow(t,3)*p3.y;
        glBegin(GL_POINTS);
            glVertex2f(x,y);
        glEnd();
        glFlush();
        t+=0.01;
    }
}

static void mouse(int button,int state, int x,int y)
{
    if(button==GLUT_LEFT_BUTTON && state==GLUT_DOWN)
    {
        y=480-y;
        point p(x,y);
        pts[i]=p;
        glPointSize(2);
        glColor3f(1,0,0);
        glBegin(GL_POINTS);
        {
            glVertex2d(pts[i].x,pts[i].y);
        }
        glEnd();
        glFlush();
        i+=1;
    }

    if(button==GLUT_RIGHT_BUTTON && state==GLUT_DOWN)
    {
        bezier_curve();
    }
}

static void display(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glColor3d(1,0,0);

}

int main(int argc, char *argv[])
{
    glutInit(&argc, argv);
    glutInitWindowSize(640,480);
    glutInitWindowPosition(10,10);
    glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
    glutCreateWindow("GLUT Shapes");
    glutDisplayFunc(display);
    glutMouseFunc(mouse);
    init();
    glutMainLoop();
    return 0;
}
