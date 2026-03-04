package app;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class InMemoryPedidoRepository implements PedidoRepository {
    private final List<Pedido> pedidos = new ArrayList<>();

    @Override
    public void guardar(Pedido pedido) {
        if (pedido == null) throw new IllegalArgumentException("Pedido null");
        pedidos.add(pedido);
    }

    @Override
    public List<Pedido> listar() {
        return Collections.unmodifiableList(pedidos);
    }
}
