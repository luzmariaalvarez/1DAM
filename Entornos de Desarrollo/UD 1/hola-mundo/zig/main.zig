// Programa: Hola mundo en Zig
// Compilar: zig build-exe main.zig
const std = @import("std");

pub fn main() !void {
    // Obtener el escritor de stdout y escribir la cadena
    try std.io.getStdOut().writer().print("Hola mundo\n", .{});
}
