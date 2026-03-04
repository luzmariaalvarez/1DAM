package app;

import java.util.List;

public interface PedidoRepository {
    void guardar(Pedido pedido);
    List<Pedido> listar();
}
