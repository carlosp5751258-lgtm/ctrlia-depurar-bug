from decimal import Decimal, ROUND_DOWN


def split_into_installments(total: str, n: int) -> list[Decimal]:
    """Splits an amount into n 2-decimal installments that add up exactly to the total."""
    if n < 1:
        raise ValueError("n must be >= 1")
    total_d = Decimal(total)
    base = (total_d / n).quantize(Decimal("0.01"), rounding=ROUND_DOWN)
    installments = [base] * n
    # The remainder (cents lost when rounding) goes to the first installment
    installments[0] += total_d - base * n
    return installments
