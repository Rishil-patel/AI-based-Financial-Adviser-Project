from ml_model.database.db_connection import engine
from ml_model.utils.build_financial_metrics import get_financial_metrics
from ml_model.recommendations.expense_reduction import generate as expense_reduction
from ml_model.recommendations.budget_advice import generate as budget_advice
from ml_model.recommendations.investment_tip import generate as investment_tip
from ml_model.recommendations.saving_suggestion import generate as saving_suggestion
from ml_model.recommendations.risk_alert import generate as risk_alert


# =====================================================
# PRIORITY WEIGHTING ENGINE
# =====================================================

PRIORITY_TO_SCORE = {
    "high":   3,
    "medium": 2,
    "low":    1
}

SCORE_TO_PRIORITY = {
    3: "high",
    2: "medium",
    1: "low"
}


def calculate_priority(rec, financial_metrics):

    rec_type = rec["recommendation_type"]
    score = PRIORITY_TO_SCORE.get(rec["priority"], 1)

    predicted_profit   = financial_metrics["predicted_profit"]
    expense_ratio      = financial_metrics["expense_ratio"]
    expense_growth     = financial_metrics["expense_growth"]
    revenue_growth     = financial_metrics["revenue_growth"]
    budget_utilization = financial_metrics["budget_utilization"]

    # =====================================================
    # CONTEXT BOOSTS — TYPE SPECIFIC
    # Each type only reacts to signals relevant to it.
    # =====================================================

    if rec_type == "risk_alert":

        if predicted_profit < 0:
            score += 1

        if expense_ratio > 80:
            score += 1

    elif rec_type == "expense_reduction":

        if predicted_profit < 0:
            score += 1

        if expense_growth > 30:
            score += 1

    elif rec_type == "budget_advice":

        if budget_utilization > 100:
            score += 1

        if expense_ratio > 80:
            score += 1

    elif rec_type == "saving_suggestion":

        if predicted_profit < 0:
            score += 1

    elif rec_type == "investment_tip":

        # Downgrade investment tips under danger signals —
        # never recommend investing into a struggling business.
        if predicted_profit < 0:
            score -= 1

        if revenue_growth < 0:
            score -= 1

    # =====================================================
    # CLAMP SCORE BETWEEN 1 AND 3
    # =====================================================

    score = max(1, min(3, score))

    return SCORE_TO_PRIORITY[score]


# =====================================================
# MAIN ENGINE
# =====================================================

def generate_and_store_recommendations(user_id):

    financial_metrics = get_financial_metrics(user_id)

    modules = [
        risk_alert,
        expense_reduction,
        budget_advice,
        investment_tip,
        saving_suggestion
    ]

    recommendations = []
    silent_modules = []

    # =====================================================
    # STEP 1: RUN MODULES
    # =====================================================

    for module in modules:

        results = module(financial_metrics)

        module_name = module.__name__

        # CASE 1: module produced recommendations
        if results:
            for r in results:
                r["priority"] = calculate_priority(
                    r,
                    financial_metrics
                )
                recommendations.append(r)

        # CASE 2: module was silent
        else:
            silent_modules.append(module_name)

    # =====================================================
    # STEP 2: GLOBAL FALLBACK (ONLY IF EVERYTHING IS EMPTY)
    # =====================================================

    if not recommendations:
        recommendations.append({
            "recommendation_type": "saving_suggestion",
            "message": "All financial modules report stable conditions. No actions required.",
            "priority": "low"
        })

    # =====================================================
    # STEP 3: PARTIAL SILENCE INSIGHT
    # =====================================================

    elif len(silent_modules) > 0:
        recommendations.append({
            "recommendation_type": "saving_suggestion",
            "message": f"{len(silent_modules)} modules found no actionable insights.",
            "priority": "low"
        })

    # =====================================================
    # STEP 4: PHASE 1 — GUARANTEED SLOT PER MODULE
    # Every module gets at least one recommendation
    # in the final output — no module is silenced.
    # =====================================================

    TOTAL_LIMIT = 10

    seen_types = set()
    guaranteed = []
    leftover = []

    for r in recommendations:
        rec_type = r["recommendation_type"]
        if rec_type not in seen_types:
            guaranteed.append(r)
            seen_types.add(rec_type)
        else:
            leftover.append(r)

    # =====================================================
    # STEP 5: PHASE 2 — FILL REMAINING SLOTS BY PRIORITY
    # Best of the leftover fill remaining slots,
    # highest priority first.
    # =====================================================

    priority_order = {"high": 0, "medium": 1, "low": 2}

    leftover_sorted = sorted(
        leftover,
        key=lambda x: priority_order[x["priority"]]
    )

    remaining_slots = TOTAL_LIMIT - len(guaranteed)

    final_recommendations = (
        guaranteed
        + leftover_sorted[:remaining_slots]
    )

    # =====================================================
    # STEP 6: STORE IN DATABASE
    # =====================================================

    with engine.begin() as conn:
        for rec in final_recommendations:
            conn.execute(
                """
                INSERT INTO ai_recommendations
                (user_id, recommendation_type, message, priority, created_at)
                VALUES (%s, %s, %s, %s, NOW())
                """,
                (
                    user_id,
                    rec["recommendation_type"],
                    rec["message"],
                    rec["priority"]
                )
            )

    return final_recommendations