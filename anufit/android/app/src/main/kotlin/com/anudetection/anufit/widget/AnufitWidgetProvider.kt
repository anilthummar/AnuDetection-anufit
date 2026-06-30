package com.anudetection.anufit.widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import com.anudetection.anufit.R

class AnufitWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.content.SharedPreferences,
    ) {
        val steps = widgetData.getInt("steps", 0)
        val goal = widgetData.getInt("goal", 10000)
        val waterMl = widgetData.getInt("water_ml", 0)
        val weightKg = widgetData.getFloat("weight_kg", 0f)
        val progress = (widgetData.getFloat("goal_progress", 0f) * 100).toInt()

        appWidgetIds.forEach { widgetId ->
            val layout = when {
                widgetId % 3 == 0 -> R.layout.anufit_widget_large
                widgetId % 2 == 0 -> R.layout.anufit_widget_medium
                else -> R.layout.anufit_widget_small
            }
            val views = RemoteViews(context.packageName, layout)
            views.setTextViewText(R.id.widget_steps, "$steps")
            views.setTextViewText(R.id.widget_goal, "/ $goal")
            views.setTextViewText(R.id.widget_progress, "$progress%")
            views.setTextViewText(R.id.widget_water, "${waterMl}ml")
            views.setTextViewText(R.id.widget_weight, "${"%.1f".format(weightKg)}kg")
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
