# Define source and target branches

MODEL=${1:-"gpt-4o"}
PR_BRANCH=${2:-"dev"}
TARGET_BRANCH=${3:-"dev"}


git fetch --all

# Get the diff and truncate if necessary
cr_diff_message=$(git diff origin/$TARGET_BRANCH..$PR_BRANCH)
max_tokens=100000
cr_diff_truncated=$(echo "$cr_diff_message" | head -c $max_tokens)

if [ -z "$cr_diff_message" ]; then
    echo "No diff returned. Exiting."
    exit 0
fi

# Add warning if diff was truncated
if [ ${#cr_diff_message} -gt $max_tokens ]; then
    cr_diff_truncated+=$'\n\n[Note: Diff was truncated due to size limitations]'
fi

instructions=$(llm -m $MODEL "Perform a code review on the following diff:
$cr_diff_truncated

Instructions:
1. Analyze each file in the diff separately.
2. For each file, provide the file name followed by a list of *only important recommendations*.
3. Each recommendation should be on a single line.
4. Focus on critical code quality issues, best practices, and potential problems.
5. Be concise and specific in your recommendations; mention only significant points.

Output format:
[File name]
- Recommendation 1
- Recommendation 2
...

Please provide only the code review output, no additional commentary.")

echo "$instructions"