from decimal import Decimal, ROUND_DOWN


def dividir_en_cuotas(total: str, n: int) -> list[Decimal]:
    """Divide un importe en n cuotas de 2 decimales que suman exactamente el total."""
    if n < 1:
        raise ValueError("n debe ser >= 1")
    total_d = Decimal(total)
    base = (total_d / n).quantize(Decimal("0.01"), rounding=ROUND_DOWN)
    cuotas = [base] * n
    # El resto (céntimos que se pierden al redondear) va a la primera cuota
    cuotas[0] += total_d - base * n
    return cuotas
