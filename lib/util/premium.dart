import 'package:flutter/cupertino.dart';

import 'package:pvpn/sections/premium/plan_free/page.dart';
import 'package:pvpn/sections/premium/plan_month/page.dart';
import 'package:pvpn/sections/premium/plan_year/page.dart';

class Premium {
  static const planFree = 0;
  static const planMonth = 1;
  static const planYear = 2;

  static int tariffPlan = planFree;

  static bool get isFreePlan => tariffPlan == planFree;

  static Widget getTariffPlanPage() {
    switch (tariffPlan) {
      case planMonth:
        return const PlanMonthPage();
      case planYear:
        return const PlanYearPage();
      default:
        return const PlanFreePage();
    }
  }
}