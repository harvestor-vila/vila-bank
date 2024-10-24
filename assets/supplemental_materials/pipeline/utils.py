# This file contains util helper functions for formatting outputs

def extract_between_parts(text, start_part, end_part):
    lines = text.splitlines()
    start_index = end_index = -1

    # Find the index of the line that contains the start and end parts
    for i, line in enumerate(lines):
        if start_part in line and start_index == -1:
            start_index = i
        elif end_part in line and start_index != -1:
            end_index = i
            break

    # Extract and return the substring between these lines
    if start_index != -1 and end_index != -1:
        return "\n".join(lines[start_index + 1 : end_index])
    else:
        return "The specified parts were not found in the text."

def find_part1_substring(s):
    # Find the start index of "part 1:" in the string
    start_index = s.find("part 1:")
    # If "part 1:" is not found, return an empty string
    if start_index == -1:
        return ""
    # Return the substring starting from "part 1:" to the end of the string
    return s[start_index:]