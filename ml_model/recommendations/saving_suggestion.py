def generate(financial_metrics):

    recommendations = []

    current_profit     = financial_metrics["current_profit"]
    current_revenue    = financial_metrics["current_revenue"]
    profit_margin      = financial_metrics["profit_margin"]
    expense_growth     = financial_metrics["expense_growth"]
    revenue_growth     = financial_metrics["revenue_growth"]
    budget_utilization = financial_metrics["budget_utilization"]
    total_budget       = financial_metrics["total_budget"]
    budget_variance    = financial_metrics["budget_variance"]

    # =====================================================
    # RULE 1: PROFIT EXISTS BUT MARGIN IS THIN
    # Savings habit should start now before margin erodes.
    # =====================================================

    if current_profit > 0 and profit_margin < 15:

        recommendations.append({
            "recommendation_type": "saving_suggestion",
            "message": (
                f"You are generating a profit of ₹{current_profit:,.0f} "
                f"but margin is thin at {profit_margin:.1f}%. "
                f"Start setting aside even a small fixed amount each month to build a financial buffer."
            ),
            "priority": "medium"
        })

    # =====================================================
    # RULE 2: DECENT MARGIN — ENCOURAGE FORMAL SAVING
    # A portion of healthy margin should be set aside.
    # =====================================================

    elif profit_margin >= 15 and profit_margin < 30:

        suggested_saving = round(current_profit * 0.20, 0)

        recommendations.append({
            "recommendation_type": "saving_suggestion",
            "message": (
                f"Profit margin is at {profit_margin:.1f}% (₹{current_profit:,.0f}). "
                f"Consider saving at least 20% of monthly profit — "
                f"approximately ₹{suggested_saving:,.0f} — as a financial reserve."
            ),
            "priority": "medium"
        })

    # =====================================================
    # RULE 3: STRONG MARGIN — ALLOCATE SAVINGS FORMALLY
    # No excuse not to save with margins this healthy.
    # =====================================================

    elif profit_margin >= 30:

        suggested_saving = round(current_profit * 0.30, 0)

        recommendations.append({
            "recommendation_type": "saving_suggestion",
            "message": (
                f"Profit margin is strong at {profit_margin:.1f}% (₹{current_profit:,.0f}). "
                f"Allocate at least 30% of profit — ₹{suggested_saving:,.0f} — "
                f"into a dedicated savings or emergency fund."
            ),
            "priority": "high"
        })

    # =====================================================
    # RULE 4: SILENT EXPENSE CREEP
    # Expenses rising faster than revenue quietly erodes savings.
    # =====================================================

    if expense_growth > 10 and revenue_growth < expense_growth:

        recommendations.append({
            "recommendation_type": "saving_suggestion",
            "message": (
                f"Expenses grew by {expense_growth:.1f}% while revenue grew by only {revenue_growth:.1f}%. "
                f"This silent creep will erode savings over time. "
                f"Review and cap non-essential spending before it compounds."
            ),
            "priority": "medium"
        })

    # =====================================================
    # RULE 5: UNDERUTILISED BUDGET — REDIRECT TO SAVINGS
    # Unspent budget is an opportunity, not a free pass to spend.
    # =====================================================

    if budget_utilization > 0 and budget_utilization < 50 and current_profit > 0:

        unspent = abs(budget_variance)

        recommendations.append({
            "recommendation_type": "saving_suggestion",
            "message": (
                f"Only {budget_utilization:.1f}% of the budget has been utilised. "
                f"The unspent ₹{unspent:,.0f} could be redirected into savings "
                f"rather than carried forward as discretionary spend."
            ),
            "priority": "low"
        })

    return recommendations