# This is the Stage 3: Checker 
# The function in the file checks the item and regenerates its textual component if mistakes are detected

from openai import OpenAI

client = OpenAI()

def item_checker_fixer(
    model,
    system_text,
    user_text_1,
    user_text_2,
    user_text_3,
    assistant_text_1,
    assistant_text_2,
    item_text,
    dataset,
    python_code,
    task,
    task_description,
):
    completion = client.chat.completions.create(
        model=model,
        messages=[
            {
                "role": "system",
                "content": system_text,
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": user_text_1.format(
                            item_text=item_text,
                            task=task,
                            task_description=task_description,
                        ),
                    },
                ],
            },
            {
                "role": "assistant",
                "content": [
                    {"type": "text", "text": assistant_text_1},
                ],
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": user_text_2.format(
                            python_code=python_code,
                            dataset=dataset,
                        ),
                    },
                ],
            },
            {
                "role": "assistant",
                "content": [
                    {"type": "text", "text": assistant_text_2},
                ],
            },
            {
                "role": "user",
                "content": [
                    {"type": "text", "text": user_text_3},
                ],
            },
        ],
        max_tokens=1600,
        temperature=0.2,
        seed=257,
    )
    message = completion.choices[0].message.content
    return message
