def generate(financial_metrics):

    recommendations = []

    profit_margin = financial_metrics["profit_margin"]
    revenue_growth = financial_metrics["revenue_growth"]
    expense_growth = financial_metrics["expense_growth"]
    expense_ratio = financial_metrics["expense_ratio"]

    current_revenue = financial_metrics["current_revenue"]
    current_expenses = financial_metrics["current_expenses"]
    predicted_profit = financial_metrics["predicted_profit"]

    # =====================================================
    # RULE 1: DANGEROUSLY HIGH BURN RATE
    # Spending 80%+ of revenue on costs is a critical signal.
    # =====================================================

    if expense_ratio > 80:

        recommendations.append({
            "recommendation_type": "expense_reduction",
            "message": (
                f"Expenses (₹{current_expenses:,.0f}) are consuming {expense_ratio:.1f}% "
                f"of revenue (₹{current_revenue:,.0f}). Immediate cost review is recommended."
            ),
            "priority": "high"
        })

    # =====================================================
    # RULE 2: EXPENSES SCALING FASTER THAN REVENUE
    # Business is losing operational efficiency.
    # =====================================================

    if expense_growth > revenue_growth and expense_growth > 20:

        recommendations.append({
            "recommendation_type": "expense_reduction",
            "message": (
                f"Expenses grew by {expense_growth:.1f}% while revenue grew by only {revenue_growth:.1f}%. "
                f"Review variable and operational costs before the gap widens further."
            ),
            "priority": "high"
        })

    # =====================================================
    # RULE 3: THIN PROFIT MARGINS
    # Low margins leave no buffer — cost optimisation is necessary.
    # =====================================================

    if profit_margin < 10 and current_expenses > 0:

        recommendations.append({
            "recommendation_type": "expense_reduction",
            "message": (
                f"Profit margin is at {profit_margin:.1f}%. "
                f"Reducing non-essential expenses from the current ₹{current_expenses:,.0f} "
                f"could meaningfully improve profitability."
            ),
            "priority": "medium"
        })

    # =====================================================
    # RULE 4: COST RISE WITHOUT REVENUE JUSTIFICATION
    # Expenses increasing while revenue stagnates — pure inefficiency.
    # =====================================================

    if expense_growth > 15 and revenue_growth < 5:

        recommendations.append({
            "recommendation_type": "expense_reduction",
            "message": (
                f"Costs rose by {expense_growth:.1f}% but revenue grew by only {revenue_growth:.1f}%. "
                f"Audit recent expense increases to identify and eliminate inefficiencies."
            ),
            "priority": "medium"
        })

    # =====================================================
    # RULE 5: PREDICTED LOSS NEXT MONTH
    # Proactive cost cutting before the loss materialises.
    # =====================================================

    if predicted_profit < 0:

        recommendations.append({
            "recommendation_type": "expense_reduction",
            "message": (
                f"A loss of ₹{abs(predicted_profit):,.0f} is forecasted next month. "
                f"Cutting costs now could prevent or reduce the deficit."
            ),
            "priority": "high"
        })

    return recommendations