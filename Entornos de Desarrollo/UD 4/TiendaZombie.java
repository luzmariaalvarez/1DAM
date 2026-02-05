public class ZombieShop {
static ArrayList<String> n = new ArrayList<>();
static ArrayList<Double> p = new ArrayList<>();
static ArrayList<Integer> s = new ArrayList<>();
public static void main(String[] args) {
n.add("Camiseta"); p.add(12.99); s.add(10);
n.add("Sudadera"); p.add(29.99); s.add(5);
n.add("Gorra"); p.add(9.99); s.add(20);
Scanner sc = new Scanner(System.in);
int op = -1;
while(op != 0) {
System.out.println("\n1 ver | 2 comprar | 3 add | 4 buscar | 5
informe | 0 salir");
op = Integer.parseInt(sc.nextLine());
if(op == 1) {

for(int i=0;i<n.size();i++){
System.out.println((i+1)+". "+n.get(i)+" - "+p.get(i)+"€ -
stock:"+s.get(i));
}
} else if(op == 2) {
System.out.print("Producto (numero): ");
int id = Integer.parseInt(sc.nextLine())-1;
if(id>=0 && id<n.size()) {
System.out.print("Cantidad: ");
int c = Integer.parseInt(sc.nextLine());
if(c>0 && s.get(id)>=c) {
s.set(id, s.get(id)-c);
double total = p.get(id)*c;
if(total>50) total = total*0.9;
System.out.println("Total: "+total+"€");
} else {
System.out.println("No hay stock o cantidad invalida");
}
} else {
System.out.println("No existe");
}
} else if(op == 3) {
System.out.print("Nombre: ");
String nn = sc.nextLine();
System.out.print("Precio: ");
double pp = Double.parseDouble(sc.nextLine());
System.out.print("Stock: ");
int ss = Integer.parseInt(sc.nextLine());
n.add(nn); p.add(pp); s.add(ss);
System.out.println("OK");
} else if(op == 4) {
System.out.print("Texto: ");
String t = sc.nextLine().toLowerCase();
boolean f = false;
for(int i=0;i<n.size();i++){
if(n.get(i).toLowerCase().contains(t)) {
System.out.println("ENCONTRADO: "+n.get(i)+"
"+p.get(i)+"€ stock:"+s.get(i));

f = true;
}
}
if(!f) System.out.println("Nada");
} else if(op == 5) {
double sum = 0;
int totalStock = 0;
for(int i=0;i<n.size();i++){
sum += p.get(i)*s.get(i);
totalStock += s.get(i);
}
System.out.println("Valor inventario: "+sum+"€ | unidades:
"+totalStock);
} else if(op == 0) {
System.out.println("bye");
} else {
System.out.println("op invalida");
}
}
}
}
