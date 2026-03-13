public class Notas {

    public static double calcular(String nombre, double e1, double e2, double p, double asistencia) {

        double r = 0;

        if (e1 < 0 || e2 < 0 || p < 0) {
            System.out.println("Error en notas");
            return -1;
        }

        double mediaExamenes = (e1 + e2) / 2;

        if (mediaExamenes >= 5) {
            r = mediaExamenes * 0.6 + p * 0.3 + asistencia * 0.1;
        } else {
            r = mediaExamenes * 0.6 + p * 0.3;
        }

        if (asistencia > 10) {
            asistencia = 10;
        }

        if (r > 10) {
            r = 10;
        }

        if (r >= 5) {
            System.out.println(nombre + " aprobado con " + r);
        } else {
            System.out.println(nombre + " suspenso con " + r);
        }

        if (r >= 9) {
            System.out.println("Excelente");
        } else if (r >= 7) {
            System.out.println("Notable");
        } else if (r >= 5) {
            System.out.println("Aprobado");
        } else {
            System.out.println("Suspenso");
        }

        return r;
    }

    public static void main(String[] args) {

        double n1 = calcular("Ana", 7, 6, 8, 9);
        double n2 = calcular("Luis", 3, 4, 6, 8);
        double n3 = calcular("Marta", 9, 9, 10, 10);

        System.out.println("Notas finales:");
        System.out.println(n1);
        System.out.println(n2);
        System.out.println(n3);
    }
}