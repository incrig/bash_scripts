mkdir ~/python/

cat <<EOF >~/python/app.py
import pyautogui
import time

try:
    print("Mouse controls are active. Press Ctrl+C to stop.")
    while True:
        # Get the current mouse position
        x, y = pyautogui.position()

        # Move the mouse slightly
        pyautogui.moveTo(x + 1, y + 1, duration=0.1)
        pyautogui.moveTo(x, y, duration=0.1)

        # Wait for a few seconds before repeating
        time.sleep(250)
except KeyboardInterrupt:
    print("Mouse controls stopped.")
EOF

cd ~/python/
python3 -m venv app
source app/bin/activate
pip3 install --upgrade pip pyautogui

cat <<EOF >~/python/runner.sh
source ~/python/app/bin/activate && python ~/python/app
EOF
