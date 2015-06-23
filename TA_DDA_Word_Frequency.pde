import java.util.*;

String[] text;
Map<String, Integer> map = new HashMap<String, Integer>();
int j =1;     
String delimiters = ",.?!;:[]- ";
 
void setup() {
  size (400, 400);
  //textSize(32);
  String[] rawtext = loadStrings ("test.txt");
  String everything = join(rawtext, " ");
  text = splitTokens(everything, delimiters);
  
  for (String w : text) {    
    Integer n = map.get(w);
        n = (n == null) ? 1 : ++n;
        map.put(w, n);
    }
 
    Set set = map.entrySet();
      // Get an iterator
      Iterator i = set.iterator();
      // Display elements
      while(i.hasNext()) {
         Map.Entry me = (Map.Entry)i.next();
         print(me.getKey() + ": ");
         println(me.getValue());
         String nama = me.getKey().toString();
         Integer jumlah =(Integer) me.getValue();
         fill(0);
         text(nama,10,10*j*2);
         fill(random(255),random(255),random(255));
         rect(80,20*j-10,10*jumlah,10);
         fill(0);
         j++;
      }
}
 
void draw() {
    
}
