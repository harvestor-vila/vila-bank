import yaml
import time
import subprocess
from stage1_generator import dataset_viz_generator
from openai import OpenAI
from utils import (
    extract_between_parts,
)

def main():
    start_time = time.time()
    # Read yaml config file
    with open("config_files/config_stage_1.yaml", "r") as file:
        parameters = yaml.safe_load(file)

    client = OpenAI()
    MODEL = parameters["gpt_model"]

    error_counter = 0
    loop_counter = 0
    for context in parameters["context"]:
        for chart_type, content in parameters["chart_type"].items():
            chart_type_specific_requirements = content
            throw_error = False
            while True:
                message = dataset_viz_generator(
                    model=MODEL,
                    chart_type=chart_type,
                    context=context,
                    chart_type_specific_requirements=chart_type_specific_requirements,
                    prompt=parameters["prompt"],
                )
                vis_code = extract_between_parts(message, "```R", "```")
                chart_type_temp = chart_type.replace(" ", "_")
                context_temp = context.replace(" ", "_")

                saved_message = open(
                    f"generated_code_session_1/{chart_type_temp}-{context_temp}.R",
                    "w",
                )
                saved_message.write(vis_code)
                saved_message.close()

                try:
                    # Execute the read code
                    subprocess.run(
                        f"/PATHTORSCRIPT/Rscript --vanilla generated_code_session_1/{chart_type_temp}-{context_temp}.R",
                        shell=True,
                        check=True,
                    )
                    print("This is success #", loop_counter - error_counter)
                    throw_error = False
                except subprocess.CalledProcessError:
                    print("Error occured. Remaking another one!")
                    error_counter = error_counter + 1
                    print("THIS IS error #", error_counter)
                    throw_error = True
                    pass
                if throw_error == False:
                    break
    end_time = time.time()
    execution_time = end_time - start_time
    print(execution_time)
main()
