def dividir_en_cuotas(total: str, n: int) -> list[float]:
    cuota = round(float(total) / n, 2)
    return [cuota] * n
