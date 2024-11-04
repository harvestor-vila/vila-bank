# This is Stage 1: Generator 
# The function in the file generates the dataset and the data viz
import random
from openai import OpenAI

client = OpenAI()

def dataset_viz_generator(
    model,
    chart_type,
    context,
    prompt,
    chart_type_specific_requirements,
):
    trends = ["an increasing trend", "a decreasing trend", "no trend"]
    trend = random.choice(trends)
    correlations = [
        "a positive correlation",
        "a negative correlation",
        "no correlation",
    ]
    correlation = random.choice(correlations)
    skews = ["left skewed", "right skewed", "symmetric"]
    skew = random.choice(skews)
    temp_text = chart_type_specific_requirements.format(
        trend=trend, correlation=correlation, skew=skew
    )
    completion = client.chat.completions.create(
        model=model,
        messages=[
            {
                "role": "system",
                "content": prompt["system_text"],
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": prompt["user_text_1"].format(
                            chart_type=chart_type,
                            context=context,
                        ),
                    },
                ],
            },
            {
                "role": "assistant",
                "content": [
                    {"type": "text", "text": prompt["assistant_text_1"]},
                ],
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": prompt["user_text_2"].format(
                            chart_type=chart_type,
                            chart_type_specific_requirements=temp_text,
                        ),
                    },
                ],
            },
            {
                "role": "assistant",
                "content": [
                    {"type": "text", "text": prompt["assistant_text_2"]},
                ],
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": prompt["user_text_3"].format(
                            chart_type=chart_type,
                            context=context,
                        ),
                    },
                ],
            },
        ],
        max_tokens=1000,
        seed=257,
        temperature=0.2,
    )
    message = completion.choices[0].message.content
    return message
