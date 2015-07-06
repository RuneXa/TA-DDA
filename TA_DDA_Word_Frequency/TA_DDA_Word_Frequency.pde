import java.util.*;
import java.io.*;


String[] text;
Map<String, Integer> map = new HashMap<String, Integer>();
String delimiters = ",.?!;:[]- ";
String textFile; 
String Filename;

void setup() {
  size (400, 400);
  background(255);
  selectInput("Pilih file text yang ingin diproses", "setFile");   
}

void setFile(File selected)
{
 if(selected == null){
  exit();
 } 
 else
 {
  textFile = selected.getAbsolutePath();
  Filename = selected.getName();
  print(Filename + "\n"); 
  print(textFile + "\n"); 
 }
}

void draw() {
  //textSize(32);
  if(textFile!=null){
    noLoop();
    String[] rawtext = loadStrings (textFile);
    //String[] rawtext = loadStrings ("test.txt");
    //String[] rawtext = loadStrings ("http://runexa.tumblr.com/post/111177700198/about-tipe-tipe-ancaman-keamanan-komputer");
    String everything = join(rawtext, " ");
    everything = everything.toLowerCase();
    text = splitTokens(everything, delimiters);
    
    for (String w : text) {    
      Integer n = map.get(w);
          n = (n == null) ? 1 : ++n;
          map.put(w, n);
      }
     
     background(255); //cls
     
     drawHeader(); 
     drawButton();
     
     
     Map<String, Integer> sortedMap = sortByValue(map);
     int j =1; //loop iterator index
        Set set = sortedMap.entrySet();
        Iterator i = set.iterator();
        while(i.hasNext()) {
           Map.Entry me = (Map.Entry)i.next();
           print(me.getKey() + ": ");
           println(me.getValue());
           String nama = me.getKey().toString();
           Integer jumlah =(Integer) me.getValue();
           drawChart(j,nama,jumlah);
           j++;
           if(j==11)
           {
            break; //mencari 10 kata terbanyak 
           }
        }  
  }
}

void mousePressed() {
  if (mouseX > 20 && mouseX < 100 && mouseY > 340 && mouseY < 380) { //button refresh
    text = null;
    map.clear();
    map = new HashMap<String, Integer>();
    redraw(); 
  }
 
  if (mouseX > 280 && mouseX < 380 && mouseY > 340 && mouseY < 380) { //button browse
    textFile = null;    
    text = null;
    map.clear();
    map = new HashMap<String, Integer>();
    selectInput("Pilih file text yang ingin diproses", "setFile");
    redraw();  
  }
  
}

void drawHeader()
{
 fill(0);
 rectMode(CENTER);
 textAlign(CENTER, CENTER);
 textSize(18);
 text("Word Count Program\nMade by : Richie,Nelvson,Abdiel",width/2,height/2-175,400,100);
 line(0,55,width,55);
 textSize(32);
 textAlign(CENTER, CENTER);
 text(Filename,width/2,height/2-100,400,50);
 textSize(12);
 textAlign(LEFT);
 rectMode(CORNER);
}


void drawButton()
{
 //button refresh
 fill(255);
 rect(20,340,100,40);
 fill(0);
 text("Refresh",50,360);
 
 //button browse File
 fill(255);
 rect(280,340,100,40);
 fill(0);
 text("Browse",310,360);
 
}


void drawChart(int j, String nama, int jumlah) {
   boolean over30 = false;
   int jumlahConst;
   fill(0);
   if(jumlah > 30)
   {
    jumlahConst = 30;
    over30 = true;
   }
   else
   {
    jumlahConst = jumlah; 
   }
   
   pushMatrix();
   translate(0,height/2 - 80);
   fill(0);
   rect(80,20*j-10,300,10); //box hitam
   float mapJumlah = jumlahConst * 1 / 30;
   float persenJumlah = 255 * mapJumlah;
   fill(persenJumlah,255 - persenJumlah,0);
   rect(80,20*j-10,10*jumlahConst,10);
   fill(0);

   text(nama,10,10*j*2);
   text(jumlah,82.5,10*j*2);
   popMatrix();   
} 





 
public static Map sortByValue(Map unsortMap) { //compare o2 ke o1 biar menurun  
  List list = new LinkedList(unsortMap.entrySet());
 
  Collections.sort(list, new Comparator() {
    public int compare(Object o1, Object o2) {
      return ((Comparable) ((Map.Entry) (o2)).getValue())
            .compareTo(((Map.Entry) (o1)).getValue());
    }
  });
 
  Map sortedMap = new LinkedHashMap();
  for (Iterator it = list.iterator(); it.hasNext();) {
    Map.Entry entry = (Map.Entry) it.next();
    sortedMap.put(entry.getKey(), entry.getValue());
  }
  return sortedMap;
}
