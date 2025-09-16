extends Node

var profiles = {}
var current_user = ""
const profiles_file = "user://profiles.json"

func _ready():
    load_profiles()

# -------------------
# SALVAR / CARREGAR
# -------------------
func load_profiles():
    var f = File.new()
    if f.file_exists(profiles_file):
        f.open(profiles_file, File.READ)
        var text = f.get_as_text()
        profiles = parse_json(text)
        f.close()
    else:
        profiles = {}

func save_profiles():
    var f = File.new()
    f.open(profiles_file, File.WRITE)
    f.store_string(to_json(profiles))
    f.close()

# -------------------
# FUNÇÕES DE LOGIN
# -------------------
func criacao_de_conta(username, password):
    if username in profiles:
        return false # já existe

    var salt = str(OS.get_unix_time())
    var hashed = _hash(password, salt)
    profiles[username] = {
        "password": hashed,
        "salt": salt,
        "highscore": 0
    }
    save_profiles()
    return true

func login(username, password):
    if not (username in profiles):
        return false

    var salt = profiles[username]["salt"]
    var hashed = _hash(password, salt)
    if hashed == profiles[username]["password"]:
        current_user = username
        return true
    return false

func get_username():
    return current_user

func get_highscore():
    if current_user != "" and current_user in profiles:
        return profiles[current_user]["highscore"]
    return 0

func set_highscore(value):
    if current_user != "" and current_user in profiles:
        profiles[current_user]["highscore"] = value
        save_profiles()

# -------------------
# HASH SIMPLES
# -------------------
func _hash(password, salt):
    return String(password + salt).sha256_text()
