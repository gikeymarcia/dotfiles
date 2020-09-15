#!/bin/bash
# Mikey Garcia, @gikeymarcia
# launch firefox with windows open for fastai course

links+=("https://pytorch.org/docs/stable/tensors.html?highlight=zero_#torch.Tensor.zero_")
links+=("http://localhost:8080/tree/fast-ai-for-coders/nbs/dl1")
links+=("https://forums.fast.ai/")
links+=("https://docs.conda.io/projects/conda/en/latest/commands.html#id1")
links+=("https://forums.fast.ai/t/lesson-3-official-resources-and-updates/29732")
links+=("https://forums.fast.ai/t/deep-learning-lesson-3-notes/29829")
links+=("https://forums.fast.ai/c/part1-v3/20")
#links+=("http://localhost:8080/tree")
#links+=("http://localhost:8080/notebooks/fast-ai-for-coders/nbs/dl1/lesson5-sgd-mnist--mikey.ipynb")
#links+=("http://localhost:8080/notebooks/fast-ai-for-coders/nbs/dl1/lesson3-planet--mikey.ipynb")

get_links () {
    for l in "${links[@]}"; do printf " %s " "$l"; done
}

# shellcheck disable=SC2046
firefox -private $(get_links) &
