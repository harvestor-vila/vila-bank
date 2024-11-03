# This is Stage 2: Composer 
# The function in the file generates the textual component
from openai import OpenAI

client = OpenAI()

def viz_item_generator(
    model,
    task,
    task_description,
    r_code,
    dataset,
    prompt,
):
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
                            r_code=r_code,
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
                            dataset=dataset,
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
                            task=task,
                            task_description=task_description,
                        ),
                    },
                ],
            },
        ],
        max_tokens=1600,  
        temperature=0.2,
        seed=798,
    )
    message = completion.choices[0].message.content
    return message
