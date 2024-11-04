import random

random.seed(1)
contexts = [
    "health",
    "population_and_demography",
    "energy_and_environment",
    "weather_and_climate",
    "food_and_agriculture",
    "economy",
    "politics",
    "education",
    "innovation",
]

chart_types = [
    "line_chart",
    "bar_chart",
    "stacked_bar_chart",
    "100_percent_stacked_bar_chart",
    "pie_chart",
    "histogram",
    "scatterplot",
    "area_chart",
    "stacked_area_chart",
    "bubble_chart",
    "choropleth_map",
    "tree_map",
]

tasks = [
    "make comparisons",
    "identify range",
    "retrieve value",
    "locate value",
    "identify labels of scales",
    "describe the topic of the visualization",
    "estimate the difference between two values of the same type",
    "estimate the ratio of one value to another value of the same type",
    "estimate the average of multiple values of the same type",
    "describe trend or correlation",
    "describe the characteristics of an alternative chart type",
    "judge which visualization design is more appropriate for a task",
    "judge which task this visualization design best supports",
]

for index in range(0, len(tasks)):
    tasks[index] = tasks[index].replace(" ", "_")


# 156
combined_chart_task = []

for chart in chart_types:
    for task in tasks:
        chart_task = chart + "-" + task
        combined_chart_task.append(chart_task)

# randomly select context for each of the 156
combined_chart_task_context = []
random_contexts = []
for element in combined_chart_task:
    selected_context = random.choice(contexts)
    random_contexts.append(selected_context)
    chart_task_context = element + "-" + selected_context
    combined_chart_task_context.append(chart_task_context)

context_dict = {}
for c in random_contexts:
    if c not in context_dict:
        context_dict[c] = 0
    context_dict[c] += 1

# randomly select from the 156 for each context
remaining = combined_chart_task
evenish_selection = []
for context in contexts:
    for i in range(0, 17):
        select_chart_task = random.choice(remaining)
        chart_task_context_selected = select_chart_task + "-" + context
        remaining.remove(select_chart_task)
        evenish_selection.append(chart_task_context_selected)

for element in remaining:
    selected_context = random.choice(contexts)
    chart_task_context = element + "-" + selected_context
    evenish_selection.append(chart_task_context)

check_contexts = []
for element in evenish_selection:
    get_context = element.split("-")[2]
    check_contexts.append(get_context)

context_dict = {}
for c in check_contexts:
    if c not in context_dict:
        context_dict[c] = 0
    context_dict[c] += 1

with open("156_names.txt", "w") as f:
    for element in evenish_selection:
        filename = element + ".txt"
        f.write(filename)
        f.write(", ")
