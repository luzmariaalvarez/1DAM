package app;

public class PedidoService {
    private final PedidoRepository repo;
    private static final double IVA = 0.21;
    private static final double ENVIO = 5.0;

    public PedidoService(PedidoRepository repo) {
        this.repo = repo;
    }

    public double calcularTotal(Pedido pedido) {
        double subtotal = 0;
        for (Producto p : pedido.getProductos()) {
            subtotal += p.getPrecio();
        }
        return subtotal * (1 + IVA) + ENVIO;
    }

    public double crearYGuardarPedido(Pedido pedido) {
        if (pedido.getProductos().isEmpty()) {
            throw new IllegalArgumentException("Pedido vacío");
        }
        repo.guardar(pedido);
        return calcularTotal(pedido);
    }
}
