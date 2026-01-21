public class Factura {

    public void f(int a, int b, String c) {
        int x = 0;

        if (a > 0) {
            x = a * b;
        } else {
            x = b;
        }

        if (c.equals("A")) {
            x = x + 10;
        } else if (c.equals("B")) {
            x = x + 20;
        }

        System.out.println("Total: " + x);
    }
}
