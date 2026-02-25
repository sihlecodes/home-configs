# created: 2 March 2026

import subprocess

def fuzzy_find(pattern: str, entries: list[str], break_char: str = "") -> list[str]:
    pattern = pattern[::-1].lower()
    matches: set = set()

    for entry in entries:
        distance: int = 0
        stretch: int = 0  # sort priority
        index: int = len(pattern) - 1
        pattern_char: str = pattern[index]

        for entry_char in entry.lower():
            if break_char and entry_char == break_char:
                break

            if entry_char == pattern_char:
                stretch += distance

                if index == 0:
                    matches.add((entry, stretch))
                    break

                distance = 0
                index -= 1
                pattern_char = pattern[index]

            distance += 1

    by_best_match = sorted(matches, key=lambda x: x[1])
    return list(map(lambda x: x[0], by_best_match))


def _default_choose(options: list[str]) -> str:
    for i, option in enumerate(options):
        print(f"{i}: {option}")

    length = len(options) - 1
    choice = -1

    while choice < 0 or choice > length:
        choice_str: str = input(f"\nChoose (0-{length}): ")

        if not choice_str.isdigit():
            return ""

        choice: int = int(choice_str)

        if choice < 0 or choice > length:
            return ""

    return options[choice]

def _gum_choose(options: list[str]) -> str:
    choice = subprocess.run(["gum", "choose", *options],
                            stdout=subprocess.PIPE, text=True)
    return choice.stdout

def choose(options: list[str]) -> str:
    if subprocess.run(["which", "gum"], capture_output=True).returncode == 0:
        return _gum_choose(options)

    return _default_choose(options)

