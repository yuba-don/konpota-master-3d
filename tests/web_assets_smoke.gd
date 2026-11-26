extends SceneTree

## Web版に必要な画像と日本語フォントが読み込めるかを確認するスモークテスト。
## ソースプロジェクトとエクスポート済み .pck の両方で実行する。

const IMAGE_PATHS: Array[String] = [
	"res://icon.svg",
]
const FONT_SETTING: String = "gui/theme/custom_font"
const EXPECTED_FONT_PATH: String = "res://assets/fonts/NotoSansJP-Regular.otf"
const JAPANESE_SAMPLE: String = "コンポタージュ調理中！温度"


func _initialize() -> void:
	var errors: Array[String] = []
	for path in IMAGE_PATHS:
		errors.append_array(_check_image(path))
	errors.append_array(_check_font())

	if errors.is_empty():
		print("web_assets_smoke: OK")
		quit(0)
		return

	for message in errors:
		push_error("web_assets_smoke: " + message)
	quit(1)


func _check_image(path: String) -> Array[String]:
	var texture: Texture2D = load(path) as Texture2D
	if texture == null:
		return ["画像を読み込めない: %s" % path]

	var image: Image = texture.get_image()
	if image == null or image.is_empty():
		return ["画像データが空: %s" % path]
	if image.get_width() <= 0 or image.get_height() <= 0:
		return ["画像サイズが不正: %s" % path]
	return []


func _check_font() -> Array[String]:
	var font_path: String = str(ProjectSettings.get_setting(FONT_SETTING, ""))
	if font_path != EXPECTED_FONT_PATH:
		return ["%s が %s ではない: '%s'" % [FONT_SETTING, EXPECTED_FONT_PATH, font_path]]

	var font: Font = load(font_path) as Font
	if font == null:
		return ["フォントを読み込めない: %s" % font_path]

	var errors: Array[String] = []
	for character in JAPANESE_SAMPLE:
		if not font.has_char(character.unicode_at(0)):
			errors.append("フォントにグリフがない: '%s'" % character)
	return errors
