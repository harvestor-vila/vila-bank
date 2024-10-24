import yaml
from stage2_composer import viz_item_generator
from openai import OpenAI
from utils import find_part1_substring
import time


def main():
    start_time = time.time()
    # Read yaml config file
    with open("config_files/config_stage_2.yaml", "r") as file:
        parameters = yaml.safe_load(file)

    client = OpenAI()
    MODEL = parameters["gpt_model"]
    error_counter = 0
    loop_counter = 0
    for context in parameters["context"]:
        context_temp = context.replace(" ", "_")
        for chart_type, tasks in parameters["pairs"].items():
            for task in tasks:
                # Open the file in read mode
                with open(
                    f"generated_code_session_1/{chart_type}-{context_temp}.R", "r"
                ) as file:
                    # Read the contents of the file
                    code = file.read()

                dataset_file = open(
                    f"generated_dataset_session_1/{chart_type}-{context_temp}.txt", "r"
                )
                dataset = dataset_file.read()

                print("Working to create a new item")
                loop_counter = loop_counter + 1
                print("THIS IS LOOP #", loop_counter)
                message = viz_item_generator(
                    model=MODEL,
                    r_code=code,
                    dataset=dataset,
                    task=task,
                    task_description=parameters["task_dict"][task],
                    prompt=parameters["prompt"],
                )

                cleaned_message = find_part1_substring(message)

                # save question stem, options, correct answer to txt file
                chart_type_temp = chart_type.replace(" ", "_")
                task_temp = task.replace(" ", "_")

                saved_message = open(
                    f"generated_text_session_2/{chart_type_temp}-{task_temp}-{context_temp}.txt",
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
