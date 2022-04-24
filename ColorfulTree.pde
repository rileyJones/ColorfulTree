void setup() {
  size(640,640,P2D);
  root.insert(new Node( 0.0,  0.0, #ff0000), root, 0);
  root.insert(new Node( 0.5,  0.0, #00ff00), root, 0);
  root.insert(new Node( 0.0,  0.5, #0000ff), root, 0);
  root.insert(new Node( 0.5,  0.5, #fcf803), root, 0);
  root.insert(new Node(0.75,  0.5, #ff9100), root, 0);
  //root.insert(new Node(0.75, 0.75, #00eeff), root, 0);
  
  //Face
  root.insert(new Node(0.80, 0.75, #00eeff), root, 0);
  root.insert(new Node(0.95, 0.95, #00eeff), root, 0);
  root.insert(new Node(0.80, 0.90, #bd7b46), root, 0);
  root.insert(new Node(0.80, 0.85, #00eeff), root, 0);
  root.insert(new Node(0.75, 0.80, #00eeff), root, 0);
  root.insert(new Node(0.80, 0.80, #bd7b46), root, 0);
  root.insert(new Node(0.85, 0.80, #00eeff), root, 0);
  root.insert(new Node(0.90, 0.80, #bd7b46), root, 0);
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
  for(float x = 0.0; x < 1.0; x += 0.05) {
    for(float y = 0.0; y < 1.0; y += 0.05) {
      fill(root.get(x,y));
      rect(floor(width*x), floor(height*y), ceil(width*0.05), ceil(height*0.05));
    }
  }
}
