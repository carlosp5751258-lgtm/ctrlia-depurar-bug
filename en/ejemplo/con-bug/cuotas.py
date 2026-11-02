def split_into_installments(total: str, n: int) -> list[float]:
    installment = round(float(total) / n, 2)
    return [installment] * n
