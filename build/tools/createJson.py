import os
import sys
import json

DEVICE = sys.argv[1]
ELIXIR_BUILD_TYPE = sys.argv[2]
PRODUCT_OUT = sys.argv[3]
FILE_NAME = sys.argv[4]
DEVICES_DIR = "./vendor/ElixirDevices/builds"

def execute(command):
    return os.popen(command).read().strip()

def get_all_devices():
    return [file.replace(".json", "") for file in os.listdir(DEVICES_DIR) if file.endswith(".json")]

def is_supported_device(device):
    return device in get_all_devices()

def get_device_info(device):
    device_file_path = os.path.join(DEVICES_DIR, f"{device}.json")
    DEVICE_NAME, CODENAME, MAINNTAINER, FORUM = "NEED TO FILL", device, "NEED TO FILL", "NEED TO FILL"
    if os.path.exists(device_file_path):
        try:
            with open(device_file_path, "r") as file:
                data = json.load(file)
                DEVICE_NAME = data.get("device_name", DEVICE_NAME)
                CODENAME = data.get("device", CODENAME)
                MAINNTAINER = data.get("tg_username", MAINNTAINER)
                FORUM = data.get("forum", FORUM)
        except json.JSONDecodeError:
            print(f"Error: Malformed JSON in {device_file_path}")
    ANDROID_VERSION = FILE_NAME.split("-")[1]
    DATE_TIME = execute(f"grep -n 'org.elixir.build_date_utc' {PRODUCT_OUT}/system/build.prop | cut -d'=' -f2")
    MD5 = execute(f"cat {PRODUCT_OUT}/{FILE_NAME}.md5sum | cut -d' ' -f1")
    SHA = execute(f"cat {PRODUCT_OUT}/{FILE_NAME}.sha256sum | cut -d' ' -f1")
    SIZE = execute(f"stat -c %s {PRODUCT_OUT}/{FILE_NAME}")
    DOWNLOAD_URL = f"https://private.projectelixiros.com/fifteen/{CODENAME}/{FILE_NAME}"
    return {
        "filename": FILE_NAME,
        "datetime": DATE_TIME,
        "size": SIZE,
        "url": DOWNLOAD_URL,
        "filehash": MD5,
        "version": ANDROID_VERSION,
        "id": SHA,
        "tg_username": MAINNTAINER,
        "device_name": DEVICE_NAME,
        "device": CODENAME,
        "forum": FORUM,
    }

def cook_json(device):
    print()
    JSON = "JSON file data for OTA support: "
    if ELIXIR_BUILD_TYPE != "OFFICIAL":
        JSON += "There is no official support for this device yet."
        print(JSON)
        return
    JSON += "Old json data found, generating json." if is_supported_device(device) else "Old json data not found, creating new json template."
    data = get_device_info(device)
    JSON_DATA = {
        "error": False,
        "filename": data["filename"],
        "datetime": data["datetime"],
        "size": data["size"],
        "url": data["url"],
        "filehash": data["filehash"],
        "version": data["version"],
        "id": data["id"],
        "tg_username": data["tg_username"],
        "device_name": data["device_name"],
        "device": data["device"],
        "forum": data["forum"],
        "is_active": True
    }
    output_json_path = os.path.join(PRODUCT_OUT, f"{device}_ota.json")
    with open(output_json_path, "w") as json_file:
        json.dump(JSON_DATA, json_file, indent=4)
    print(JSON)

cook_json(DEVICE)
