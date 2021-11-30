#! /bin/sh

SESSION="$(cat .session-cookie)"

YEAR="$(date +%Y)"
DAY="$(date +%d)"

curl -s --compressed "https://adventofcode.com/$YEAR/day/$(echo $DAY | sed 's/^0//')/input" -H "Cookie: session=$SESSION" > "$DAY.input"

if ! [ -f "${DAY}_1.py" ] && ! [ -f "${DAY}_2.py" ]; then
    cat <<EOF | tee "${DAY}_1.py" > "${DAY}_2.py"
#! /usr/bin/env python3

with open('$DAY.input', 'r') as file:
  for line in file:
    line = line.strip()
    print(line)
EOF
    chmod a+x "${DAY}_1.py" "${DAY}_2.py"
fi

emacs -nw +6 "${DAY}_2.py" +6 "${DAY}_1.py" --eval "(global-set-key [f9] (lambda () (interactive) (run-python) (windmove-up) (python-shell-send-buffer)))" --eval "(global-set-key [f10] 'python-shell-send-buffer)"
