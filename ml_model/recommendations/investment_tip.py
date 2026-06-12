def generate(financial_metrics):

    recommendations = []

    profit_margin = financial_metrics["profit_margin"]
    revenue_growth = financial_metrics["revenue_growth"]
    expense_growth = financial_metrics["expense_growth"]
    expense_ratio = financial_metrics["expense_ratio"]

    current_revenue = financial_metrics["current_revenue"]
    current_expenses = financial_metrics["current_expenses"]
    current_profit = financial_metrics["current_profit"]

    predicted_profit = financial_metrics["predicted_profit"]
    predicted_profit_change = financial_metrics["predicted_profit_change"]

    # =====================================================
    # RULE 1: HEALTHY PROFIT MARGIN
    # Business has sufficient retained earnings to deploy capital.
    # =====================================================

    if profit_margin >= 20:

        recommendations.append({
            "recommendation_type": "investment_tip",
            "message": (
                f"Profit margin is strong at {profit_margin:.1f}% (₹{current_profit:,.0f} on ₹{current_revenue:,.0f} revenue). "
                f"Consider reinvesting surplus into growth initiatives or assets."
            ),
            "priority": "high"
        })

    # =====================================================
    # RULE 2: EFFICIENT SCALING
    # Revenue growing faster than expenses — a healthy scaling signal.
    # =====================================================

    if revenue_growth > expense_growth and revenue_growth > 10:

        recommendations.append({
            "recommendation_type": "investment_tip",
            "message": (
                f"Revenue is growing at {revenue_growth:.1f}% while expenses grew by only {expense_growth:.1f}%. "
                f"This is an optimal window to invest in scaling operations."
            ),
            "priority": "high"
        })

    # =====================================================
    # RULE 3: LOW EXPENSE BURN RATE
    # Low expense ratio means investable surplus exists.
    # =====================================================

    if expense_ratio < 65:

        recommendations.append({
            "recommendation_type": "investment_tip",
            "message": (
                f"Only {expense_ratio:.1f}% of revenue (₹{current_expenses:,.0f} of ₹{current_revenue:,.0f}) "
                f"is spent on expenses. Surplus funds could be directed toward strategic investments."
            ),
            "priority": "medium"
        })

    # =====================================================
    # RULE 4: STRONG PROFIT GROWTH FORECAST
    # Forward-looking confidence for capital deployment.
    # =====================================================

    if predicted_profit_change >= 20:

        recommendations.append({
            "recommendation_type": "investment_tip",
            "message": (
                f"Profit is forecasted to grow by {predicted_profit_change:.1f}%, reaching ₹{predicted_profit:,.0f}. "
                f"Now is a good time to plan long-term investments."
            ),
            "priority": "high"
        })

    elif predicted_profit_change >= 10:

        recommendations.append({
            "recommendation_type": "investment_tip",
            "message": (
                f"Moderate profit growth of {predicted_profit_change:.1f}% is expected, "
                f"with forecasted profit at ₹{predicted_profit:,.0f}. "
                f"Consider smaller, targeted investment opportunities."
            ),
            "priority": "medium"
        })

    # =====================================================
    # RULE 5: FALLING COSTS WITH HEALTHY MARGIN
    # Declining expenses while margins hold — freed-up capital signal.
    # =====================================================

    if expense_growth < 0 and profit_margin > 10:

        recommendations.append({
            "recommendation_type": "investment_tip",
            "message": (
                f"Expenses declined by {abs(expense_growth):.1f}% while profit margin holds at {profit_margin:.1f}%. "
                f"Freed-up capital of approximately ₹{current_profit:,.0f} is available for investment."
            ),
            "priority": "medium"
        })

    # =====================================================
    # RULE 6: POSITIVE PREDICTED PROFIT (SAFETY GATE)
    # Only suggest investment if future outlook is not negative.
    # Suppress all tips if predicted profit is a loss.
    # =====================================================

    if predicted_profit < 0:
        return []

    return recommendations