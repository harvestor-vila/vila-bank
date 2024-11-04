import yaml
from stage3_checker import item_checker_fixer
from openai import OpenAI
from utils import find_part1_substring
import time

def main():
    start_time = time.time()
    # Read yaml config file
    with open("config_files/config_stage_3.yaml", "r") as file:
        parameters = yaml.safe_load(file)

    with open("config_files/config_stage_2.yaml", "r") as file:
        more_parameters = yaml.safe_load(file)

    client = OpenAI()
    MODEL = parameters["gpt_model"]

    loop_counter = 0
    error_counter = 0
    for context in more_parameters["context"]:
        context_temp = context.replace(" ", "_")
        for chart_type, tasks in more_parameters["pairs"].items():
            for task in tasks:
                python_code_file = open(
                    f"generated_code_session_1/{chart_type}-{context_temp}.R", "r"
                )
                python_code = python_code_file.read()

                dataset_file = open(
                    f"generated_dataset_session_1/{chart_type}-{context_temp}.txt", "r"
                )
                dataset = dataset_file.read()

                task_temp = task.replace(" ", "_")

                item_text_file = open(
                    f"generated_text_session_2/{chart_type}-{task_temp}-{context_temp}.txt",
                    "r",
                )
                item_text = item_text_file.read()

                print("Working to create a new item")
                loop_counter = loop_counter + 1
                print("THIS IS LOOP #", loop_counter)
                message = item_checker_fixer(
                    model=MODEL,
                    system_text=parameters["system_text"],
                    user_text_1=parameters["user_text_1"],
                    user_text_2=parameters["user_text_2"],
                    user_text_3=parameters["user_text_3"],
                    assistant_text_1=parameters["assistant_text_1"],
                    assistant_text_2=parameters["assistant_text_2"],
                    item_text=item_text,
                    python_code=python_code,
                    dataset=dataset,
                    task=task,
                    task_description=more_parameters["task_dict"][task],
                )

                # save question stem, options, correct answer to txt file
                chart_type_temp = chart_type.replace(" ", "_")
                task_temp = task.replace(" ", "_")

                cleaned_message = find_part1_substring(message)

                saved_message = open(
                    f"generated_text_session_3/{chart_type_temp}-{task_temp}-{context_temp}.txt",
                    "w",
                )
                saved_message.write(cleaned_message)
                saved_message.close()

                try:
                    print("This is success #", loop_counter - error_counter)
                except Exception:
                    print("Error occured. Moving on.")
                    error_counter = error_counter + 1
                    print("THIS IS error #", error_counter)
                    pass

    end_time = time.time()
    execution_time = end_time - start_time
    print(execution_time)
main()
