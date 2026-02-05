public class Factura {

    // Constantes para evitar números mágicos
    private static final int RECARGO_A = 10;
    private static final int RECARGO_B = 20;

    /**
     * Calcula e imprime el total de una factura.
     * Mantiene el mismo comportamiento que la versión sin corregir,
     * pero con mejor legibilidad y mantenibilidad.
     */
    public void calcularTotal(int unidades, int precioUnidad, String tipoFactura) {
        int base = calcularBase(unidades, precioUnidad);
        int totalFinal = aplicarRecargo(tipoFactura, base);
        imprimirTotal(totalFinal);
    }

    private int calcularBase(int unidades, int precioUnidad) {
        if (unidades > 0) {
            return unidades * precioUnidad;
        }
        return precioUnidad;
    }

    private int aplicarRecargo(String tipoFactura, int total) {
        if ("A".equals(tipoFactura)) {
            return total + RECARGO_A;
        }
        if ("B".equals(tipoFactura)) {
            return total + RECARGO_B;
        }
        return total;
    }

    private void imprimirTotal(int total) {
        System.out.println("Total: " + total);
    }
}
