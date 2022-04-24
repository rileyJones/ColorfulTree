import javax.swing.JColorChooser;
import java.awt.Color;

void setup() {
  size(640,640,P2D);
  
}

Node root = new Node(1.0, 1.0, #000000);



class Node {
  float posX;
  float posY;
  int cVal;
  Node N00;
  Node N01;
  Node N10;
  Node N11;
  Node(float posX, float posY, int cVal) {
    this.posX = posX;
    this.posY = posY;
    this.cVal = cVal;
  }
  int get(float x, float y) {
    if(x < posX && y < posY) {
      if(N00 == null) {
        return cVal;
      } else {
        return N00.get(x,y);
      }
    }
    else if(x < posX) {
      if(N10 == null) {
        return cVal;
      } else {
        return N10.get(x,y);
      }
    }
    else if(y < posY) {
      if(N01 == null) {
        return cVal;
      } else {
        return N01.get(x,y);
      }
    }
    else {
      if(N11 == null) {
        return cVal;
      } else {
        return N11.get(x,y);
      }
    }
  }
  void insert(Node n, Node p, int pos) {
    if(N00 == null && N01 == null && N10 == null && N11 == null && p != this) {
      Node insertable = new Node(max(this.posX,n.posX), max(this.posY, n.posY), this.cVal);
      insertable.insert(this, insertable, 0);
      insertable.insert(n, insertable, 0);
      switch(pos){
        case 0:
          p.N00 = insertable;
          break;
        case 1:
          p.N01 = insertable;
          break;
        case 2:
          p.N10 = insertable;
          break;
        case 3:
          p.N11 = insertable;
          break;
      } 
    } else {
      if(n.posX < this.posX && n.posY < this.posY) {
        if(N00 == null) {
          N00 = n;
        } else {
          N00.insert(n,this,0);
        }
      }
      else if(n.posX < this.posX) {
        if(N10 == null) {
          N10 = n;
        } else {
          N10.insert(n,this,2);
        }
      }
      else if(n.posY < this.posY) {
        if(N01 == null) {
          N01 = n;
        } else {
          N01.insert(n,this,1);
        }
      }
      else {
        if(N11 == null) {
          N11 = n;
        } else {
          N11.insert(n,this,3);
        }
      }
    }
  }
}


void draw() {
  background(#e0e0e0);
  noStroke();
  for(float x = 0.0; x < 1.0; x += 1.0/width) {
    for(float y = 0.0; y < 1.0; y += 1.0/height) {
      fill(root.get(x,y));
      rect(floor(width*x), floor(height*y), ceil(width*0.05), ceil(height*0.05));
    }
  }
}




int currentColor = #000000;


void mouseClicked() {
  if(mouseButton == LEFT) {
    root.insert(new Node( mouseX*1.0/width,  mouseY*1.0/height, currentColor), root, 0);
    println( "Drew:" + hex(currentColor) );
  } else if(mouseButton == RIGHT) {
    Color javaColor = new Color(#000000, true);
    javaColor = JColorChooser.showDialog(null, "Java Color Chooser", javaColor);
    if (javaColor != null ) {  
      currentColor = #FF000000+(javaColor.getRed() << 16 ) | (javaColor.getGreen() << 8 ) | (javaColor.getBlue() << 0 );
      println( "Picked:" + hex(currentColor) );
    }
  }
  
}
